//
//  DWSongViewModel.h
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWSongModel.h"

@interface DWSongViewModel : DWBaseViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withSongId:(NSString *)songId;
-(DWSongUrl *)geturlForSongid:(NSString *)songID;
-(DWSongModel *)getsongModelForSongid:(NSString *)songID;

@end
