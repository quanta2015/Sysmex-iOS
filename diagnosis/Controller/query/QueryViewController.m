//
//  QueryViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/5.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "QueryViewController.h"
#import "LGAlertView.h"

@interface QueryViewController ()

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

-(void) initView {
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, screen_width, 120)];
//    _menuView.backgroundColor = DEFAULT_LIGHT_GRAY_COLOR;
    [self.view addSubview:_menuView];
    
    _datePicker = [UIDatePicker new];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    _datePicker.locale = locale;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 110.f);

    INIT_LABEL(_fromLabel, M_MARGIN, M_MARGIN, 50, 30, 12, DEFAULT_DARK_GRAY_COLOR, @"起：", _menuView);
    INIT_FIELD(_fromField, 45, M_MARGIN, screen_width/2, 30, 16, @"输入开始日期" , 100 , DEFAULT_FONT_MID_COLOR, _menuView);
    
    INIT_LABEL(_toLabel, M_MARGIN + screen_width/2 , M_MARGIN, 50, 30, 12, DEFAULT_DARK_GRAY_COLOR, @"止：", _menuView);
    INIT_FIELD(_toField, 45 + screen_width/2, M_MARGIN, screen_width/2, 30, 16, @"输入截止日期" , 101, DEFAULT_FONT_MID_COLOR, _menuView);
    
    
    _typeSc = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Trending", @"News", @"Library"]];
    _typeSc.frame = CGRectMake(10, 50, screen_width-20, 40);
    _typeSc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _typeSc.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _typeSc.backgroundColor = [UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1];
    _typeSc.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    _typeSc.selectionIndicatorColor = [UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1];
    _typeSc.selectionStyle = HMSegmentedControlSelectionStyleBox;
    _typeSc.selectedSegmentIndex = 0;
    _typeSc.shouldAnimateUserSelection = NO;
    [_typeSc addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [_menuView addSubview:_typeSc];

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 100) {
        SHOW_DATAPICKER( _datePicker, _fromField);
    }else {
        SHOW_DATAPICKER( _datePicker, _toField);
    }
    
    return NO;
}


//点击RETURN隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
