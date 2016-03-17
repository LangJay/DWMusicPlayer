//
//  DWRecommendList.h
//  逗我
//
//  Created by 周继良 on 15/11/13.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWRecommendList : DWBaseModel
@property (nonatomic, assign) double havemore;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) double date;
@end
@interface songListModel : DWBaseModel
@property (nonatomic, strong) NSString *cpType;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double learn;
@property (nonatomic, strong) NSString *piaoId;
@property (nonatomic, assign) double isFirstPublish;
@property (nonatomic, strong) NSString *picBig;
@property (nonatomic, strong) NSString *toneid;
@property (nonatomic, strong) NSString *allRate;
@property (nonatomic, assign) double hasMv;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *picSinger;
@property (nonatomic, strong) NSString *koreanBbSong;
@property (nonatomic, strong) NSString *relateStatus;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *resourceTypeExt;
@property (nonatomic, strong) NSString *picPremium;
@property (nonatomic, assign) double hasMvMobile;
@property (nonatomic, strong) NSString *albumNo;
@property (nonatomic, strong) NSString *picSmall;
@property (nonatomic, strong) NSString *allArtistTingUid;
@property (nonatomic, strong) NSString *tingUid;
@property (nonatomic, assign) double havehigh;
@property (nonatomic, strong) NSString *songSource;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *picHuge;
@end