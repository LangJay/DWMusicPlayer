//
//  DWSearchListNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"

@interface DWSearchListNetManager : DWBaseNetManager
+(id)getDWSearchListWithQuery:(NSString *)query WithCompletionHandle:(void(^)(NSArray *songlist,NSError *error))completionHandle;
@end
