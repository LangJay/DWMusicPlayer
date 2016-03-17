//
//  DWTouTiaoModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWTouTiaoModel : DWBaseModel
@property (nonatomic, strong) NSString *listid;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSString *collectnum;
@property (nonatomic, assign) NSString *errorCode;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic300;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *listenum;
@property (nonatomic, strong) NSString *picW700;
@property (nonatomic, strong) NSString *pic500;
@end
@interface DWContentList : DWBaseModel
@property (nonatomic, strong) NSString *allRate;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *piaoId;
@property (nonatomic, strong) NSString *highRate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double learn;
@property (nonatomic, assign) double isFirstPublish;
@property (nonatomic, strong) NSString *toneid;
@property (nonatomic, strong) NSString *share;
@property (nonatomic, strong) NSString *isCharge;
@property (nonatomic, assign) double hasMv;
@property (nonatomic, strong) NSString *isKsong;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, strong) NSString *koreanBbSong;
@property (nonatomic, strong) NSString *relateStatus;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *resourceTypeExt;
@property (nonatomic, strong) NSString *mvProvider;
@property (nonatomic, assign) double hasMvMobile;
@property (nonatomic, strong) NSString *tingUid;
@property (nonatomic, assign) double havehigh;
@property (nonatomic, strong) NSString *songSource;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *copytype;
@end
@interface DWAlbumInfo : DWBaseModel
@property (nonatomic, strong) NSString *prodcompany;
@property (nonatomic, strong) NSString *publishcompany;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *picS1000;
@property (nonatomic, strong) NSString *picBig;
@property (nonatomic, assign) id recommendNum;
@property (nonatomic, strong) NSString *styles;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *picRadio;
@property (nonatomic, assign) id favoritesNum;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *songsTotal;
@property (nonatomic, strong) NSString *styleId;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *picSmall;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, assign) id allArtistTingUid;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *picS500;
@property (nonatomic, strong) NSString *artistTingUid;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *publishtime;
@end
@interface DWSongList : DWBaseModel
@property (nonatomic, strong) NSString *koreanBbSong;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *picBig;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *resourceTypeExt;
@property (nonatomic, strong) NSString *piaoId;
@property (nonatomic, assign) double hasMv;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *lrclink;
@property (nonatomic, strong) NSString *picSmall;
@property (nonatomic, strong) NSString *songSource;
@property (nonatomic, assign) double havehigh;
@property (nonatomic, strong) NSString *allArtistTingUid;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, strong) NSString *fileDuration;
@property (nonatomic, strong) NSString *toneid;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, assign) double learn;
@property (nonatomic, strong) NSString *mvProvider;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *delStatus;
@property (nonatomic, strong) NSString *albumNo;
@property (nonatomic, assign) double hasMvMobile;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, assign) double isFirstPublish;
@property (nonatomic, strong) NSString *allRate;
@property (nonatomic, strong) NSString *tingUid;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *versions;
@property (nonatomic, strong) NSString *copytype;
@end