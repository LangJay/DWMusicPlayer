//
//  DWHotMusicNetModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWHotMusicModel.h"

@interface DWHotMusicNetModel : DWBaseNetManager
+(id)getDWHotMusicModeltWithCompletionHandle:(void(^)(DWHotMusicModel *model,DWHotBillBoardModel *billModel,NSError *error))completionHandle withOffset:(int)offset withType:(int)type;
@end
