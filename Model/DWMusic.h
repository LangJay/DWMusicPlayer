//
//  DWMusic.h
//  逗我
//
//  Created by 周继良 on 15/11/26.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWMusic : NSObject
@property(nonatomic,strong)NSString *title;//歌曲名
@property(nonatomic,strong)NSString *songurl;//歌曲文件名
@property(nonatomic,strong)NSString *lrcname;//歌词文件名
@property(nonatomic,strong)NSString *author;//歌手
@property(nonatomic,strong)NSString *pic;//歌手图片
@property (nonatomic, strong) NSString *showLink;//分享的链接
@property (nonatomic, strong) NSString *songId;//歌曲的id
@end
