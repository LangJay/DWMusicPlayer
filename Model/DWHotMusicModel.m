//
//  DWHotMusicModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWHotMusicModel.h"

@implementation DWHotMusicModel
//定义两个数组对象中的元素，对应的解析类
+(NSDictionary *)objectClassInArray
{
    return @{@"songList":[DWHotSonglistModel class],@"billboard":[DWHotBillBoardModel class]};
}
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"songList":@"song_list"
             ,@"errorCode":@"error_code"
             };
}
@end
@implementation DWHotSonglistModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"koreanBbSong":@"korean_bb_song"
             ,@"picBig":@"pic_big"
             ,@"rankChange":@"rank_change"
             ,@"resourceTypeExt":@"resource_type_ext"
             ,@"piaoId":@"piao_id"
             ,@"hasMv":@"has_mv"
             ,@"picSmall":@"pic_small"
             ,@"songSource":@"song_source"
             ,@"artistName":@"artist_name"
             ,@"allArtistTingUid":@"all_artist_ting_uid"
             ,@"isNew":@"is_new"
             ,@"fileDuration":@"file_duration"
             ,@"artistId":@"artist_id"
             ,@"albumId":@"album_id"
             ,@"mvProvider":@"mv_provider"
             ,@"albumTitle":@"album_title"
             ,@"delStatus":@"del_status"
             ,@"soundEffect":@"sound_effect"
             ,@"albumNo":@"album_no"
             ,@"hasMvMobile":@"has_mv_mobile"
             ,@"songId":@"song_id"
             ,@"resourceType":@"resource_type"
             ,@"isFirstPublish":@"is_first_publish"
             ,@"allRate":@"all_rate"
             ,@"tingUid":@"ting_uid"
             ,@"allArtistId":@"all_artist_id"
             ,@"cpType":@"copy_type"
             ,@"relateStatus":@"relate_status"
             };
}
@end
@implementation DWHotBillBoardModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"billboardNo":@"billboard_no"
             ,@"picS640":@"pic_s640"
             ,@"billboardType":@"billboard_type"
             ,@"picS210":@"pic_s210"
             ,@"webUrl":@"web_url"
             ,@"picS444":@"error_code"
             ,@"updateDate":@"update_date"
             ,@"picS260":@"pic_s260"
             };
}
@end