//
//  DWSearchListModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWSearchListModel.h"

@implementation DWSearchListModel
+(NSDictionary *)objectClassInArray
{
    return @{@"songlist":[DwSearchSongModel class]};
}
@end
@implementation DwSearchSongModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"allRate":@"all_rate"
             ,@"allArtistId":@"all_artist_id"
             ,@"cpType":@"copy_type"
             ,@"hasMv":@"has_mv"
             ,@"resourceType":@"resource_type"
             ,@"mvProvider":@"mv_provider"
             ,@"relateStatus":@"relate_status"
             ,@"albumTitle":@"album_title"
             ,@"songId":@"song_id"
             ,@"hasMvMobile":@"has_mv_mobile"
             ,@"artistId":@"artist_id"
             ,@"songFileId":@"song_file_id"
             ,@"appendix":@"appendix"
             ,@"dataSource":@"data_source"
             ,@"albumId":@"album_id"
             };
}
@end