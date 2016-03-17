//
//  DWMVNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"

@interface DWMVNetManager : DWBaseNetManager
+(id)getDWMVModeltWithCompletionHandle:(void(^)(NSDictionary *contentDict,NSError *error))completionHandle WithSongID:(NSString *)songID;
@end
