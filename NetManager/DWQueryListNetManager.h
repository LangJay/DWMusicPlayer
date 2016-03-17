//
//  DWQueryListNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWQueryListModel.h"

@interface DWQueryListNetManager : DWBaseNetManager
+(id)getDWQueryListWithQuery:(NSString *)query WithCompletionHandle:(void(^)(DWQueryListModel *model,NSError *error))completionHandle;
@end
