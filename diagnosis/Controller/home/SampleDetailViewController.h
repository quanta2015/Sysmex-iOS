//
//  SampleDetailViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleDetailViewController : UIViewController

@property(nonatomic, strong) NSString *barcode;
@property(nonatomic) int status;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* thumbArray;
@property(nonatomic, strong) NSMutableArray* sampleListTitleArray;
@property(nonatomic, strong) NSMutableArray* cellTitleArray;

@end
