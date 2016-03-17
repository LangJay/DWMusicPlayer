//
//  DWQueryListNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWQueryListNetManager.h"

@implementation DWQueryListNetManager
+(id)getDWQueryListWithQuery:(NSString *)query WithCompletionHandle:(void(^)(DWQueryListModel *model,NSError *error))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.search.suggestion&query=%@&format=json&from=ios&version=2.1.1",query];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([DWQueryListModel mj_objectWithKeyValues:responseObj],error);
    }];
}
@end
