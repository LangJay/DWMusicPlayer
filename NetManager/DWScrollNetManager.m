//
//  DWScrollNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWScrollNetManager.h"

@implementation DWScrollNetManager
+(id)getDWScrollModeltWithCompletionHandle:(void(^)(DWScrollModel *model,NSError *error))completionHandle
{
    NSString *path = @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getFocusPic&format=json&from=ios&version=5.3.2";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([DWScrollModel mj_objectWithKeyValues:responseObj],error);
    }];
}
@end
