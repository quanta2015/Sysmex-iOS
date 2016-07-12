//
//  SampleImgInfoTableViewCell.h
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SampleImgInfoTableViewCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) NSMutableArray *imgArr;




-(void)setDataList:(NSMutableArray *)dataList :(NSString *)title :(int)index;
-(void)setImgArr:(NSMutableArray *)imgArr;

@end
