//
//  DWMVNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWMVNetManager.h"

@implementation DWMVNetManager
+(id)getDWMVModeltWithCompletionHandle:(void(^)(NSDictionary *contentDict,NSError *error))completionHandle WithSongID:(NSString *)songID
{
    NSString *path =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.mv.playMV&mv_id=&song_id=%@&definition=51&version=5.5.5&from=ios&channel=appstore",songID];
     NSString *str1 = [path stringByRemovingPercentEncoding];
    return [self GET:str1 parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([NSDictionary dictionaryWithDictionary:responseObj],error);
    }];
}
@end
