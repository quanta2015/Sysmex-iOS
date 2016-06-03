//
//  SampleDetailViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SampleDetailViewController.h"
#import "SampleDetailModel.h"
#import "SampleBasicInfoTableViewCell.h"
#import "SampleImgInfoTableViewCell.h"

#import "LGAlertView.h"


@interface SampleDetailViewController ()<UITextFieldDelegate> {
    
    SampleDetailModel *sample;
    NSUserDefaults *ud;
    int role;
    NSString * backReason;
}

@end

@implementation SampleDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initMenuView];
    [self initTableView];
   
    [self getAjaxData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    
    
    _thumbArray = [[NSMutableArray alloc] init];
    _sampleListTitleArray = SAMPLE_LIST_TITLE_ARRAY;
    _cellTitleArray = SAMPLE_CELL_TITLE_ARRAY;
    
    for (int i=0;i<7;i++) {
        [_thumbArray addObject:@""];
    }
}

-(void)initMenuView{
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, HOMEMENU_HEIGHT)];
    menuView.backgroundColor = DEFAULT_WHITE_COLOR;
    [self.view addSubview:menuView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HOMEMENU_HEIGHT-LINE_HEIGHT, screen_width, LINE_HEIGHT)];
    lineView.backgroundColor = DEFAULT_SEPARATER_COLOR;
    [menuView addSubview:lineView];
    
//    ud = [NSUserDefaults standardUserDefaults];
//    role = StrToInt([ud objectForKey:@"role"]);
    
    switch (_status) {
        case 5: //退回
            [self initBack:menuView];
            break;
        case 4: //待阅片
            [self initDiag:menuView];
            break;
        case 6: //已阅片
            [self initReport:menuView];
            break;
    }
    
    
}

-(void)initReport:(UIView *)menuView {
    
    UIView * btnView;
    UILabel * btnTitle;
    UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenuView:)];
    INIT_MENU_VIEW(btnView, L_MARGIN, M_MARGIN, screen_width_3p, HOMEMENU_HEIGHT-M_MARGIN*2, DEFAULT_DARK_GRAY_COLOR, _status*10, menuTap)
    INIT_LABEL(btnTitle, 0, 0, btnView.frame.size.width, HOMEMENU_HEIGHT-M_MARGIN*2, 12, DEFAULT_WHITE_COLOR, @"诊断建议", btnView)
    
    [menuView addSubview:btnView];
}

-(void)initBack:(UIView *)menuView {
    
    UIView * btnView;
    UILabel * btnTitle;
    UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenuView:)];
    INIT_MENU_VIEW(btnView, L_MARGIN, M_MARGIN, screen_width_3p, HOMEMENU_HEIGHT-M_MARGIN*2, DEFAULT_DARK_GRAY_COLOR, _status*10, menuTap)
    INIT_LABEL(btnTitle, 0, 0, btnView.frame.size.width, HOMEMENU_HEIGHT-M_MARGIN*2, 12, DEFAULT_WHITE_COLOR, @"退回原因", btnView)
    
    [menuView addSubview:btnView];
}

-(void)initDiag:(UIView *)menuView {
    
    NSArray* menuTitle = [NSArray arrayWithObjects:@"阅片完成",@"退回",nil];
    
    for (int i=0; i<2; i++) {
        UIView * btnView;
        UILabel * btnTitle;
        UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenuView:)];
        
        INIT_MENU_VIEW(btnView, i*(screen_width_3p+L_MARGIN)+L_MARGIN, M_MARGIN, screen_width_3p, HOMEMENU_HEIGHT-M_MARGIN*2, DEFAULT_DARK_GRAY_COLOR, _status*10+i, menuTap);
        INIT_LABEL(btnTitle, 0, 0, btnView.frame.size.width, HOMEMENU_HEIGHT-M_MARGIN*2, 12, DEFAULT_WHITE_COLOR, menuTitle[i], btnView);
        
        [menuView addSubview:btnView];
    }
}

-(void)tapMenuView:(UITapGestureRecognizer *)sender{
    
    int status = sender.view.tag;
    NSLog(@"reason tag:%d",status);
    LGAlertView *alertView;
    
    switch (status) {
        case 50: //退回
            [self SampleBackReason];
            break;
        case 40: //诊断完成
            ALERT_COMFORM(@"是否确定完成阅片？", SampleFinish);
            break;
        case 41: //退回
            ALERT_PROMOPT(alertView, @"退回！", @"请输入退回的原因！", backReason);
            break;

    }
//    AlertMessage(@"reason");
}


-(void)initTableView{
    
    HIDDEN_SCROLLVIEW;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HOMEMENU_HEIGHT, screen_width, screen_height - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 160;
    }else{
        
        if (IsNilOrNull(sample)) {
            return 0;
        }
        int c =((NSMutableArray *)_thumbArray[indexPath.row-1]).count;
        return ceil((float)c/4)*(thumb_width + M_MARGIN) + 30;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int i = indexPath.row;
    if (indexPath.row == 0) {
        SampleBasicInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleBasicInfoTableViewCell"];
        if (cell == nil) {
            cell = [[SampleBasicInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SampleBasicInfoTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSampleData:sample];
        return cell;
    }else {
        
        SampleImgInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellTitleArray[indexPath.row-1]];
        if (cell == nil) {
            cell = [[SampleImgInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellTitleArray[indexPath.row-1]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!IsNilOrNull(sample)) {
            [cell setDataList:_thumbArray[indexPath.row-1] :_sampleListTitleArray[indexPath.row-1]];
        }
        
        return cell;
    }
}

-(void)SampleFinish{
    NSDictionary *parameters = @{@"barcode":_barcode};
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlReadFinished successBlock:^(id responseBody){
        
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            [self.delegate refreshSampleTable];

            [self.navigationController popViewControllerAnimated:NO];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
}

-(void)SampleBackReason{
    NSDictionary *parameters = @{@"barcode":_barcode};
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetBackReason successBlock:^(id responseBody){
        
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
            //判断返回是否为空
            if (IsNilOrNull(dataDic)) {
                return;
            }

            NSString * tmpStr = @"";
            NSMutableArray * tmpArr = [responseBody objectForKey:@"data"];
            
            
            for(int i=0;i<tmpArr.count;i++) {
                
                tmpStr = StrCatMsg(tmpStr,i+1, @".",[tmpArr[i] objectForKey:@"backReason"], @"[",[tmpArr[i] objectForKey:@"experter"],@"]");
            }
            AlertMessage(tmpStr);
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
}

-(void)getAjaxData{

    NSDictionary *parameters = @{@"barcode":_barcode};
    
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetSampleInfo successBlock:^(id responseBody){

        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
            //判断返回是否为空
            if (IsNilOrNull(dataDic)) {
                return;
            }
            
            sample = [SampleDetailModel objectWithKeyValues:dataDic];
            _thumbArray[0] = sample.machineList;
            _thumbArray[1] = sample.graphList;
            _thumbArray[2] = sample.alertList;
            _thumbArray[3] = sample.historyList;
            _thumbArray[4] = sample.otherList;
            _thumbArray[5] = sample.microscopeList;
            self.title = sample.barcode;
            
            [self.tableView reloadData];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
//        [self.tableView.header endRefreshing];
    }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",textField.text);
    backReason = textField.text;
    return YES;
}

@end
