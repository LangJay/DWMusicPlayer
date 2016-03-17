//
//  DWScrollViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWScrollModel.h"

@interface DWScrollViewModel : DWBaseViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;
-(DWPicScrollModel *)getPicsFromDataByIndex:(NSInteger)index;
-(NSInteger)getPicsNum;
@end
