//
//  DWRadioInfoNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/11.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWRadioInfoNetManager.h"

@implementation DWRadioInfoNetManager
+(id)getDWRadioInfoModelWithSongId:(NSString *)songId WithCompletionHandle:(void(^)(NSDictionary *songDict,NSError *error))completionHandle
{
    NSString *str = @"&nw=2&l2p=-1449539459283.0&lpb=0&ext=mp3&format=json&from=ios&usup=1&lebo=1&aac=0&ucf=4&vid=&res=1&e=HtM%2FO68U8yetw3wGC7X5hJNusLdS8GVsiYt%2Bd0xkz5Y%3D&version=5.5.1&from=ios&channel=appstore";
    NSString *path =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1449540065&songid=%@%@",songId,str];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([NSDictionary dictionaryWithDictionary:responseObj],error);
    }];
}
@end
