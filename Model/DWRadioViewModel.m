//
//  DWRadioViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRadioViewModel.h"
#import "DWRadioNetmanager.h"

@implementation DWRadioViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [DWRadioNetmanager getDWRadioModeltWithCompletionHandle:^(DWRadioModel *model, NSError *error) {
        self.dataArr = [NSMutableArray arrayWithArray:model.list];
        completionHandle(error);
    }];
}
-(DWRadioList *)getDWRadioListModelWithIndex:(NSInteger)index
{
    return self.dataArr[index];
}
-(NSInteger)getCount
{
    return self.dataArr.count;
}
@end
