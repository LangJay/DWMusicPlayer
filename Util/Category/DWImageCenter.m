//
//  DWImageCenter.m
//  逗我
//
//  Created by 周继良 on 15/11/24.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWImageCenter.h"

@implementation DWImageCenter
+(id)sharedImageCenter
{
    //声明一个空的静态的单例对象
    static DWImageCenter *sharedImageCenter = nil;
    //声明一个静态的gcd的单次任务
    static dispatch_once_t onceToken;
    //执行gcd的单次任务，把单例初始化
    dispatch_once(&onceToken, ^{
        sharedImageCenter = [[self alloc] init];
    });
    //返回单例对象
    return sharedImageCenter;
}
-(id)init
{
    if (self = [super init]) {
        self.cachedImages = [NSMutableDictionary new];
    }
    return self;
}
@end
