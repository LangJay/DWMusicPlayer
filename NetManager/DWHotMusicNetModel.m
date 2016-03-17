//
//  DWHotMusicNetModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWHotMusicNetModel.h"
#import "MBProgressHUD+MJ.h"

@implementation DWHotMusicNetModel
+(id)getDWHotMusicModeltWithCompletionHandle:(void(^)(DWHotMusicModel *model,DWHotBillBoardModel *billModel, NSError *error))completionHandle withOffset:(int)offset withType:(int)type
{
    int size = 15;
    NSString *path = [NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.billboard.billList&format=json&type=%d&offset=%d&size=%d",type,offset,size];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error)
    {
        completionHandle([DWHotMusicModel mj_objectWithKeyValues:responseObj],[DWHotBillBoardModel mj_objectWithKeyValues:[responseObj valueForKey:@"billboard"]],error);
    }];
}
@end
