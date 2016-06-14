//
//  ConfigMenuTableViewCell.h
//  diagnosis
//
//  Created by QUANTA on 16/6/14.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigMenuTableViewCell : UITableViewCell


@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *titleImage;

-(void)setMenuData:(int)index;

@end
