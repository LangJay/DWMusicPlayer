//
//  DWHotMusicViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWHotMusicModel.h"

@interface DWHotMusicViewModel : DWBaseViewModel
@property (nonatomic, strong) DWHotMusicModel *hotMusicModel;
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withOffset:(int)offset withType:(int)type;
-(DWHotBillBoardModel *)getHotBillBoardModel;
-(DWHotMusicModel *)getHotMusicModel;
-(DWHotSonglistModel *)getHotSongListModelWithIndex:(NSInteger )index;
@end
