
//
//  WHKTableViewNinetySixCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/6/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewNinetySixCell.h"

#import "BN_Globle.h"
#import "NSObject+Helper.h"

#import "NSDictionary+Helper.h"
#import "BN_TextField.h"


@implementation WHKTableViewNinetySixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+时间选择器
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    self.textField.placeholder = @"请选择";
    self.textField.textAlignment = NSTextAlignmentCenter;
    
    self.textField.rightView = [self getTextFieldRightView:kIMAGE_arrowDown];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    self.textField.delegate = self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) - padding - XGap, textFieldH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    [self createAlertView];
    return NO;
    
}

#pragma mark - - alertView

- (void)createAlertView{
    //    NSParameterAssert(self.dic && [self.dic isKindOfClass:[NSDictionary class]]);
    BN_AlertViewOne * alertView = self.alertView;
    alertView.block = ^(BN_AlertViewOne *view, NSIndexPath *indexPath) {
        NSArray * array = view.data[kItem_obj];
        NSString * value = array[indexPath.row];
        NSArray * keys = [view.dic allKeysForObject:value];
        self.textField.text = value;
        if (self.block) {
            self.block(self, view, value, keys, indexPath);
        }
        
    };
    
    if (self.dic && [self.dic isKindOfClass:[NSDictionary class]]) {
        NSArray * array = [self.dic sortedValuesByKey];
        alertView.data = @{
                           kItem_obj    :   array,
                           
                           };
        [alertView show];
    }
    else if ([alertView.data[kItem_obj] isKindOfClass:[NSArray class]]){
        [alertView show];
        
    }
    else{
        if (self.block) {
            self.block(self, alertView, nil, nil, nil);
        }
    }
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    if (dic) {
        self.alertView.dic = dic;

    }
    
}

//- (void)createAlertView{
////    NSParameterAssert(self.dic && [self.dic isKindOfClass:[NSDictionary class]]);
//    BN_AlertViewOne * alertView = self.alertView;
//
//    if (self.dic && [self.dic isKindOfClass:[NSDictionary class]]) {
//        NSArray * array = [self.dic sortedValuesByKey];
//
//        alertView.data = @{
//                           kItem_obj    :   array,
//
//                           };
//        [alertView show];
//        alertView.block = ^(BN_AlertViewOne *view, NSIndexPath *indexPath) {
//            NSString * value = array[indexPath.row];
//            NSArray * keys = [self.dic allKeysForObject:value];
//            self.textField.text = value;
//            if (self.block) {
//                self.block(self, view, value, keys, indexPath);
//            }
//
//        };
//    }
//    else if ([alertView.data[kItem_obj] isKindOfClass:[NSArray class]]){
//        NSArray * array = alertView.data[kItem_obj];
//        [alertView show];
//        alertView.block = ^(BN_AlertViewOne *view, NSIndexPath *indexPath) {
//            NSString * value = array[indexPath.row];
//            NSArray * keys = [view.dic allKeysForObject:value];
//            self.textField.text = value;
//            if (self.block) {
//                self.block(self, view, value, keys, indexPath);
//            }
//
//        };
//
//    }
//    else{
//        if (self.block) {
//            self.block(self, view, nil, nil, nil);
//        }
//    }
//
//}

#pragma mark - -layz

-(BN_AlertViewOne *)alertView{
    if (!_alertView) {
        _alertView = [[BN_AlertViewOne alloc]init];
        _alertView.label.text = @"请选择";

    }
    return _alertView;
}


@end
