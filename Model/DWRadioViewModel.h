//
//  DWRadioViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWRadioModel.h"

@interface DWRadioViewModel : DWBaseViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;
-(DWRadioList *)getDWRadioListModelWithIndex:(NSInteger)index;
-(NSInteger)getCount;
@end
