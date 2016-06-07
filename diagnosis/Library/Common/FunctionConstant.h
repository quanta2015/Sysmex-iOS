//
//  FunctionConstant.h
//  DAZD
//
//  Created by quanta on 15/10/22.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#ifndef DAZD_FunctionConstant_h
#define DAZD_FunctionConstant_h

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//定义版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define thumb_width (screen_width-M_MARGIN*5)/4
#define screen_width_3p	(screen_width - L_MARGIN*4)/3
#define screen_width_4p	(screen_width - L_MARGIN*5)/4

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)

//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

//常用对象
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)



// 获得RGB颜色
#define RGBA(r, g, b, a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)            RGBA(r, g, b, 1.0f)

//图片偏移参数
#define OH  (screen_height-NAV_HEIGHT)/568
#define OW  screen_width/320


//去掉空格 [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
#define TrimSpace(_ref)  ([_ref stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])

//数字to字符串 [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
#define IntToStr(_ref)  ([NSString stringWithFormat:@"%d",_ref])
#define StrToInt(_ref)   [_ref intValue];
#define StrCat(_ref1,_ref2)  [_ref1 stringByAppendingString:_ref2];
#define StrCat3(_ref1,_ref2,_ref3)  [NSString stringWithFormat:@"%@%@%@", _ref1, _ref2, _ref3 ];
#define StrCat4(_ref1,_ref2,_ref3,_ref4)  [NSString stringWithFormat:@"%@%@%@%@", _ref1, _ref2, _ref3, _ref4 ];
#define StrCatMsg(_ref1,_ref2,_ref3,_ref4,_ref5,_ref6,_ref7)  [NSString stringWithFormat:@"%@%d%@%@%@%@%@", _ref1, _ref2, _ref3, _ref4 ,_ref5,_ref6,_ref7];


// #define

#define ReplaceUrl(_ref1)  [_ref1 stringByReplacingOccurrencesOfString: @"\\" withString: @"/"];  


//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//消除自动生成的灰色UIScrollview
#define HIDDEN_SCROLLVIEW \
if (iOS7) \
{\
    self.edgesForExtendedLayout = UIRectEdgeNone; \
    self.extendedLayoutIncludesOpaqueBars = NO;   \
}else{\
    self.automaticallyAdjustsScrollViewInsets = NO;\
    self.edgesForExtendedLayout = UIRectEdgeNone; \
}


#define AlertMessage(__MSG) \
{\
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:__MSG delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alert show];\
}


                                     
                                     
#define DateToStr(_date, ret) \
{\
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init]; \
    [dateformatter setDateFormat:@"yyyy-MM-dd"]; \
    ret =  [dateformatter stringFromDate:_date]; \
}


#define calLabelHeight(__MSG,__FONTSIZE,__WIDE,ret)\
{\
    UIFont *font = [UIFont systemFontOfSize:__FONTSIZE];\
    CGSize size = CGSizeMake(__WIDE,2000);\
    CGSize labelsize = [__MSG sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];\
    ret =  labelsize.height+1; \
}

#define INIT_FIELD(_ref1, _x, _y, _w, _h, _size, _pld, _tag, _c, _ref2) \
{\
    _ref1 = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, _w, _h)]; \
    _ref1.font = [UIFont boldSystemFontOfSize:_size]; \
    _ref1.placeholder = _pld; \
    _ref1.delegate = self; \
    _ref1.tag = _tag; \
    _ref1.textColor = _c;\
    [_ref2 addSubview:_ref1]; \
}


#define INIT_LABEL(_ref1,_x,_y,_w,_h,_size,_c,_t, _ref2) \
{\
	_ref1 = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, _w, _h)];\
    _ref1.font = [UIFont boldSystemFontOfSize:_size];\
    _ref1.textColor = _c;\
    _ref1.textAlignment = NSTextAlignmentCenter;\
    _ref1.text = _t;\
    [_ref2 addSubview:_ref1];\
}

