//
//  DWRadioInfoNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/11.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"

@interface DWRadioInfoNetManager : DWBaseNetManager
+(id)getDWRadioInfoModelWithSongId:(NSString *)songId WithCompletionHandle:(void(^)(NSDictionary *songDict,NSError *error))completionHandle;
@end
