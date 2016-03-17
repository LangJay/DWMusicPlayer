//
//  DWTouTiaoNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWTouTiaoModel.h"

@interface DWTouTiaoNetManager : DWBaseNetManager
+(id)getDWTouTiaoModeltWithCompletionHandle:(void(^)(NSDictionary *contentDict,NSError *error))completionHandle WithCode:(NSString *)code WithType:type;
@end
