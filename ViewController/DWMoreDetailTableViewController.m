//
//  DWMoreDetailTableViewController.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWMoreDetailTableViewController.h"
#import "DWMoreDetailTableViewCell.h"
#import "DWHotMusicViewModel.h"
#import "DWBoFangViewController.h"
#import "DWHotDetailModel.h"
#import "DWImageCenter.h"
#import "MBProgressHUD+MJ.h"
#import "DWPlayMusic.h"
#import "DWSongViewModel.h"
#import "DWToutiaoViewModel.h"
#import "DWMVViewModel.h"
#import "DwWebViewViewController.h"

@interface DWMoreDetailTableViewController ()
@property (nonatomic, strong) DWHotMusicViewModel *dwHotVM;
@property (nonatomic, strong) DWToutiaoViewModel *touVM;
@property (nonatomic, strong) DWHotDetailModel *hotModel;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) DWSongViewModel *songVM;
@property (nonatomic, strong) DWMVViewModel *mvVM;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@property (nonatomic, strong) DwWebViewViewController *webVC;
@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int refreshN;
@end

@implementation DWMoreDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshN = -1;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView registerNib:[UINib nibWithNibName:@"DWMoreDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"moreCell"];
    if (self.refreshN != self.session) {
        if (self.session == 5) {
            if ([self.type isEqualToString:@"2"]) {
                self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.touVM getDataFromNetCompleteHandle:^(NSError *error) {
                        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 150)];
                        [headerView sd_setImageWithURL:[NSURL URLWithString:[self.touVM getAlbModel].picS500] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.tableView.tableHeaderView = headerView;
                            });
                        }];
                        [self.hotArray removeAllObjects];
                        [self addDataForTouTiao];
                        [self.tableView reloadData];
                        [self.tableView.mj_header endRefreshing];
                    } withCode:self.code WithType:self.type];
                }];
                [self.tableView.mj_header beginRefreshing];
            }
            else{
                self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.touVM getDataFromNetCompleteHandle:^(NSError *error) {
                        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 150)];
                        [headerView sd_setImageWithURL:[NSURL URLWithString:[self.touVM getTouTiaoModelWith:self.code].pic500] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.tableView.tableHeaderView = headerView;
                            });
                        }];
                        [self.hotArray removeAllObjects];
                        [self addDataForTouTiao];
                        [self.tableView reloadData];
                        [self.tableView.mj_header endRefreshing];
                    } withCode:self.code WithType:self.type];
                }];
                [self.tableView.mj_header beginRefreshing];
            }
        }
        else if (self.session == 3) {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self.offset = 0;
                [self.dwHotVM getDataFromNetCompleteHandle:^(NSError *error) {
                    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 150)];
                    [headerView sd_setImageWithURL:[NSURL URLWithString:[self.dwHotVM getHotBillBoardModel].picS210] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.tableView.tableHeaderView = headerView;
                        });
                    }];
                    [self.hotArray removeAllObjects];
                    [self addData];
                    [self.tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                } withOffset:self.offset withType:self.session];
            }];
            [self.tableView.mj_header beginRefreshing];
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                if (self.hotArray.count > 99) {
                    [MBProgressHUD showError:@"没有更多歌曲！"];
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [self.dwHotVM getDataFromNetCompleteHandle:^(NSError *error) {
                        [self addData];
                        [self.tableView reloadData];
                        [self.tableView.mj_footer endRefreshing];
                    } withOffset:self.offset withType:self.session];
                }
            }];
            [self.tableView.mj_footer beginRefreshing];
        }
        else
        {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self.offset = 0;
                [self.dwHotVM getDataFromNetCompleteHandle:^(NSError *error) {
                    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 150)];
                    [headerView sd_setImageWithURL:[NSURL URLWithString:[self.dwHotVM getHotBillBoardModel].picS210] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.tableView.tableHeaderView = headerView;
                        });
                    }];
                    [self.hotArray removeAllObjects];
                    [self addData];
                    [self.tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                } withOffset:self.offset withType:self.session];
            }];
            [self.tableView.mj_header beginRefreshing];
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                if (self.hotArray.count > 99) {
                    [MBProgressHUD showError:@"没有更多歌曲！"];
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [self.dwHotVM getDataFromNetCompleteHandle:^(NSError *error) {
                        [self addData];
                        [self.tableView reloadData];
                        [self.tableView.mj_footer endRefreshing];
                    } withOffset:self.offset withType:self.session];
                }
            }];
            [self.tableView.mj_footer beginRefreshing];
        }

    }
        self.refreshN = self.session;
   }
