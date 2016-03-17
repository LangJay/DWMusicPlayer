//
//  DWRecommendList.m
//  逗我
//
//  Created by 周继良 on 15/11/13.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRecommendList.h"

@implementation DWRecommendList
//定义两个数组对象中的元素，对应的解析类
+(NSDictionary *)objectClassInArray
{
    return @{@"list":[songListModel class]};
}
@end
@implementation songListModel
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"cpType":@"copy_type"
             ,@"allArtistId":@"all_artist_id"
             ,@"piaoId":@"piao_id"
             ,@"isFirstPublish":@"is_first_publish"
             ,@"picBig":@"pic_big"
             ,@"allRate":@"all_rate"
             ,@"hasMv":@"has_mv"
             ,@"picSinger":@"pic_singer"
             ,@"koreanBbSong":@"korean_bb_song"
             ,@"relateStatus":@"relate_status"
             ,@"songId":@"song_id"
             ,@"albumTitle":@"album_title"
             ,@"resourceTypeExt":@"resource_type_ext"
             ,@"picPremium":@"pic_premium"
             ,@"hasMvMobile":@"has_mv_mobile"
             ,@"albumNo":@"album_no"
             ,@"picSmall":@"pic_small"
             ,@"allArtistTingUid":@"all_artist_ting_uid"
             ,@"tingUid":@"ting_uid"
             ,@"songSource":@"song_source"
             ,@"albumId":@"album_id"
             ,@"picHuge":@"pic_huge"
             };
}
@end