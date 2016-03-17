//
//  DWSearchListNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSearchListNetManager.h"

@implementation DWSearchListNetManager
+(id)getDWSearchListWithQuery:(NSString *)query WithCompletionHandle:(void(^)(NSArray *songlist,NSError *error))completionHandle
{
    NSString *str =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.search.common&format=json&query=%@&page_no=1&page_size=30",query];
    NSString *path = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([NSArray arrayWithArray:[responseObj valueForKey:@"song_list"]],error);
    }];
}
@end
