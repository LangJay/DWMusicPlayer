//
//  DWMoreMusicViewController.m
//  逗我
//
//  Created by 周继良 on 15/11/11.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWMoreMusicViewController.h"
#import "DWScrollCollectionViewCell.h"
#import "DWHotCollectionViewCell.h"
#import "DWHeaderCollectionReusableView.h"
#import "DWBoFangViewController.h"
#import "DWScrollModel.h"
#import "DWScrollViewModel.h"
#import "DWConstants.h"
#import "DWHotMusicViewModel.h"
#import "DWNewMusicViewModel.h"
#import "DWImageCenter.h"
#import "DWRadioViewModel.h"
#import "DWRadioNetmanager.h"
#import "DWMoreDetailTableViewController.h"
#import "DWMoreAudioCollectionViewController.h"
#import "DWRadioInfoViewModel.h"
#import "DWPlayMusic.h"
#import "DWSongViewModel.h"
#import "DwWebViewViewController.h"

@interface DWMoreMusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int isDownLoadedData;

@property (nonatomic, strong) DWScrollViewModel *DWScrollVM;
@property (nonatomic, strong) DWHotMusicViewModel *DWHotMusicVM;
@property (nonatomic, strong) DWNewMusicViewModel *DWNewMusicVM;
@property (nonatomic, strong) DWRadioViewModel *DWRadioVM;
@property (nonatomic, strong) DWRadioInfoViewModel *DWRadioInfoVM;
@property (nonatomic, strong) DWSongViewModel *songVM;

@property (nonatomic, strong) DWMoreDetailTableViewController *mdVC;
@property (nonatomic, strong) DWMoreAudioCollectionViewController *maVC;
@property (nonatomic, strong) DwWebViewViewController *webVC;
@end

