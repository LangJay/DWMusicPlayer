//
//  DWSongModel.m
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSongModel.h"

@implementation DWSongModel
+(NSDictionary *)objectClassInArray
{
    return @{@"songurl":[DWSongUrl class]};
}
@end
@implementation DWSongUrl

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"canLoad":@"can_load"
             ,@"canSee":@"can_see"
             ,@"downType":@"down_type"
             ,@"fileBitrate":@"file_bitrate"
             ,@"fileDuration":@"file_duration"
             ,@"fileExtension":@"file_extension"
             ,@"fileLink":@"file_link"
             ,@"fileSize":@"file_size"
             ,@"isUditionUrl":@"is_udition_url"
             ,@"replaygain":@"replay_gain"
             ,@"showLink":@"show_link"
             ,@"songFileId":@"song_file_id"
             ,@"hash1":@"hash"
             };
}

@end