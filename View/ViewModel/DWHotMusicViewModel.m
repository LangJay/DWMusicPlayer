//
//  DWHotMusicViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWHotMusicViewModel.h"
#import "DWHotMusicNetModel.h"

@implementation DWHotMusicViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withOffset:(int)offset withType:(int)type
{
    self.dataTask = [DWHotMusicNetModel getDWHotMusicModeltWithCompletionHandle:^(DWHotMusicModel *model,DWHotBillBoardModel *billmodel, NSError *error) {
        self.hotMusicModel = model;
        self.hotMusicModel.billboard = [billmodel mj_keyValues];
        completionHandle(error);
    } withOffset:offset withType:type];
}
-(DWHotMusicModel *)getHotMusicModel
{
    return self.hotMusicModel;
}
-(DWHotBillBoardModel *)getHotBillBoardModel
{
    DWHotBillBoardModel *billModel = [DWHotBillBoardModel mj_objectWithKeyValues:self.hotMusicModel.billboard];
    return billModel;
}
-(DWHotSonglistModel *)getHotSongListModelWithIndex:(NSInteger )index
{
    DWHotSonglistModel *songModel = [DWHotSonglistModel mj_objectWithKeyValues:self.hotMusicModel.songList[index]];
    return songModel;
}
@end
