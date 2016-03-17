//
//  DWRadioNetmanager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRadioNetmanager.h"

@implementation DWRadioNetmanager
+(id)getDWRadioModeltWithCompletionHandle:(void(^)(DWRadioModel *model,NSError *error))completionHandle
{
    NSString *path = @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.radio.getRecommendRadioList&format=json&num=50&version=5.3.2&from=ios&channel=appstore";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([DWRadioModel mj_objectWithKeyValues:responseObj],error);
    }];

}
@end
