//
//  DWRadioModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRadioModel.h"

@implementation DWRadioModel
//定义两个数组对象中的元素，对应的解析类
+(NSDictionary *)objectClassInArray
{
    return @{@"list":[DWRadioList class]};
}
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"errorCode":@"error_code"
             };
}
@end
@implementation DWRadioList

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"albumId":@"album_id"
             };
}

@end