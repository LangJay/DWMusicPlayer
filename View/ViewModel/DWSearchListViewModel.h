//
//  DWSearchListViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWSearchListNetManager.h"
#import "DWSearchListModel.h"

@interface DWSearchListViewModel : DWBaseViewModel
-(NSString *)getSongIdForIndex:(NSInteger)index;
-(NSString *)getAuthorForIndex:(NSInteger)index;
-(NSString *)getTitleForIndex:(NSInteger)index;
-(NSArray *)getSearchList;
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithQuery:(NSString *)query;
@end
