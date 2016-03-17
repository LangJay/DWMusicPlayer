//
//  DWRecommendNetManager.h
//  逗我
//
//  Created by 周继良 on 15/11/13.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "DWRecommendList.h"

@interface DWRecommendNetManager : DWBaseNetManager
+(id)getDWRecommendListWithCompletionHandle:(void(^)(DWRecommendList *model,NSError *error))completionHandle;
@end
