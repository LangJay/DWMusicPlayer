//
//  DWRadioInfoViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/11.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWRadioInfoViewModel.h"
#import "DWRadioInfoNetManager.h"
@implementation DWRadioInfoViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withSongId:(NSString *)songId
{
    
    self.dataTask = [DWRadioInfoNetManager getDWRadioInfoModelWithSongId:songId WithCompletionHandle:^(NSDictionary *songDict, NSError *error) {
        DWSongModel *model = [DWSongModel new];
        model.lrclink = [[songDict valueForKey:@"songinfo"] valueForKey:@"lrclink"];
        model.shareUrl = [[songDict valueForKey:@"songinfo"] valueForKey:@"share_url"];
        model.picPremium = [[songDict valueForKey:@"songinfo"] valueForKey:@"pic_radio"];
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
