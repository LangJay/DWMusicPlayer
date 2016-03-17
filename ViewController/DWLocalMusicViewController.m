//
//  DWLocalMusicViewController.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/27.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWLocalMusicViewController.h"
#import "DWBoFangViewController.h"
#import "DWPlayMusic.h"
#import "DWDownloadMusic.h"
#import "DWMusic.h"

@interface DWLocalMusicViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *musics;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *resultMusics;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@end

@implementation DWLocalMusicViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doReload) name:@"reloadData" object:nil];
}
-(void)doReload
{
    self.musics = [DWDownloadMusic readFileFromPlist];
    self.resultMusics = [NSMutableArray arrayWithArray:self.musics];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.musics = [DWDownloadMusic readFileFromPlist];
        self.resultMusics = [NSMutableArray arrayWithArray:self.musics];
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }];
    [_tableView.mj_header beginRefreshing];
}
#pragma mark - 按钮
- (IBAction)click:(UIBarButtonItem *)sender {
    [self.bfVC pushViewFromView];
}
#pragma mark - searchBar代理
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText!=nil && searchText.length>0) {
        [self.resultMusics removeAllObjects];
        for (NSInteger index = 0; index < self.musics.count; index ++ ) {
            DWMusic *music = [DWMusic new];
            music = self.musics[index];
            if ([music.title hasPrefix:searchText] || [music.author hasPrefix:searchText]) {
                [self.resultMusics addObject:music];
            }
        }
        [_tableView reloadData];
    }
    else
    {
        [self.resultMusics removeAllObjects];
        self.resultMusics = [NSMutableArray arrayWithArray:self.musics];
        [_tableView reloadData];
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.resultMusics removeAllObjects];
    self.resultMusics = [NSMutableArray arrayWithArray:self.musics];
    [_tableView reloadData];
    [self.view endEditing:YES];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    NSString *searchText = searchBar.text;
    if (searchText!=nil && searchText.length>0) {
        [self.resultMusics removeAllObjects];
        for (NSInteger index = 0; index < self.musics.count; index ++ ) {
            DWMusic *music = [DWMusic new];
            music = self.musics[index];
            if ([music.title hasPrefix:searchText] || [music.author hasPrefix:searchText]) {
                [self.resultMusics addObject:music];
            }
        }
        [_tableView reloadData];
    }
    else
    {
        [self.resultMusics removeAllObjects];
        self.resultMusics = [NSMutableArray arrayWithArray:self.musics];
        [_tableView reloadData];
    }

}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = NO;
}
#pragma mark - tableView数据源代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultMusics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"forIndexPath:indexPath];
    DWPlayMusic *music = self.resultMusics[indexPath.row];
    cell.textLabel.text = music.title;
    cell.detailTextLabel.text = music.author;
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //考虑到性能这里不建议使用reloadData
        //[tableView reloadData];
        //使用下面的方法既可以局部刷新又有动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        //如果当前组中没有数据则移除组刷新整个表格
        if (1) {
            [tableView reloadData];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    NSMutableArray *mArr = [NSMutableArray new];
    for (NSInteger index = 0; index < self.resultMusics.count; index ++ ) {
        DWMusic *music = [DWMusic new];
        music = self.resultMusics[index];
        DWPlayMusic *playMusic = [DWPlayMusic new];
       
        playMusic.songId = music.songId;
        playMusic.title = music.title;
        playMusic.author = music.author;
        playMusic.pic = [self getURLByExtension:@"jpg" WithSongId:music.songId];
        playMusic.lrcname = [self getURLByExtension:@"lrc" WithSongId:music.songId];
        playMusic.songurl = [self getURLByExtension:@"mp3" WithSongId:music.songId];
        playMusic.showLink = [NSURL URLWithString:music.showLink];
        [mArr addObject:playMusic];
    }
    self.bfVC.songLists = [mArr copy];
    self.bfVC.index = indexPath.row;
    [self.bfVC show];
}

-(NSURL *)getURLByExtension:(NSString *)extension WithSongId:(NSString *)songId
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [[manager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *extensionPath = [[@"musics" stringByAppendingPathComponent:songId] stringByAppendingPathExtension:extension];
    return [url URLByAppendingPathComponent:extensionPath];
}
- (NSArray *)musics {
	if(_musics == nil) {
		_musics = [[NSArray alloc] init];
        _musics = [DWDownloadMusic readFileFromPlist];
	}
	return _musics;
}

- (DWBoFangViewController *)bfVC {
    if(_bfVC == nil) {
        _bfVC = [[DWBoFangViewController alloc] initWithNibName:@"DWBoFangViewController" bundle:nil];
    }
    return _bfVC;
}

- (NSMutableArray *)resultMusics {
	if(_resultMusics == nil) {
		_resultMusics = [[NSMutableArray alloc] init];
	}
	return _resultMusics;
}

@end
