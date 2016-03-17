//
//  DWMVViewModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/13.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DWMVViewModel.h"
#import "DWMVNetManager.h"

@implementation DWMVViewModel
-(void)getMVDataFromNetCompleteHandle:(CompletionHandle)completionHandle WithSongID:songID
{
    self.dataTask = [DWMVNetManager getDWMVModeltWithCompletionHandle:^(NSDictionary *contentDict, NSError *error) {
        self.path = [[[[contentDict valueForKey:@"result"] valueForKey:@"files"] valueForKey:@"31"] valueForKey:@"source_path"];
        completionHandle(error);
    } WithSongID:songID];
}
-(NSString *)getSourcePath
{
    return self.path;
}
@end
