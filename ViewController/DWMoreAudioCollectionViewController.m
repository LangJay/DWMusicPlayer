//
//  DWMoreAudioCollectionViewController.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/8.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWMoreAudioCollectionViewController.h"
#import "DWRadioViewModel.h"
#import "DWHotCollectionViewCell.h"
#import "DWImageCenter.h"
#import "DWSongModel.h"
#import "DWRadioInfoViewModel.h"
#import "DWPlayMusic.h"
#import "DWBoFangViewController.h"
@interface DWMoreAudioCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DWRadioViewModel *DWRadioVM;
@property (nonatomic, strong) DWRadioInfoViewModel *DWRadioInfoVM;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@end

@implementation DWMoreAudioCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DWHotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.DWRadioVM getDataFromNetCompleteHandle:^(NSError *error) {
            [_collectionView reloadData];
            [_collectionView.mj_header endRefreshing];
        }];
    }];
    [_collectionView.mj_header beginRefreshing];
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.DWRadioVM getCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DWRadioList *radioList = [self.DWRadioVM getDWRadioListModelWithIndex:indexPath.row];
    //重用cell
    DWHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    cell.label.text = radioList.title;
    cell.label.font = [UIFont systemFontOfSize:11];
    cell.imageView.image = [UIImage imageNamed:@"150x"];
    //使用单例缓存图片，避免直接加载导致tableView出现卡顿现象
    DWImageCenter *sharedImageCenter = [DWImageCenter sharedImageCenter];
    UIImage *storedImage = sharedImageCenter.cachedImages[radioList.pic];
    if (storedImage == nil) {
        dispatch_queue_t queue = dispatch_queue_create("radioQueue1", NULL);
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

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((width - 50)/4, (width - 50)/4);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
- (DWRadioViewModel *)DWRadioVM {
    if(_DWRadioVM == nil) {
        _DWRadioVM = [[DWRadioViewModel alloc] init];
    }
    return _DWRadioVM;
}

- (DWRadioInfoViewModel *)DWRadioInfoVM {
	if(_DWRadioInfoVM == nil) {
		_DWRadioInfoVM = [[DWRadioInfoViewModel alloc] init];
	}
	return _DWRadioInfoVM;
}

- (DWBoFangViewController *)bfVC {
	if(_bfVC == nil) {
		_bfVC = [[DWBoFangViewController alloc] init];
	}
	return _bfVC;
}

@end
