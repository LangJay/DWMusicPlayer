//
//  DW1CollectionViewCell.h
//  逗我
//
//  Created by 周继良 on 15/11/12.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWScrollCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
