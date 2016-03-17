//
//  DWImageCenter.h
//  逗我
//
//  Created by 周继良 on 15/11/24.
//  Copyright © 2015年 周继良. All rights reserved.
//  图片缓存单例

#import <Foundation/Foundation.h>

@interface DWImageCenter : NSObject
@property (nonatomic, strong) NSMutableDictionary *cachedImages;
+(id)sharedImageCenter;
@end
