//
//  DWRadioInfoViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/11.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWSongModel.h"
@interface DWRadioInfoViewModel : DWBaseViewModel
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withSongId:(NSString *)songId;
-(DWSongUrl *)geturlForSongid:(NSString *)songID;
-(DWSongModel *)getsongModelForSongid:(NSString *)songID;
@end
