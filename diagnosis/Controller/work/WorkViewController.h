//
//  WorkViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/6/7.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGAlertView.h"

@interface WorkViewController : UIViewController


@property(nonatomic, strong) UIView *menuView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* workArray;



@property(nonatomic, strong) UILabel* fromLabel;
@property(nonatomic, strong) UILabel* toLabel;
@property(nonatomic, strong) UITextField* fromField;
@property(nonatomic, strong) UITextField* toField;
@property(nonatomic, strong) UIDatePicker *datePicker;

@end
