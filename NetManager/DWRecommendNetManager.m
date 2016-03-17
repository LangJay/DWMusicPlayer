//
//  DWRecommendNetManager.m
//  逗我
//
//  Created by 周继良 on 15/11/13.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRecommendNetManager.h"

@implementation DWRecommendNetManager
+(id)getDWRecommendListWithCompletionHandle:(void(^)(DWRecommendList *model,NSError *error))completionHandle
{
    NSString *path=@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.userRecSongList&from=ios&version=5.3.2";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([DWRecommendList mj_objectWithKeyValues:[responseObj valueForKey:@"result"]],error);
    }];
}
@end