#define INIT_MENU_VIEW(_ref1,_x,_y,_w,_h,_c,_tag,_ref2) \
{\
	_ref1 = [[UIView alloc] initWithFrame:CGRectMake(_x, _y, _w, _h)];\
    _ref1.backgroundColor = _c;\
    _ref1.tag = _tag;\
    [_ref1 addGestureRecognizer:_ref2];\
}

#define ALERT_COMFORM(_msg,_f) \
{\
    [[[LGAlertView alloc] initWithTitle: _msg \
        message: nil \
        style: LGAlertViewStyleActionSheet \
        buttonTitles: @[@"确定"] \
        cancelButtonTitle: @"取消" \
        destructiveButtonTitle: nil \
        actionHandler: ^ (LGAlertView * alertView, NSString * title, NSUInteger index) { \
            [self _f]; \
        } \
        cancelHandler: ^ (LGAlertView * alertView) { \
           NSLog(@"cancelHandler"); \
        } \
        destructiveHandler: ^ (LGAlertView * alertView) { \
           NSLog(@"destructiveHandler"); \
        } \
    ] showAnimated: YES completionHandler: nil]; \
}

#define ALERT_PROMOPT(_view,_title, _pld, _f, _r) \
{\
    _view = [[LGAlertView alloc] initWithTextFieldsAndTitle: _title  \
    message: nil \
    numberOfTextFields: 1 \
    textFieldsSetupHandler: ^ (UITextField * textField, NSUInteger index) { \
       textField.placeholder = _pld; \
       textField.delegate = self; \
       textField.enablesReturnKeyAutomatically = YES; \
    } \
    buttonTitles: @[@"确定"] \
    cancelButtonTitle: @"取消" \
    destructiveButtonTitle: nil \ 
    actionHandler: ^ (LGAlertView * alertView, NSString * title, NSUInteger index) { \
        _r = ((UITextField*) alertView.textFieldsArray[0]).text; \
        [self _f]; \
    } \
    cancelHandler: ^ (LGAlertView * alertView) { \
       NSLog(@"cancelHandler"); \
    } \
    destructiveHandler: ^ (LGAlertView * alertView) { \
       NSLog(@"destructiveHandler"); \
}]; \
[alertView showAnimated: YES completionHandler: nil]; \
}

#define SHOW_DATAPICKER(_dp, _f) \
{\
    LGAlertView *v;\
    [[[LGAlertView alloc] initWithViewAndTitle: @"请选择日期" \
    message: nil \
    style: LGAlertViewStyleActionSheet \
    view: _dp \
    buttonTitles: @[@"确定"] \
    cancelButtonTitle: @"取消" \
    destructiveButtonTitle: nil \
    actionHandler: ^ (LGAlertView * alertView, NSString * title, NSUInteger index) { \
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init]; \
    [dateformatter setDateFormat: @"yyyy-MM-dd"]; \
    _f.text = [dateformatter stringFromDate: _dp.date]; \
    } \
    cancelHandler: ^ (LGAlertView * alertView) { \
    NSLog(@"cancelHandler"); \
    } \
    destructiveHandler: ^ (LGAlertView * alertView) { \
    NSLog(@"destructiveHandler"); \
    } \
    ] showAnimated: YES completionHandler: nil]; \
}

#define GET_N_DAY(_ref,_day_count) \
{\
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(_day_count*24*60*60)]; \
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init]; \
    [dateformatter setDateFormat:@"yyyy-MM-dd"]; \
    NSString *dateString=[dateformatter stringFromDate:yesterdayDate]; \
    _ref.text =dateString; \
}

#define GET_YESTERDAY(_ref) \
{\
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]; \
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init]; \
    [dateformatter setDateFormat:@"yyyy-MM-dd"]; \
    NSString *dateString=[dateformatter stringFromDate:yesterdayDate]; \
    _ref.text =dateString; \
}

#define GET_TODAY(_ref) \
{\
    NSDate *nowDate=[NSDate date]; \
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init]; \
    [dateformatter setDateFormat:@"yyyy-MM-dd"]; \
    NSString *dateString=[dateformatter stringFromDate:nowDate]; \
    _ref.text =dateString; \
}

#endif







