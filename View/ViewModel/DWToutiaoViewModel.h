//
//  DWToutiaoViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWTouTiaoModel.h"

@interface DWToutiaoViewModel : DWBaseViewModel
@property (nonatomic, strong) DWAlbumInfo *alb;
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle withCode:(NSString *)code WithType:type;
-(NSArray *)getContentListWith:(NSString *)code
;
-(DWTouTiaoModel *)getTouTiaoModelWith:(NSString *)code;
-(DWAlbumInfo *)getAlbModel;
-(NSArray *)getDataArr;
@end
