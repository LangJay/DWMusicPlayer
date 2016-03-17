//
//  DWScrollViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWScrollViewModel.h"
#import "DWScrollNetManager.h"

@implementation DWScrollViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [DWScrollNetManager getDWScrollModeltWithCompletionHandle:^(DWScrollModel *model, NSError *error) {
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:model.pic];
        completionHandle(error);
    }];
}
-(DWPicScrollModel *)getPicsFromDataByIndex:(NSInteger)index
{
    NSDictionary *dict = self.dataArr[index];
    DWPicScrollModel *pic =[DWPicScrollModel mj_objectWithKeyValues:dict];
    return pic;
}
-(NSInteger)getPicsNum
{
    return self.dataArr.count;
}
@end
