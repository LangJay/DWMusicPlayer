//
//  DWRecommendMusicViewController.m
//  逗我
//
//  Created by 周继良 on 15/11/11.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRecommendMusicViewController.h"
#import "DWHeaderViewController.h"
#import "UIImage+Circle.h"
#import "DWRecommendViewModel.h"
#import "DWRecommendTableViewCell.h"
#import "DWImageCenter.h"
#import "DWBoFangViewController.h"
#import "DWMusic.h"
#import "DWSongViewModel.h"
#import "DWDownloadMusic.h"
#import "MBProgressHUD+MJ.h"
#import "DWPlayMusic.h"

@interface DWRecommendMusicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DWRecommendViewModel *recommendVM;
@property (nonatomic, strong) DWHeaderViewController *hVC;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@property (nonatomic, strong) DWSongViewModel *songVM;
@end

@implementation DWRecommendMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hVC = [[DWHeaderViewController alloc] init];
    self.hVC.view.frame = CGRectMake(0, 68, self.view.frame.size.width, 80);
    [self.view addSubview:self.hVC.view];
    [self addChildViewController:self.hVC];
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.recommendVM refreshDataCompletionHandle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }];
    }];
    [_tableView.mj_header beginRefreshing];
}
-(void)setHeaderView
{
    NSInteger num = [self.recommendVM rowNumber];
    if (num > 0) {
        [self.hVC.imageView1 sd_setImageWithURL:[self.recommendVM smallPicForRow:0]];
        if (num > 1)
        {
            [self.hVC.imageView3 sd_setImageWithURL:[self.recommendVM smallPicForRow:1]];
            if (num > 2) {
                [self.hVC.imageView2 sd_setImageWithURL:[self.recommendVM smallPicForRow:2]];
            }
        }
    }
}
#pragma mark - tableView数据源代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recommendVM rowNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSInteger num = [self.recommendVM rowNumber];
        for (NSInteger index = 0; index < num; index ++ ) {
            [self.songVM getDataFromNetCompleteHandle:^(NSError *error) {
            } withSongId:[self.recommendVM songIDForRow:index]];
        }
    });
    //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
    DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
    UIImage *storedImage = sharedImageCenter.cachedImages[[self.recommendVM smallPicForRow:indexPath.row].absoluteString];
    if (storedImage == nil) {
        dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.recommendVM smallPicForRow:indexPath.row]]];
            image = [UIImage scaleTosize:image size:CGSizeMake(cell.bounds.size.height - 20, cell.bounds.size.height - 20)];
            sharedImageCenter.cachedImages[[self.recommendVM smallPicForRow:indexPath.row].absoluteString] = image;
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage circleImageWithImage:image borderWidth:4 borderColor:kBackGroundColor];
                [self.tableView reloadData];
            });
        });
    }
    else
    {
        storedImage = [UIImage scaleTosize:storedImage size:CGSizeMake(cell.bounds.size.height - 20, cell.bounds.size.height - 20)];
        cell.imageView.image = [UIImage circleImageWithImage:storedImage borderWidth:2 borderColor:kBackGroundColor];;
    }
    cell.textLabel.text = [self.recommendVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.recommendVM authorForRow:indexPath.row];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"xiazaihei.png"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;
    [button addTarget:self action:@selector(btnClicked:Withevent:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor= [UIColor clearColor];
    cell.accessoryView = button;
    [self setHeaderView];
    return cell;
}

- (void)btnClicked:(id)sender Withevent:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        DWMusic *music = [DWMusic new];
        music.title = [self.recommendVM ListArrayForRow:indexPath.row].title;
        music.author = [self.recommendVM ListArrayForRow:indexPath.row].author;
        music.songId = [self.recommendVM ListArrayForRow:indexPath.row].songId;
        music.pic = [self.recommendVM ListArrayForRow:indexPath.row].picPremium;
        music.lrcname = [self.songVM getsongModelForSongid:[self.recommendVM ListArrayForRow:indexPath.row].songId].lrclink;
        music.songurl = [self.songVM geturlForSongid:[self.recommendVM ListArrayForRow:indexPath.row].songId].fileLink;
        music.showLink = [self.songVM getsongModelForSongid:[self.recommendVM ListArrayForRow:indexPath.row].songId].shareUrl;;
        NSMutableArray *mArr = [NSMutableArray new];
        [mArr addObject:music];
        [DWDownloadMusic downloadMusicsWith:mArr];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (DWRecommendViewModel *)recommendVM {
	if(_recommendVM == nil) {
		_recommendVM = [[DWRecommendViewModel alloc] init];
	}
	return _recommendVM;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *mArr = [NSMutableArray new];
        for (NSInteger index = 0; index < [self.recommendVM rowNumber]; index ++ ) {
            DWPlayMusic *music = [DWPlayMusic new];
            music.title = [self.recommendVM ListArrayForRow:index].title;
            music.author = [self.recommendVM ListArrayForRow:index].author;
            music.songId = [self.recommendVM ListArrayForRow:index].songId;
            music.pic = [NSURL URLWithString:[self.songVM getsongModelForSongid:[self.recommendVM ListArrayForRow:index].songId].picPremium];
            music.lrcname = [NSURL URLWithString:[self.songVM getsongModelForSongid:[self.recommendVM ListArrayForRow:index].songId].lrclink];
            music.songurl = [NSURL URLWithString:[self.songVM geturlForSongid:[self.recommendVM ListArrayForRow:index].songId].fileLink];
            music.showLink = [NSURL URLWithString:[self.songVM getsongModelForSongid:[self.recommendVM ListArrayForRow:index].songId].shareUrl];
            [mArr addObject:music];
        }
        self.bfVC.songLists = [mArr copy];
    });
    self.bfVC.index = indexPath.row;
    [self.bfVC show];
}
- (IBAction)click:(id)sender {
    [self.bfVC pushViewFromView];
}

- (DWBoFangViewController *)bfVC {
	if(_bfVC == nil) {
		_bfVC = [[DWBoFangViewController alloc] initWithNibName:@"DWBoFangViewController" bundle:nil];
	}
	return _bfVC;
}

- (DWSongViewModel *)songVM {
	if(_songVM == nil) {
		_songVM = [[DWSongViewModel alloc] init];
	}
	return _songVM;
}

@end
