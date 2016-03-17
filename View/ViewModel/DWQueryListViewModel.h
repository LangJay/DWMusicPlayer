//
//  DWQueryListViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWQueryListModel.h"

@interface DWQueryListViewModel : DWBaseViewModel
-(NSString *)getSuggestForIndex:(NSInteger)index;
-(NSArray *)getSuggetstList;
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithQuery:(NSString *)query;
@end
