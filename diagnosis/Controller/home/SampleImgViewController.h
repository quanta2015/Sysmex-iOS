//
//  SampleImgViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMScrollView.h"

@interface SampleImgViewController : UIViewController

@property(nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) SMScrollView *imgScrollView;

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic) int imgIndex;


@end
