//
//  DWSongViewModel.m
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSongViewModel.h"
#import "DWSongNetManager.h"

@implementation DWSongViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withSongId:(NSString *)songId
{
    
    self.dataTask = [DWSongNetManager getDWSongModelWithSongId:songId WithCompletionHandle:^(NSDictionary *songDict, NSError *error) {
        DWSongModel *model = [DWSongModel new];
        model.lrclink = [[songDict valueForKey:@"songinfo"] valueForKey:@"lrclink"];
        model.shareUrl = [[songDict valueForKey:@"songinfo"] valueForKey:@"share_url"];
        model.picPremium = [[songDict valueForKey:@"songinfo"] valueForKey:@"pic_premium"];
        model.songId = [[songDict valueForKey:@"songinfo"] valueForKey:@"song_id"];
        model.songurl = [NSArray arrayWithArray:[[songDict valueForKey:@"songurl"] valueForKey:@"url"]];
        [self.dataArr addObject:model];
        completionHandle(error);
    }];
}

-(DWSongUrl *)geturlForSongid:(NSString *)songID
{
    return [DWSongUrl mj_objectWithKeyValues: [self getsongModelForSongid:songID].songurl[0]];
}

-(DWSongModel *)getsongModelForSongid:(NSString *)songID
{
    for (DWSongModel *p in self.dataArr) {
        if ([p.songId isEqualToString:songID])
        {
            return p;
        }
    }
    return nil;
}

@end
