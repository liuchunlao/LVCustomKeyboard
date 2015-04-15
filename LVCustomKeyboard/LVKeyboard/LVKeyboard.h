//
//  LVKeyboard.h
//  字母键盘
//
//  Created by PBOC CS on 15/4/11.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LVKeyboard;
@protocol LVKeyboardDelegate <NSObject>

@optional
/**
 *  点击了文字或字符数字按钮
 */
- (void)keyboard:(LVKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string;
/**
 *  点击了删除按钮
 */
- (void)keyboard:(LVKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string;

@end


@interface LVKeyboard : UIView

@property (nonatomic, assign) id<LVKeyboardDelegate> delegate;

@end
