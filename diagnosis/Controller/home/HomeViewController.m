//
//  HomeViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/5/29.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "HomeViewController.h"
#import "SampleModel.h"
#import "SampleTableViewCell.h"
#import "SampleDetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, refreshTableDelegate>{
    int pagenum;
    int statusType;
    UIView *toDiagView;
    UIView *finishedView;
}

@end

@implementation HomeViewController


-(void)viewWillAppear:(BOOL)animated {
    
    [self setUpTableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initTableView{
    
    HIDDEN_SCROLLVIEW;
    
    pagenum = 0;
    statusType = 0;
    _sampleArray = [[NSMutableArray alloc] init];


    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, HOMEMENU_HEIGHT)];
    menuView.backgroundColor = DEFAULT_LIGHT_GRAY_COLOR;
    [self.view addSubview:menuView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HOMEMENU_HEIGHT-LINE_HEIGHT, screen_width, LINE_HEIGHT)];
    lineView.backgroundColor = DEFAULT_SEPARATER_COLOR;
    [menuView addSubview:lineView];
    

    NSArray *menuTitleArray = HOME_MENU_TITLE_ARRAY;
    
    for (int i = 0; i < 2; ++i) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapMenuView:)];
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(i*(screen_width_2p+L_MARGIN)+L_MARGIN, M_MARGIN, screen_width_2p, HOMEMENU_HEIGHT-M_MARGIN*2)];
        btnView.backgroundColor = DEFAULT_DARK_GRAY_COLOR;
        btnView.tag = 100+i;
        [btnView addGestureRecognizer:tap];
        
        UILabel *btnTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btnView.frame.size.width, HOMEMENU_HEIGHT-M_MARGIN*2)];
        btnTitle.font = [UIFont boldSystemFontOfSize:14];
        btnTitle.textColor = DEFAULT_WHITE_COLOR;
        btnTitle.textAlignment = NSTextAlignmentCenter;
        btnTitle.text = menuTitleArray[i];
        [btnView addSubview:btnTitle];
        
        [menuView addSubview:btnView];
        
        (i==0)?(toDiagView = btnView):(finishedView = btnView);

    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HOMEMENU_HEIGHT, screen_width, screen_height- HOMEMENU_HEIGHT - TAB_HEIGHT) style:UITableViewStyleGrouped];
    ;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)OnTapMenuView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%d",sender.view.tag);
    switch (sender.view.tag) {
        case 100:
            statusType = 0;
            break;
        case 101:
            statusType = 1;
            break;
        case 102:
            statusType = 1;
            break;
    }
    
    [self refreshData];
}

-(void)setUpTableView{
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.tableView.gifHeader beginRefreshing];
    
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(refreshDataNextPage)];
    [self.tableView.gifFooter endRefreshing];
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
    static NSString *cellIndentifier = @"newscell";
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

-(void)getAjaxData{
    
    NSDictionary *parameters = @{@"pageIndex":IntToStr(pagenum),@"pageSize":@"5",@"isFinished":IntToStr(statusType)};
    
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetSampleList successBlock:^(id responseBody){
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        NSInteger page = [[responseBody objectForKey:@"page"] integerValue];
        if (code==0) {
            NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
            int total = StrToInt([responseBody objectForKey:@"total"]);
            int finishedTotal = StrToInt([responseBody objectForKey:@"finishedTotal"]);
            int unfinishedTotal = StrToInt([responseBody objectForKey:@"unfinishedTotal"]);
            
            
            //设置待阅片的数量
            [toDiagView showBadgeWithStyle:WBadgeStyleNumber value:unfinishedTotal animationType:WBadgeAnimTypeNone];
            [finishedView showBadgeWithStyle:WBadgeStyleNumber value:finishedTotal animationType:WBadgeAnimTypeNone];
            
            //判断返回是否为空
            if (IsNilOrNull(dataDic)) {
                return;
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

-(void) refreshSampleTable {
    [self refreshData];
}

//取服务器数据
-(void) refreshData {
    

        pagenum = 0;
        [_sampleArray removeAllObjects];
        [self getAjaxData];

}

//取服务器数据
-(void) refreshDataNextPage {
        pagenum++;
        [self getAjaxData];
}


@end
