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


@interface SampleDetailViewController () {
    SampleDetailModel *sample;
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
    
    [self initTableView];
    //[self setUpTableView];
//    
    [self getAjaxData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView{
    
    HIDDEN_SCROLLVIEW;
    _thumbArray = [[NSMutableArray alloc] init];
    _sampleListTitleArray = SAMPLE_LIST_TITLE_ARRAY;
    _cellTitleArray = SAMPLE_CELL_TITLE_ARRAY;
    

    
    for (int i=0;i<7;i++) {
         [_thumbArray addObject:@""];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        return 160;
//    }else if (indexPath.row == 1){
//        return ceil((float)sample.machineList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else if (indexPath.row == 2){
//        return ceil((float)sample.graphList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else if (indexPath.row == 3){
//        return ceil((float)sample.ipmessageList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else if (indexPath.row == 4){
//        return ceil((float)sample.historyList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else if (indexPath.row == 5){
//        return ceil((float)sample.otherList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else if (indexPath.row == 6){
//        return ceil((float)sample.microscopeList.count/4)*(thumb_width + M_MARGIN) + 30;
//    }else {
//        return 0;
//    }
    
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

-(void)getAjaxData{

    NSDictionary *parameters = @{@"barcode":_barcode};
    
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetSampleInfo successBlock:^(id responseBody){
//        [self.tableView.header endRefreshing];
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

@end
