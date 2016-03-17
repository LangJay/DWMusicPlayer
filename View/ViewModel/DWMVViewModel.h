//
//  DWMVViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"

@interface DWMVViewModel : DWBaseViewModel
@property (nonatomic, strong) NSString *path;
-(void)getMVDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithSongID:songID;
-(NSString *)getSourcePath;
@end
