//
//  QueryViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/6/5.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface QueryViewController : UIViewController

@property(nonatomic, strong) UIView *menuView;
@property(nonatomic, strong) UITableView *tableView;


@property(nonatomic, strong) UILabel* fromLabel;
@property(nonatomic, strong) UILabel* toLabel;
@property(nonatomic, strong) UITextField* fromField;
@property(nonatomic, strong) UITextField* toField;
@property (nonatomic, strong) HMSegmentedControl *typeSc;

@property(nonatomic, strong) UIDatePicker *datePicker;



@end
