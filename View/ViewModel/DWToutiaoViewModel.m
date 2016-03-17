//
//  DWToutiaoViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWToutiaoViewModel.h"
#import "DWTouTiaoNetManager.h"
@implementation DWToutiaoViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withCode:(NSString *)code WithType:type;
{
    [self.dataArr removeAllObjects];
    self.dataTask = [DWTouTiaoNetManager getDWTouTiaoModeltWithCompletionHandle:^(NSDictionary *contentDict, NSError *error) {
        if ([type isEqualToString:@"2"]) {
            DWAlbumInfo *alModel = [DWAlbumInfo new];
            alModel = [DWAlbumInfo mj_objectWithKeyValues:[contentDict valueForKey:@"albumInfo"]];
            self.alb = alModel;
            for (DWSongList *list in [contentDict valueForKey:@"songlist"]) {
                [self.dataArr addObject:[DWSongList mj_objectWithKeyValues:list]];
            }
        }
        else
        {
            DWTouTiaoModel *model = [DWTouTiaoModel new];
            model.errorCode = [contentDict valueForKey:@"error_code"];
            model.listid = [contentDict valueForKey:@"listid"];
            model.title = [contentDict valueForKey:@"title"];
            model.pic300 = [contentDict valueForKey:@"pic_300"];
            model.pic500 = [contentDict valueForKey:@"pic_500"];
            model.picW700 = [contentDict valueForKey:@"pic_w700"];
            model.width = [contentDict valueForKey:@"width"];
            model.height = [contentDict valueForKey:@"height"];
            model.listenum = [contentDict valueForKey:@"listenum"];
            model.collectnum = [contentDict valueForKey:@"collectnum"];
            model.tag = [contentDict valueForKey:@"tag"];
            model.desc = [contentDict valueForKey:@"desc"];
            model.url = [contentDict valueForKey:@"url"];
            model.content = [NSArray arrayWithArray:[contentDict valueForKey:@"content"]];
            [self.dataArr addObject:model];
        }
        completionHandle(error);
    } WithCode:code WithType:type];
}
-(NSArray *)getContentListWith:(NSString *)code
{
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger count = [self getTouTiaoModelWith:code].content .count;
    for (int i = 0; i < count; i ++) {
        DWContentList *list = [DWContentList new];
        list = [DWContentList mj_objectWithKeyValues: [self getTouTiaoModelWith:code].content[i]];
        [arr addObject:list];
    }
    return arr;
}

-(DWTouTiaoModel *)getTouTiaoModelWith:(NSString *)code
{
    for (DWTouTiaoModel *p in self.dataArr) {
        if ([p.listid isEqualToString:code])
        {
            return p;
        }
    }
    return nil;
}
-(DWAlbumInfo *)getAlbModel
{
    return self.alb;
}
-(NSArray *)getDataArr
{
    return self.dataArr;
}
@end
