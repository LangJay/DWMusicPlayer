//
//  DWDownloadMusic.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/27.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWDownloadMusic : NSObject
+(void)downloadMusicsWith:(NSArray *)musics;
+(void)deleteMusicWith:(NSArray *)musics;
+(NSArray *)readFileFromPlist;
@end
