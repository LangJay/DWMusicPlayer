//
//  DWQueryListViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWQueryListViewModel.h"
#import "DWQueryListNetManager.h"

@implementation DWQueryListViewModel
-(NSString *)getSuggestForIndex:(NSInteger)index
{
    return self.dataArr[index];
}
-(NSArray *)getSuggetstList
{
    return self.dataArr;
}
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithQuery:(NSString *)query
{
    self.dataTask = [DWQueryListNetManager getDWQueryListWithQuery:query WithCompletionHandle:^(DWQueryListModel *model, NSError *error) {
        [self.dataArr removeAllObjects];
        //隐式转换 VideoModel *m = (VideoModel *)model;
        [self.dataArr addObjectsFromArray:model.suggestionList];
        completionHandle(error);
    }];
}
@end
