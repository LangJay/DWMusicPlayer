//
//  DWConstants.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/10/29.
//  Copyright © 2015年 周继良. All rights reserved.
//

#ifndef DWConstants_h
#define DWConstants_h

//通过RGB设置颜色
#define kRGBColor(R,G,B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kBackGroundColor   [UIColor colorWithRed:113/255.0 green:144/255.0 blue:227/255.0 alpha:1.0]
#define kPlayViewColor   [UIColor colorWithRed:75/255.0 green:112/255.0 blue:225/255.0 alpha:1.0]

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW   UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}\

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#endif /* DWConstants_h */