-(void)addDataForTouTiao
{
    if ([self.type isEqualToString:@"2"]) {
        DWAlbumInfo *albModel = [self.touVM getAlbModel];
        NSArray *arr = [self.touVM getDataArr];
        for (DWSongList *songs in arr) {
            DWHotDetailModel *model = [DWHotDetailModel new];
            model.webURL = albModel.picSmall;
            model.hasMore = 1;
            model.title = songs.title;
            model.hasMV = songs.hasMvMobile;
            model.author = songs.author;
            model.picSmall = songs.picSmall;
            model.songId = songs.songId;
            model.resourceTyoe = songs.resourceType;
            if ([model.resourceTyoe isEqualToString:@"0"]) {
                [self.hotArray addObject:model];
            }
        }
    }
    else{
        DWTouTiaoModel *tmodel = [self.touVM getTouTiaoModelWith:self.code];
        NSArray *arr = [NSArray arrayWithArray:[self.touVM getContentListWith:self.code]];
        for (DWContentList *songs in arr) {
            DWHotDetailModel *model = [DWHotDetailModel new];
            model.webURL = tmodel.url;
            model.hasMore = 1;
            model.title = songs.title;
            model.hasMV = songs.hasMvMobile;
            model.author = songs.author;
            model.picSmall = nil;
            model.songId = songs.songId;
            model.resourceTyoe = songs.resourceType;
            if ([model.resourceTyoe isEqualToString:@"0"]) {
                [self.hotArray addObject:model];
            }
        }
    }
}
-(void)addData
{
    NSArray *arr = [NSArray arrayWithArray:[self.dwHotVM getHotMusicModel].songList];
    for (DWHotSonglistModel *songs in arr) {
        DWHotDetailModel *model = [DWHotDetailModel new];
        model.webURL = [self.dwHotVM getHotBillBoardModel].webUrl;
        model.hasMore = [self.dwHotVM getHotBillBoardModel].havemore;
        model.title = songs.title;
        model.hasMV = songs.hasMvMobile;
        model.author = songs.author;
        model.picSmall = songs.picSmall;
        model.songId = songs.songId;
        model.resourceTyoe = songs.resourceType;
        if ([model.resourceTyoe isEqualToString:@"0"]) {
            [self.hotArray addObject:model];
        }
    }
    self.offset += 15;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DWMoreDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    DWHotDetailModel *model = self.hotArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.authorLabel.text = model.author;
    UIImage *image= [ UIImage imageNamed:@"ic_playlist_mtv" ];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom ];
    CGRect frame = CGRectMake(0,0 , image.size.width , image.size.height );
    if (model.hasMV == 1)
    {
        button.frame = frame;
        [button setBackgroundImage:image forState:UIControlStateNormal ];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self
                   action:@selector(playMV:event:)
         forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    else
    {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;
    }
    if (model.picSmall != nil) {
        //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
        DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
        UIImage *storedImage = sharedImageCenter.cachedImages[model.picSmall];
        if (storedImage == nil) {
            dispatch_queue_t queue = dispatch_queue_create("hotDetailQueue", NULL);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.picSmall]]];
                sharedImageCenter.cachedImages[model.picSmall] = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.musicImageView.image = image;
                    [self.tableView reloadData];
                });
            });
        }
        else
        {
            cell.musicImageView.image = storedImage;
        }

    }
    else
    {
        cell.musicImageView.image = [UIImage imageNamed:@"DWbig"];
    }
    return cell;
}
-(void)playMV:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if(indexPath != nil)
    {
        DWHotDetailModel *model = self.hotArray[indexPath.row];
        [self.mvVM getMVDataFromNetCompleteHandle:^(NSError *error) {
            NSLog(@"%@",model.songId);
            if (![self.webVC.url isEqualToString:[self.mvVM getSourcePath]])
            {
                self.webVC.url = [self.mvVM getSourcePath];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:self.webVC animated:YES];
                });
            }
        } WithSongID:model.songId];
    }
}
#pragma mark - Table View Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWHotDetailModel *hotModel = self.hotArray[indexPath.row];
    [self.songVM getDataFromNetCompleteHandle:^(NSError *error) {
        NSMutableArray *mArr = [NSMutableArray new];
        DWPlayMusic *music = [DWPlayMusic new];
        DWSongUrl *songurl = [self.songVM geturlForSongid:hotModel.songId];
        DWSongModel *songModel = [self.songVM getsongModelForSongid:hotModel.songId];
        music.title = hotModel.title;
        music.author = hotModel.author;
        music.songId = hotModel.songId;
        music.pic = [NSURL URLWithString:songModel.picPremium];
        music.lrcname = [NSURL URLWithString:songModel.lrclink];
        music.songurl = [NSURL URLWithString:songurl.fileLink];
        music.showLink = [NSURL URLWithString:songModel.shareUrl];
        [mArr addObject:music];
        self.bfVC.songLists = [mArr copy];
        self.bfVC.index = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bfVC show];
        });
    } withSongId:hotModel.songId];
}
- (DWHotMusicViewModel *)dwHotVM {
	if(_dwHotVM == nil) {
		_dwHotVM = [[DWHotMusicViewModel alloc] init];
	}
	return _dwHotVM;
}

- (DWHotDetailModel *)hotModel {
	if(_hotModel == nil) {
		_hotModel = [[DWHotDetailModel alloc] init];
	}
	return _hotModel;
}

- (NSMutableArray *)hotArray {
	if(_hotArray == nil) {
		_hotArray = [[NSMutableArray alloc] init];
	}
	return _hotArray;
}
- (DWSongViewModel *)songVM {
    if(_songVM == nil) {
        _songVM = [[DWSongViewModel alloc] init];
    }
    return _songVM;
}
- (DWBoFangViewController *)bfVC {
    if(_bfVC == nil) {
        _bfVC = [[DWBoFangViewController alloc] initWithNibName:@"DWBoFangViewController" bundle:nil];
    }
    return _bfVC;
}
- (DWToutiaoViewModel *)touVM {
	if(_touVM == nil) {
		_touVM = [[DWToutiaoViewModel alloc] init];
	}
	return _touVM;
}

- (DWMVViewModel *)mvVM {
	if(_mvVM == nil) {
		_mvVM = [[DWMVViewModel alloc] init];
	}
	return _mvVM;
}

- (DwWebViewViewController *)webVC {
	if(_webVC == nil) {
		_webVC = [[DwWebViewViewController alloc] init];
	}
	return _webVC;
}

@end
