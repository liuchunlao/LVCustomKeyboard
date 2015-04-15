//
//  LVKeyboard.m
//  字母键盘
//
//  Created by PBOC CS on 15/4/11.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVKeyboard.h"
#import "LVSymbolKeyboard.h"
#import "LVLetterKeyboard.h"
#import "LVNumberKeyboard.h"
#import "LVKeyboardTool.h"
#define LVScreen_Size [UIScreen mainScreen].bounds.size

@interface LVKeyboard () <LVCustomKeyboardDelegate>

@property (nonatomic, strong) LVLetterKeyboard *letterKeyboard;
@property (nonatomic, strong) LVSymbolKeyboard *symbolKeyboard;
@property (nonatomic, strong) LVNumberKeyboard *numberKeyboard;

@property (nonatomic, strong) NSMutableString *string;

@end

@implementation LVKeyboard

- (LVLetterKeyboard *)letterKeyboard {
    if (!_letterKeyboard) {
        _letterKeyboard = [[LVLetterKeyboard alloc] initWithFrame:self.bounds];
        _letterKeyboard.delegate = self;
    }
    return _letterKeyboard;
}

- (LVSymbolKeyboard *)symbolKeyboard {
    if (!_symbolKeyboard) {
        _symbolKeyboard = [[LVSymbolKeyboard alloc] initWithFrame:self.bounds];
        _symbolKeyboard.delegate = self;
    }
    return _symbolKeyboard;
}

- (LVNumberKeyboard *)numberKeyboard {
    if (!_numberKeyboard) {
        _numberKeyboard = [[LVNumberKeyboard alloc] initWithFrame:self.bounds];
        _numberKeyboard.delegate = self;
    }
    return _numberKeyboard;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, LVScreen_Size.height - 216, LVScreen_Size.width, 216);
        self.string = [NSMutableString string];
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.letterKeyboard];
    }
    return self;
}

- (void)letterKeyboard:(LVLetterKeyboard *)letter didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"符"]) {
        [letter removeFromSuperview];
        [self addSubview:self.symbolKeyboard];
    } else if ([button.currentTitle isEqualToString:@"123"]) {
        [self.letterKeyboard removeFromSuperview];
        [self addSubview:self.numberKeyboard];
    } else if ([button.currentTitle isEqualToString:@"确定"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}

- (void)symbolKeyboard:(LVSymbolKeyboard *)symbol didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"ABC"]) {
        [symbol removeFromSuperview];
        [self addSubview:self.letterKeyboard];
    } else if ([button.currentTitle isEqualToString:@"123"]) {
        [symbol removeFromSuperview];
        [self addSubview:self.numberKeyboard];
    } else if ([button.currentTitle isEqualToString:@"确定"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}

- (void)numberKeyboard:(LVNumberKeyboard *)number didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"符"]) {
        [number removeFromSuperview];
        [self addSubview:self.symbolKeyboard];
    } else if ([button.currentTitle isEqualToString:@"ABC"]) {
        [number removeFromSuperview];
        [self addSubview:self.letterKeyboard];
    } else if ([button.currentTitle isEqualToString:@"确定"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}

// 删除方法
- (void)customKeyboardDidClickDeleteButton:(UIButton *)deleteBtn {

    if (self.string.length > 0) {
        [self.string deleteCharactersInRange:NSMakeRange(self.string.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteButton:string:)]) {
            [self.delegate keyboard:self didClickDeleteButton:deleteBtn string:self.string];
        }
    }
    
}

- (void)appendString:(UIButton *)button {
    
    [self.string appendString:button.currentTitle];
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickTextButton:string:)]) {
        [self.delegate keyboard:self didClickTextButton:button string:self.string];
    }
}


@end
