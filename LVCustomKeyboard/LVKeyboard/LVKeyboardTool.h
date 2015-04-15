//
//  LVKeyboardTool.h
//  字母键盘
//
//  Created by PBOC CS on 15/4/11.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class LVLetterKeyboard, LVNumberKeyboard, LVSymbolKeyboard;
@protocol LVCustomKeyboardDelegate <NSObject>

@optional

- (void)letterKeyboard:(LVLetterKeyboard *)letter didClickButton:(UIButton *)button;
- (void)numberKeyboard:(LVNumberKeyboard *)number didClickButton:(UIButton *)button;
- (void)symbolKeyboard:(LVSymbolKeyboard *)symbol didClickButton:(UIButton *)button;

- (void)customKeyboardDidClickDeleteButton:(UIButton *)deleteBtn;

@end



@interface LVKeyboardTool : NSObject

#pragma mark - 添加基础按钮
+ (UIButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

#pragma mark - 添加功能按钮
+ (UIButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

@end
