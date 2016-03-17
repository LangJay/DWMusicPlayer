//
//  DWSearchListViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSearchListViewModel.h"

@implementation DWSearchListViewModel
-(NSString *)getSongIdForIndex:(NSInteger)index
{
    DwSearchSongModel *searchSong = [DwSearchSongModel mj_objectWithKeyValues:self.dataArr[index]];
    return searchSong.songId;
}
-(NSString *)getTitleForIndex:(NSInteger)index
{
    DwSearchSongModel *searchSong = [DwSearchSongModel mj_objectWithKeyValues:self.dataArr[index]];
    return searchSong.title;
}
-(NSString *)getAuthorForIndex:(NSInteger)index
{
    DwSearchSongModel *searchSong = [DwSearchSongModel mj_objectWithKeyValues:self.dataArr[index]];    return searchSong.author;
}
-(NSArray *)getSearchList
{
    return self.dataArr;
}
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithQuery:(NSString *)query
{
    self.dataTask = [DWSearchListNetManager getDWSearchListWithQuery:query WithCompletionHandle:^(NSArray *songlist, NSError *error) {
        [self.dataArr removeAllObjects];
        self.dataArr = [NSMutableArray arrayWithArray:songlist];
        completionHandle(error);
    }];
}
@end
