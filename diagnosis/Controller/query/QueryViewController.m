//
//  QueryViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/5.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "QueryViewController.h"
#import "LGAlertView.h"
#import "SampleModel.h"
#import "SampleTableViewCell.h"
#import "SampleDetailViewController.h"

@interface QueryViewController ()<UITableViewDataSource, UITableViewDelegate, refreshTableDelegate>{
    int pagenum;
    int statusType;
    UIView *lineView;
}

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initQueryView];
    [self initTableView];
    
    [self setUpTableView];
}

-(void) initQueryView {
    
    self.view.backgroundColor = DEFAULT_LIGHT_GRAY_COLOR;
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0,NAV_HEIGHT, screen_width, QUERYMENU_HEIGHT_S)];
    _menuView.backgroundColor = DEFAULT_WHITE_COLOR;
    [self.view addSubview:_menuView];
    
    _menuView.clipsToBounds=YES;
    
    _datePicker = [UIDatePicker new];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    _datePicker.locale = locale;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 110.f);

    INIT_LABEL(_fromLabel, M_MARGIN, M_MARGIN +40, 50, 30, 14, DEFAULT_DARK_GRAY_COLOR, @"起：", _menuView);
    INIT_FIELD(_fromField, 45, 8+40, screen_width/2, 30, 18, @"输入开始日期" , 100 , DEFAULT_FONT_MID_COLOR, _menuView);
    
    INIT_LABEL(_toLabel, M_MARGIN + screen_width/2 -10 , M_MARGIN+40, 50, 30, 12, DEFAULT_DARK_GRAY_COLOR, @"止：", _menuView);
    INIT_FIELD(_toField, 35 + screen_width/2, 8+40, screen_width/2, 30, 18, @"输入截止日期" , 101, DEFAULT_FONT_MID_COLOR, _menuView);
    
    //设置默认日期
    GET_YESTERDAY(_fromField);
    GET_TODAY(_toField);
    
    //切片类型按钮
    _typeSc = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"待阅片", @"已阅片", @"退回"]];
    _typeSc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _typeSc.frame = CGRectMake(20, 40*2, screen_width-40, 30);
    _typeSc.selectionStyle = HMSegmentedControlSelectionStyleBox;
    _typeSc.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    _typeSc.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _typeSc.titleTextAttributes = @{NSForegroundColorAttributeName : DEFAULT_WHITE_COLOR, UITextAttributeFont: [UIFont boldSystemFontOfSize:13.0f]};
    _typeSc.selectionIndicatorColor = [UIColor colorWithRed:.1 green:.6 blue:1 alpha:1];
    _typeSc.verticalDividerEnabled = YES;
    _typeSc.verticalDividerColor = [UIColor whiteColor];
    _typeSc.verticalDividerWidth = 2.0f;
    _typeSc.shouldAnimateUserSelection = NO;
    [_typeSc addTarget:self action:@selector(selectSampleType:) forControlEvents:UIControlEventValueChanged];
    [_menuView addSubview:_typeSc];
    
    //查询关键字输入框
    _keyword = [[UITextField alloc] initWithFrame:CGRectMake(L_MARGIN,10,screen_width-L_MARGIN*2,32)];
    _keyword.placeholder = @"请输入关键字";
    _keyword.textAlignment = UITextAlignmentCenter;
    _keyword.font = [UIFont boldSystemFontOfSize:14];
    _keyword.layer.cornerRadius = 4;
    _keyword.layer.borderColor = [DEFAULT_SEPARATER_COLOR CGColor];
    _keyword.layer.borderWidth= 1.0f;
    _keyword.delegate = self;
    _keyword.backgroundColor = DEFAULT_WHITE_COLOR;
    _keyword.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    [leftImageView setFrame:CGRectMake(12, 10, 15, 15)];
    [_keyword addSubview:leftImageView];
    [_menuView addSubview:_keyword];
    
    //查询按钮
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queryBtn.frame = CGRectMake(L_MARGIN, 120, screen_width-L_MARGIN*2, 32);
    queryBtn.titleLabel.font = [UIFont systemFontOfSize: 16];
    queryBtn.backgroundColor = DEFAULT_THEME_COLOR;
    queryBtn.layer.cornerRadius = 5;
    queryBtn.tag = 200;
    [queryBtn setAdjustsImageWhenDisabled:YES];
    [queryBtn setTitle:@"确定" forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(queryTap:) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:queryBtn];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, QUERYMENU_HEIGHT_S-LINE_HEIGHT, screen_width, LINE_HEIGHT)];
    lineView.backgroundColor = DEFAULT_SEPARATER_COLOR;
    [_menuView addSubview:lineView];
}

-(void)initTableView{
    
    pagenum = 0;
    statusType = 4;
    
    _sampleArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, QUERYMENU_HEIGHT_S + NAV_HEIGHT, screen_width, screen_height- QUERYMENU_HEIGHT_S - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)setUpTableView{
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    [self.tableView.gifHeader beginRefreshing];
    
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(refreshDataNextPage)];
//    [self.tableView.gifFooter endRefreshing];
    
    _tableView.gifFooter.hidden = YES;
}

