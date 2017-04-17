//
//  WorkViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/7.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "WorkViewController.h"
#import "WorkTableViewCell.h"
#import "WorkModel.h"

@interface WorkViewController ()

@end

@implementation WorkViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initQueryView];
    [self initTableView];
    
}

-(void) initQueryView {
    
    self.view.backgroundColor = DEFAULT_LIGHT_GRAY_COLOR;
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0,NAV_HEIGHT, screen_width, WORKMENU_HEIGHT)];
    _menuView.backgroundColor = DEFAULT_WHITE_COLOR;
    [self.view addSubview:_menuView];
    
    _menuView.clipsToBounds=YES;
    
    _datePicker = [UIDatePicker new];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    _datePicker.locale = locale;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 110.f);
    
    INIT_LABEL(_fromLabel, M_MARGIN, 15, 50, 30, 14, DEFAULT_DARK_GRAY_COLOR, NSLocalizedString(@"from", nil), _menuView);
    INIT_FIELD(_fromField, 45, 13, screen_width/2, 30, 18, NSLocalizedString(@"info-input-fdate", nil), 100 , DEFAULT_FONT_MID_COLOR, _menuView);
    
    INIT_LABEL(_toLabel, M_MARGIN + screen_width/2 -10 , 15, 50, 30, 12, DEFAULT_DARK_GRAY_COLOR, NSLocalizedString(@"to", nil), _menuView);
    INIT_FIELD(_toField, 35 + screen_width/2, 13, screen_width/2, 30, 18, NSLocalizedString(@"info-input-edate", nil) , 101, DEFAULT_FONT_MID_COLOR, _menuView);
    
    //设置默认日期
    GET_N_DAY(_fromField, 30);
    GET_TODAY(_toField);
    
    //查询按钮
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queryBtn.frame = CGRectMake(L_MARGIN, 55, screen_width-L_MARGIN*2, 32);
    queryBtn.titleLabel.font = [UIFont systemFontOfSize: 16];
    queryBtn.backgroundColor = DEFAULT_THEME_COLOR;
    queryBtn.layer.cornerRadius = 5;
    queryBtn.tag = 200;
    [queryBtn setAdjustsImageWhenDisabled:YES];
    [queryBtn setTitle:NSLocalizedString(@"confirm", nil) forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(queryTap:) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:queryBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, WORKMENU_HEIGHT-LINE_HEIGHT, screen_width, LINE_HEIGHT)];
    lineView.backgroundColor = DEFAULT_SEPARATER_COLOR;
    [_menuView addSubview:lineView];
}

-(void)initTableView{

    _workArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WORKMENU_HEIGHT + NAV_HEIGHT , screen_width, screen_height- WORKMENU_HEIGHT - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)queryTap:(UIButton *)sender{
    [self getAjaxData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _workArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    static NSString *cellIndentifier = @"SampleTableViewCell";
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[WorkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    
    
    if(_workArray.count!=0){
        WorkModel *work = _workArray[row];
        [cell setWorkData:work];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.opaque = YES;
    return cell;
}

-(void)getAjaxData{
    
    NSDictionary *parameters = @{@"fromdate":_fromField.text,@"todate":_toField.text};
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetWorkInfo successBlock:^(id responseBody){

        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
            
            
            [_workArray removeAllObjects];
            for (int i = 0; i < dataDic.count; i++) {
                WorkModel *item = [WorkModel objectWithKeyValues:dataDic[i]];
                
                switch (item.status) {
                    case 4:
                        item.title = NSLocalizedString(@"to-diag-count", nil);
                        break;
                    case 5:
                        item.title = NSLocalizedString(@"return-count", nil);
                        break;
                    case 6:
                        item.title = NSLocalizedString(@"diaged-count", nil);
                        break;
                }
                [_workArray addObject:item];
            }
            
            
            
            [self.tableView reloadData];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (textField.tag == 100) {
        SHOW_DATAPICKER( _datePicker, _fromField);
        return NO;
    }else{
        SHOW_DATAPICKER( _datePicker, _toField);
        return NO;
    }

}


@end
