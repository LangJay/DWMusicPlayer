//
//  DWPlayMusic.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/28.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWPlayMusic : NSObject
@property(nonatomic,strong)NSString *title;//歌曲名
@property(nonatomic,strong)NSURL *songurl;//歌曲文件名
@property(nonatomic,strong)NSURL *lrcname;//歌词文件名
@property(nonatomic,strong)NSString *author;//歌手
@property(nonatomic,strong)NSURL *pic;//歌手图片
@property (nonatomic, strong) NSURL *showLink;
@property (nonatomic, strong) NSString *songId;
@end
