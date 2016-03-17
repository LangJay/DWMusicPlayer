//
//  DWRadioNetmanager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWRadioModel.h"

@interface DWRadioNetmanager : DWBaseNetManager
+(id)getDWRadioModeltWithCompletionHandle:(void(^)(DWRadioModel *model,NSError *error))completionHandle;
@end