-(void)getAjaxData{
    
    _tableView.gifFooter.hidden = NO;
    [_tableView.footer setTitle:@"加载完毕！" forState:MJRefreshFooterStateNoMoreData];
    
    NSDictionary *parameters = @{@"pageIndex":IntToStr(pagenum),@"pageSize":@"5",@"type":IntToStr(statusType),@"fromdate":_fromField.text,@"todate":_toField.text,@"keyword":@""};
    
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetSampleListQ successBlock:^(id responseBody){
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        NSInteger page = [[responseBody objectForKey:@"page"] integerValue];
        if (code==0) {
            NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
            int total = StrToInt([responseBody objectForKey:@"total"]);
            
            //判断返回是否为空
            if (IsNilOrNull(dataDic)) {
                return;
            }
            
            //返回结果为空
            if (dataDic.count == 0) {
                [_tableView.gifFooter noticeNoMoreData];
                [_tableView.footer setTitle:@"查询结果为空！" forState:MJRefreshFooterStateNoMoreData];
            }
            
            //判断是否为最后一页
            if (_sampleArray.count+dataDic.count == total) {
              [self.tableView.gifFooter noticeNoMoreData];
            }
            
            for (int i = 0; i < dataDic.count; i++) {
                SampleModel *item = [SampleModel objectWithKeyValues:dataDic[i]];
                [_sampleArray addObject:item];
            }
            [self.tableView reloadData];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        
        NSLog(@"：%@",error);
        AlertMessage(error);
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}


//取服务器数据
-(void) refreshData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        pagenum = 0;
        [_sampleArray removeAllObjects];
        [self getAjaxData];
    });
}

//取服务器数据
-(void) refreshDataNextPage {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        pagenum++;
        [self getAjaxData];
    });
}

-(void) refreshSampleTable {
    [self refreshData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sampleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    static NSString *cellIndentifier = @"SampleTableViewCell";
    SampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[SampleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if(_sampleArray.count!=0){
        SampleModel *sample = _sampleArray[row];
        [cell setSampleData:sample];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.opaque = YES;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    
    SampleDetailViewController *detailVC = [[SampleDetailViewController alloc] init];
    ;
    detailVC.delegate = self;
    detailVC.barcode = ((SampleModel *)_sampleArray[row]).barcode;
    detailVC.status = ((SampleModel *)_sampleArray[row]).diagnosestatus;
    [self.navigationController pushViewController:detailVC animated:NO];
    [super.navigationController setNavigationBarHidden:false animated:TRUE];
    
}


- (void)selectSampleType:(HMSegmentedControl *)segmentedControl {
    
    switch ((long)segmentedControl.selectedSegmentIndex) {
        case 0:
            statusType = 4;
            break;
        case 1:
            statusType = 6;
            break;
        case 2:
            statusType = 5;
            break;
    }
}


- (void)queryTap:(UIButton *)sender{
    [self hideQueryView];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    _tableView.hidden = true;
    
    switch (textField.tag) {
        case 100:
            SHOW_DATAPICKER( _datePicker, _fromField);
            [_keyword endEditing:YES];
            return NO;
            break;
        case 101:
            SHOW_DATAPICKER( _datePicker, _toField);
            [_keyword endEditing:YES];
            return NO;
            break;
        default:
            [self showQueryView];
            return YES;
            break;
    }
}

-(void)showQueryView {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_menuView setFrame:CGRectMake(0,STATUSBAR_HEIGHT, screen_width, QUERYMENU_HEIGHT_L)];
    [_tableView setFrame:CGRectMake(0,STATUSBAR_HEIGHT + QUERYMENU_HEIGHT_L, screen_width, screen_height- QUERYMENU_HEIGHT_L - NAV_HEIGHT)];
    [lineView setFrame:CGRectMake(0, QUERYMENU_HEIGHT_L-LINE_HEIGHT, screen_width, LINE_HEIGHT)];
}

-(void)hideQueryView {
    [_menuView setFrame:CGRectMake(0, NAV_HEIGHT, screen_width, QUERYMENU_HEIGHT_S)];
    [_tableView setFrame:CGRectMake(0, QUERYMENU_HEIGHT_S + NAV_HEIGHT, screen_width, screen_height- QUERYMENU_HEIGHT_S - NAV_HEIGHT)];
    [lineView setFrame:CGRectMake(0, QUERYMENU_HEIGHT_S-LINE_HEIGHT, screen_width, LINE_HEIGHT)];

    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view endEditing:YES];
    
    _tableView.hidden = false;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideQueryView];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

//点击RETURN隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField.tag == 200 ) { //如果是关键字输入框
        [self hideQueryView];
    };
    
    [textField resignFirstResponder];
    return YES;
}



@end
