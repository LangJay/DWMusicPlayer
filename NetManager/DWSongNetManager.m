//
//  DWSongNetManager.m
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSongNetManager.h"

@implementation DWSongNetManager
+(id)getDWSongModelWithSongId:(NSString *)songId WithCompletionHandle:(void(^)(NSDictionary *songDict,NSError *error))completionHandle
{
    NSString *str = @"&ts=1408284347323&e=JoN56kTXnnbEpd9MVczkYJCSx%2FE1mkLx%2BPMIkTcOEu4%3D&nw=2&ucf=1&res=1";
    NSString *path =[NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.song.getInfos&format=json&songid=%@%@",songId,str];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([NSDictionary dictionaryWithDictionary:responseObj],error);
    }];
}
@end
