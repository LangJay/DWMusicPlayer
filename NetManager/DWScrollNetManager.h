//
//  DWScrollNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWScrollModel.h"

@interface DWScrollNetManager : DWBaseNetManager
+(id)getDWScrollModeltWithCompletionHandle:(void(^)(DWScrollModel *model,NSError *error))completionHandle;
@end