@implementation DWMoreMusicViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isDownLoadedData = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DWHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DWScrollCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DWHotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isDownLoadedData = 0;
        //加载scrollView的数据
        [self.DWScrollVM getDataFromNetCompleteHandle:^(NSError *error) {
            self.isDownLoadedData ++;
            [_collectionView reloadData];
        }];
        [self.DWHotMusicVM getDataFromNetCompleteHandle:^(NSError *error) {
            self.isDownLoadedData ++;
            [_collectionView reloadData];
        } withOffset:0 withType:2];
        [self.DWNewMusicVM getDataFromNetCompleteHandle:^(NSError *error) {
            self.isDownLoadedData ++;
            [_collectionView reloadData];
        } withOffset:0 withType:1];
        [self.DWRadioVM getDataFromNetCompleteHandle:^(NSError *error) {
            self.isDownLoadedData ++;
            [_collectionView reloadData];
        }];
    }];
    [_collectionView.mj_header beginRefreshing];
}
-(void)startTimer
{
    CGRect viewFrame = [UIScreen mainScreen].bounds;
    if (self.pageControl.currentPage == [self.DWScrollVM getPicsNum] - 1) {
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else
    {
        CGRect rect = CGRectMake((viewFrame.size.width - 20) * (self.pageControl.currentPage + 1), 0, viewFrame.size.width - 20, (viewFrame.size.width * 3)/7);
        [self.scrollView setContentOffset:rect.origin animated:YES];
        self.pageControl.currentPage ++;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int index = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 20);
    self.pageControl.currentPage = index;
}
-(void)pushDetailView
{
    DWPicScrollModel *pic = [self.DWScrollVM getPicsFromDataByIndex:self.pageControl.currentPage];
    if ([pic.code hasPrefix:@"http"]) {
        self.webVC.url = pic.code;
        self.webVC.title = pic.randpicDesc;
        [self.navigationController pushViewController:self.webVC animated:YES];
    }
    else
    {
        self.mdVC.session = 5;
        self.mdVC.code = pic.code;
        self.mdVC.type = pic.type;
        self.mdVC.title = pic.randpicDesc;
        [self.navigationController pushViewController:self.mdVC animated:YES];
    }

}
-(DWScrollCollectionViewCell *)setMyCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    // 配置pageControl
    cell.pageControl.numberOfPages =[self.DWScrollVM getPicsNum];
    cell.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    cell.pageControl.currentPageIndicatorTintColor = kBackGroundColor;
    // 取消用户交互功能
    cell.pageControl.userInteractionEnabled = NO;
    self.pageControl = cell.pageControl;
    
    CGRect viewFrame = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, viewFrame.size.width - 20,(viewFrame.size.width * 3)/7);
    // 设置可显示区域
    cell.scrollView.frame = frame;
    // 设置内容区域
    NSInteger count = [self.DWScrollVM getPicsNum];
    cell.scrollView.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
    // 设置滚动视图的内容视图
    // 将所有图片显示到图片视图中，并添加到滚动视图里
    for (NSUInteger i=0; i<count; i++)
    {
        DWPicScrollModel *pic = [self.DWScrollVM getPicsFromDataByIndex:i];
        NSURL *url = [NSURL URLWithString: pic.randpicIphone6];
        //创建图片视图
        UIImageView *imageView = [UIImageView new];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"150x"]];
        CGRect frame = CGRectZero;
        frame.size = CGSizeMake(cell.scrollView.frame.size.width, cell.scrollView.frame.size.height);
        frame.origin= CGPointMake(i * cell.scrollView.frame.size.width, 0);
        imageView.frame  = frame;
        //添加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = frame;
        [button addTarget:self action:@selector(pushDetailView) forControlEvents:UIControlEventTouchUpInside];
        [cell.scrollView addSubview:button];
        [cell.scrollView addSubview:imageView];
    }
    // 设置滚动视图不可以弹跳
    cell.scrollView.bounces = NO;
    // 设置滚动视图整页滚动
    cell.scrollView.pagingEnabled = YES;
    // 设置滚动视图的水平滚动提示不可见
    cell.scrollView.showsHorizontalScrollIndicator = NO;
    cell.scrollView.delegate = self;
    self.scrollView = cell.scrollView;
    return cell;
}
#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isDownLoadedData == 4)
    {
        
        [_collectionView.mj_header endRefreshing];
        if (section == 3)
        {
            return 6;
        }
        else if (section == 0)
        {
            return 1;
        }
        else
        {
            return 4;
        }
    }
    else
    {
        return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self setMyCell:collectionView cellForItemAtIndexPath:indexPath];
    }
    else if(indexPath.section == 1)
    {
        DWHotSonglistModel *hotSongListModel = [self.DWHotMusicVM getHotSongListModelWithIndex:indexPath.row];
        
        //重用cell
        DWHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.label.text = hotSongListModel.title;
        cell.imageView.image = [UIImage imageNamed:@"150x"];
        //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
        DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
        UIImage *storedImage = sharedImageCenter.cachedImages[hotSongListModel.picBig];
        if (storedImage == nil) {
            dispatch_queue_t queue = dispatch_queue_create("hotQueue", NULL);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hotSongListModel.picBig]]];
                sharedImageCenter.cachedImages[hotSongListModel.picBig] = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = image;
                    //[self.collectionView reloadData];
                });
            });
        }
        else
        {
            cell.imageView.image = storedImage;
        }

        return cell;
    }
    else if (indexPath.section == 2)
    {
        
        DWHotSonglistModel *newSongListModel = [self.DWNewMusicVM getHotSongListModelWithIndex:indexPath.row];
        
        //重用cell
        DWHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.label.text = newSongListModel.title;
        cell.imageView.image = [UIImage imageNamed:@"150x"];
        //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
        DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
        UIImage *storedImage = sharedImageCenter.cachedImages[newSongListModel.picBig];
        if (storedImage == nil) {
            dispatch_queue_t queue = dispatch_queue_create("newQueue", NULL);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newSongListModel.picBig]]];
                sharedImageCenter.cachedImages[newSongListModel.picBig] = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = image;
                    //[self.collectionView reloadData];
                });
            });
        }
        else
        {
            cell.imageView.image = storedImage;
        }
        return cell;
    }
    else
    {
        DWRadioList *radioList = [self.DWRadioVM getDWRadioListModelWithIndex:indexPath.row];
        //重用cell
        DWHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.label.text = radioList.title;
        cell.imageView.image = [UIImage imageNamed:@"150x"];
        //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
        DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
        UIImage *storedImage = sharedImageCenter.cachedImages[radioList.pic];
        if (storedImage == nil) {
            dispatch_queue_t queue = dispatch_queue_create("radioQueue", NULL);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:radioList.pic]]];
                sharedImageCenter.cachedImages[radioList.pic] = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = image;
                    //[self.collectionView reloadData];
                });
            });
        }
        else
        {
            cell.imageView.image = storedImage;
        }

        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    if (indexPath.section == 0) {
        return CGSizeMake(width - 20, (width * 3)/7);
    }
    else if (indexPath.section == 3) {
        return CGSizeMake( (width - 40)/3, (width - 40)/3 + 16);
    }
    else
    {
        return CGSizeMake((width - 30)/2, (width - 30)/2);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DWHeaderCollectionReusableView *reusableview = nil;
    DWHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader){
        [headerView.button addTarget:self action:@selector(Btn:) forControlEvents:UIControlEventTouchUpInside];
        switch (indexPath.section) {
            case 1:
            {
                headerView.label.text = @"热门歌单";
                headerView.button.tag = 1;
                break;
            }
            case 2:
            {
                headerView.label.text = @"最新歌单";
                headerView.button.tag = 2;
                break;
            }
            case 3:
            {
                headerView.label.text = @"电台节目";
                headerView.button.tag = 3;
                break;
            }
            default:
                break;
        }
        reusableview = headerView;
    }
    return reusableview;
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section != 0) {
        size = CGSizeMake(self.view.frame.size.width,30);
    }
    return size;
}
#pragma 代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        DWRadioList *radioList = [self.DWRadioVM getDWRadioListModelWithIndex:indexPath.row];
        [self.DWRadioInfoVM getDataFromNetCompleteHandle:^(NSError *error) {
            NSMutableArray *mArr = [NSMutableArray new];
            DWPlayMusic *music = [DWPlayMusic new];
            DWSongUrl *songurl = [self.DWRadioInfoVM geturlForSongid:radioList.itemid];
            DWSongModel *songModel = [self.DWRadioInfoVM getsongModelForSongid:radioList.itemid];
            music.title = radioList.title;
            music.author = @"";
            music.songId = radioList.itemid;
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
        } withSongId:radioList.itemid];
    }
    else if(indexPath.section == 2)
    {
        DWHotSonglistModel *newSongListModel = [self.DWNewMusicVM getHotSongListModelWithIndex:indexPath.row];
        [self.songVM getDataFromNetCompleteHandle:^(NSError *error) {
            NSMutableArray *mArr = [NSMutableArray new];
            DWPlayMusic *music = [DWPlayMusic new];
            DWSongUrl *songurl = [self.songVM geturlForSongid:newSongListModel.songId];
            DWSongModel *songModel = [self.songVM getsongModelForSongid:newSongListModel.songId];
            music.title = newSongListModel.title;
            music.author = newSongListModel.author;
            music.songId = newSongListModel.songId;
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
        } withSongId:newSongListModel.songId];
    }
    else if (indexPath.section == 1)
    {
        DWHotSonglistModel *hotSongListModel = [self.DWHotMusicVM getHotSongListModelWithIndex:indexPath.row];
        [self.songVM getDataFromNetCompleteHandle:^(NSError *error) {
            NSMutableArray *mArr = [NSMutableArray new];
            DWPlayMusic *music = [DWPlayMusic new];
            DWSongUrl *songurl = [self.songVM geturlForSongid:hotSongListModel.songId];
            DWSongModel *songModel = [self.songVM getsongModelForSongid:hotSongListModel.songId];
            music.title = hotSongListModel.title;
            music.author = hotSongListModel.author;
            music.songId = hotSongListModel.songId;
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
        } withSongId:hotSongListModel.songId];
    }
}
#pragma mark - 按钮
- (IBAction)click:(UIBarButtonItem *)sender {
    [self.bfVC pushViewFromView];
}
-(void)Btn:(UIButton *)sender
{
    if ( sender.tag == 1) {
        self.mdVC.session = 2;
        self.mdVC.title = @"热歌榜";
        [self.navigationController pushViewController:self.mdVC animated:YES];
    }
    else if (sender.tag == 2){
        self.mdVC.session = 1;
        self.mdVC.title = @"新歌榜";
        [self.navigationController pushViewController:self.mdVC animated:YES];
    }
    else
    {
        self.maVC.title = @"电台节目";
        [self.navigationController pushViewController:self.maVC animated:YES];
    }

    
}
- (DWBoFangViewController *)bfVC {
	if(_bfVC == nil) {
		_bfVC = [[DWBoFangViewController alloc] init];
	}
	return _bfVC;
}

