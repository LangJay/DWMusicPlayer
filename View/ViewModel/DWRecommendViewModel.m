//
//  DWRecommendViewModel.m
//  逗我
//
//  Created by 周继良 on 15/11/14.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRecommendViewModel.h"

@implementation DWRecommendViewModel
-(NSInteger)rowNumber
{
    return self.dataArr.count;
}
-(NSMutableArray *)getDataArray
{
    return self.dataArr;
}
-(songListModel *)ListArrayForRow:(NSInteger)row
{
    return self.dataArr[row];
}
-(NSString *)titleForRow:(NSInteger)row
{
    return [self ListArrayForRow:row].title;
}
-(NSString *)authorForRow:(NSInteger)row
{
    return [self ListArrayForRow:row].author;
}
-(NSURL *)smallPicForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self ListArrayForRow:row].picSmall];
}
-(BOOL)hasMVForRow:(NSInteger)row
{
    if ([self ListArrayForRow:row].hasMv == 1) {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(NSString *)songIDForRow:(NSInteger)row
{
    return [self ListArrayForRow:row].songId;
}

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [DWRecommendNetManager getDWRecommendListWithCompletionHandle:^(DWRecommendList *model, NSError *error)
    {
        [self.dataArr removeAllObjects];
        //隐式转换 VideoModel *m = (VideoModel *)model;
        [self.dataArr addObjectsFromArray:model.list];
        completionHandle(error);
    }];
}
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _index = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}
@end
