//
//  DWSongNetManager.h
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWSongModel.h"

@interface DWSongNetManager : DWBaseNetManager
+(id)getDWSongModelWithSongId:(NSString *)songId WithCompletionHandle:(void(^)(NSDictionary *songDict,NSError *error))completionHandle;
@end
