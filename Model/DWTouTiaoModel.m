//
//  DWTouTiaoModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWTouTiaoModel.h"

@implementation DWTouTiaoModel
//定义两个数组对象中的元素，对应的解析类
+(NSDictionary *)objectClassInArray
{
    return @{@"content":[DWContentList class]};
}
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"errorCode":@"error_code"
    ,@"picW700":@"pic_w700"};
}
@end
@implementation DWContentList

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"songId":@"song_id"
             ,@"albumId":@"album_id"
             ,@"albumTitle":@"album_title"
             ,@"relateStatus":@"relate_status"
             ,@"isCharge":@"is_charge"
             ,@"allRate":@"all_rate"
             ,@"highRate":@"high_rate"
             ,@"allArtistId":@"all_artist_id"
             ,@"copytype":@"copy_type"
             ,@"hasMv":@"has_mv"
             ,@"resourceType":@"resource_type"
             ,@"isKsong":@"is_ksong"
             ,@"hasMvMobile":@"has_mv_mobile"
             ,@"tingUid":@"ting_uid"
             ,@"isFirstPublish":@"is_first_publish"
             ,@"songSource":@"song_source"
             ,@"piaoId":@"piao_id"
             ,@"koreanBbSong":@"korean_bb_song"
             ,@"resourceTypeExt":@"resource_type_ext"
             ,@"mvProvider":@"mv_provider"
             };
}
@end
@implementation DWAlbumInfo

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"songsTotal":@"songs_total"
             ,@"albumId":@"album_id"
             ,@"styleId":@"style_id"
             ,@"artistTingUid":@"artist_ting_uid"
             ,@"allArtistTingUid":@"all_artist_ting_uid"
             ,@"picSmall":@"pic_small"
             ,@"picBig":@"pic_big"
             ,@"favoritesNum":@"favorites_num"
             ,@"recommendNum":@"recommend_num"
             ,@"artistId":@"artist_id"
             ,@"allArtistId":@"all_artist_id"
             ,@"picRadio":@"pic_radio"
             ,@"picS500":@"pic_s500"
             ,@"picS1000":@"pic_s1000"
             };
}
@end
@implementation DWSongList

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"fileDuration":@"file_duration"
             ,@"albumNo":@"album_no"
             ,@"artistId":@"artist_id"
             ,@"allArtistId":@"all_artist_id"
             ,@"allArtistTingUid":@"all_artist_ting_uid"
             ,@"picSmall":@"pic_small"
             ,@"picBig":@"pic_big"
             ,@"delStatus":@"del_status"
             ,@"resourceType":@"resource_type"
             ,@"copytype":@"copy_type"
             ,@"hasMvMobile":@"has_mv_mobile"
             ,@"allRate":@"all_rate"
             ,@"songId":@"song_id"
             ,@"tingUid":@"ting_uid"
             ,@"albumId":@"album_id"
             ,@"albumTitle":@"album_title"
             ,@"isFirstPublish":@"is_first_publish"
             ,@"piaoId":@"piao_id"
             ,@"koreanBbSong":@"korean_bb_song"
             ,@"resourceTypeExt":@"resource_type_ext"
             ,@"mvProvider":@"mv_provider"
             };
}

@end