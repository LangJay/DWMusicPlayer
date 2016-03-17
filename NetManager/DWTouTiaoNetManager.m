//
//  DWTouTiaoNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWTouTiaoNetManager.h"

@implementation DWTouTiaoNetManager
+(id)getDWTouTiaoModeltWithCompletionHandle:(void(^)(NSDictionary *contentDict,NSError *error))completionHandle WithCode:(NSString *)code WithType:type
{
    if ([type isEqualToString:@"2"]) {
        NSString *path =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.album.getAlbumInfo&album_id=%@&format=json&from=ios",code];
        return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
            completionHandle([NSDictionary dictionaryWithDictionary:responseObj],error);
        }];
    }
    else
    {
        NSString *path =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=%@&version=5.3.2&from=ios",code];
        return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
            completionHandle([NSDictionary dictionaryWithDictionary:responseObj],error);
        }];
    }
}
@end
