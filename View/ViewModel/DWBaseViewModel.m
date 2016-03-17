//
//  DWBaseViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/10/29.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"

@implementation DWBaseViewModel

- (void)cancelTask{
    [self.dataTask cancel];
}

- (void)suspendTask{
    [self.dataTask suspend];
}

- (void)resumeTask{
    [self.dataTask resume];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

@end
