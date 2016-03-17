//
//  DWRecommendTableViewCell.m
//  逗我
//
//  Created by 周继良 on 15/11/14.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWRecommendTableViewCell.h"
#import "UIImage+Circle.h"
#import "DWRecommendViewModel.h"

@interface DWRecommendTableViewCell ()
@property (nonatomic, strong) DWRecommendViewModel *recommendVM;
@end

@implementation DWRecommendTableViewCell

-(void)setList:(songListModel *)list
{
    _list = list;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:list.picSmall] placeholderImage:[UIImage imageNamed:@"hd.jpg"]];
    self.imageView.image = [UIImage scaleTosize:self.imageView.image size:CGSizeMake(self.bounds.size.height - 5, self.bounds.size.height - 5)];
    self.imageView.image = [UIImage circleImageWithImage:self.imageView.image borderWidth:4 borderColor:[UIColor grayColor]];
    self.textLabel.text = list.title;
    self.detailTextLabel.text = list.author;
}


- (DWRecommendViewModel *)recommendVM {
    if(_recommendVM == nil) {
        _recommendVM = [[DWRecommendViewModel alloc] init];
    }
    return _recommendVM;
}

@end
