//
//  DWSearchTableViewController.m
//  DWMusicPlayerTests
//
//  Created by 周继良 on 15/11/30.
//  Copyright © 2015年 周继良. All rights reserved.
//
/**
 搜索：
 
 1、根据关键字得到搜索建议：query，列表显示出来
 2、根据用户点击的query搜索歌曲信息，得到匹配列表
 3、根据用户点击的匹配歌曲列表播放歌曲。这里用匹配歌曲列表里的songId得到歌曲信息。
 **/

#import "DWSearchTableViewController.h"
#import "DWQueryListViewModel.h"
#import "DWSearchListViewModel.h"
#import "DWSongViewModel.h"
#import "DWSongModel.h"
#import "DWPlayMusic.h"
#import "DWBoFangViewController.h"

@interface DWSearchTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DWQueryListViewModel *queryListVM;
@property (nonatomic, strong) DWSearchListViewModel *searchListVM;
@property (nonatomic, strong) DWSongViewModel *songVM;
@property (nonatomic, strong) NSArray *searchList;
@property (nonatomic, strong) DwSearchSongModel *searcSong;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) DWBoFangViewController *bfVC;
@end

@implementation DWSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;//适应整个屏幕
    self.searchController.hidesNavigationBarDuringPresentation = YES;//隐藏navi
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.placeholder = @"输入歌手、歌名";
    [self.searchController.searchBar becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SearchBar代理
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSString *path = [searchString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.queryListVM getDataFromNetCompleteHandle:^(NSError *error) {
        //刷新表格
        [self.tableView reloadData];
    } WithQuery:path];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [self.queryListVM getSuggetstList].count;
    }else{
        return [self.searchListVM getSearchList].count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"queryCell" forIndexPath:indexPath];
    if (self.searchController.active) {
        cell.textLabel.text = [self.queryListVM getSuggestForIndex:indexPath.row];
        cell.detailTextLabel.text = nil;
    }
    else{
        self.searcSong = [DwSearchSongModel mj_objectWithKeyValues:[self.searchListVM getSearchList][indexPath.row]];
        cell.textLabel.text = [self replaceString:self.searcSong.title];
        cell.detailTextLabel.text = [self replaceString:self.searcSong.author];;
    }
    return cell;
}
-(NSString *)replaceString:(NSString *)string
{
    if ([string hasPrefix:@"<em>"]) {
        string = [string stringByReplacingCharactersInRange:[string rangeOfString:@"<em>"] withString:@""];
        string = [string stringByReplacingCharactersInRange:[string rangeOfString:@"</em>"] withString:@""];
    }
    return string;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchController.active) {
        //    获取搜索关键词
        NSString *query = [self.queryListVM getSuggestForIndex:indexPath.row];
        //    根据query获取SearchList,显示在列表上
        [self.searchListVM getDataFromNetCompleteHandle:^(NSError *error) {
            self.searchList = [NSArray arrayWithArray:[self.searchListVM getSearchList]];
//            刷新列表
            self.searchController.active = NO;
            [self.tableView reloadData];
        } WithQuery:query];
    }
    else
    {
        DwSearchSongModel *searchSong = [DwSearchSongModel mj_objectWithKeyValues:[self.searchListVM getSearchList][indexPath.row]];
        NSString *songId = searchSong.songId;
        //      根据songId获取播放歌曲信息
        [self.songVM getDataFromNetCompleteHandle:^(NSError *error) {
            NSMutableArray *mArr = [NSMutableArray new];
            DWPlayMusic *music = [DWPlayMusic new];
            music.title = [self replaceString:[self.searchListVM getTitleForIndex:indexPath.row]];
            music.author = [self replaceString:[self.searchListVM getAuthorForIndex:indexPath.row]];
            music.songId = songId;
            music.pic = [NSURL URLWithString:[self.songVM getsongModelForSongid:songId].picPremium];
            music.lrcname = [NSURL URLWithString:[self.songVM getsongModelForSongid:songId].lrclink];
            music.songurl = [NSURL URLWithString:[self.songVM geturlForSongid:songId].fileLink];
            music.showLink = [NSURL URLWithString:[self.songVM getsongModelForSongid:songId].shareUrl];
            [mArr addObject:music];
            self.bfVC.songLists = [mArr copy];
            self.bfVC.index = 0;
            [self.bfVC show];
        } withSongId:songId];
    }
}

- (DWQueryListViewModel *)queryListVM {
	if(_queryListVM == nil) {
		_queryListVM = [[DWQueryListViewModel alloc] init];
	}
	return _queryListVM;
}



- (DWSearchListViewModel *)searchListVM {
	if(_searchListVM == nil) {
		_searchListVM = [[DWSearchListViewModel alloc] init];
	}
	return _searchListVM;
}

- (DWSongViewModel *)songVM {
	if(_songVM == nil) {
		_songVM = [[DWSongViewModel alloc] init];
	}
	return _songVM;
}

- (NSArray *)searchList {
	if(_searchList == nil) {
		_searchList = [[NSArray alloc] init];
	}
	return _searchList;
}

- (DWBoFangViewController *)bfVC {
	if(_bfVC == nil) {
		_bfVC = [[DWBoFangViewController alloc] init];
	}
	return _bfVC;
}

@end