- (DWScrollViewModel *)DWScrollVM {
	if(_DWScrollVM == nil) {
		_DWScrollVM = [[DWScrollViewModel alloc] init];
	}
	return _DWScrollVM;
}

- (UIPageControl *)pageControl
{
	if(_pageControl == nil) {
		_pageControl = [[UIPageControl alloc] init];
	}
	return _pageControl;
}


- (UIScrollView *)scrollView {
	if(_scrollView == nil) {
		_scrollView = [[UIScrollView alloc] init];
	}
	return _scrollView;
}

- (DWHotMusicViewModel *)DWHotMusicVM {
	if(_DWHotMusicVM == nil) {
		_DWHotMusicVM = [[DWHotMusicViewModel alloc] init];
	}
	return _DWHotMusicVM;
}

- (DWNewMusicViewModel *)DWNewMusicVM {
	if(_DWNewMusicVM == nil) {
		_DWNewMusicVM = [[DWNewMusicViewModel alloc] init];
	}
	return _DWNewMusicVM;
}

- (DWRadioViewModel *)DWRadioVM {
	if(_DWRadioVM == nil) {
		_DWRadioVM = [[DWRadioViewModel alloc] init];
	}
	return _DWRadioVM;
}

- (DWMoreDetailTableViewController *)mdVC {
	if(_mdVC == nil) {
		_mdVC = [[DWMoreDetailTableViewController alloc] init];
	}
	return _mdVC;
}

- (DWMoreAudioCollectionViewController *)maVC {
	if(_maVC == nil) {
		_maVC = [[DWMoreAudioCollectionViewController alloc] init];
	}
	return _maVC;
}

- (DWRadioInfoViewModel *)DWRadioInfoVM {
	if(_DWRadioInfoVM == nil) {
		_DWRadioInfoVM = [[DWRadioInfoViewModel alloc] init];
	}
	return _DWRadioInfoVM;
}

- (DWSongViewModel *)songVM {
	if(_songVM == nil) {
		_songVM = [[DWSongViewModel alloc] init];
	}
	return _songVM;
}

- (DwWebViewViewController *)webVC {
	if(_webVC == nil) {
		_webVC = [[DwWebViewViewController alloc] init];
	}
	return _webVC;
}

@end
