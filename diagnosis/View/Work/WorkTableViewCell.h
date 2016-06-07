//
//  WorkTableViewCell.h
//  diagnosis
//
//  Created by QUANTA on 16/6/7.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkModel.h"

@interface WorkTableViewCell : UITableViewCell


@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *countLabel;
@property(nonatomic, strong) WorkModel *workData;


@end
