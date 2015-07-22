//
//  LVNumberKeyboard.m
//  字母键盘
//
//  Created by PBOC CS on 15/4/11.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVNumberKeyboard.h"
#import "UIView+LVExtension.h"


@interface LVNumberKeyboard ()

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;

/** 符号按钮 */
@property (nonatomic, strong) UIButton *switchSymbolBtn;

/** ABC 文字按钮 */
@property (nonatomic, strong) UIButton *switchLetterBtn;


@end

@implementation LVNumberKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"c_numKeyboardButton"];
        UIImage *highImage = [UIImage imageNamed:@"c_numKeyboardButtonSel"];
        
        [self setupNumberButtonsWithImage:image highImage:highImage];
        [self setupBottomButtonsWithImage:highImage highImage:image];
    }
    return self;
}

#pragma mark - 数字按钮
- (void)setupNumberButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
//        int j = arc4random_uniform(10);
        NSNumber *number = [[NSNumber alloc] initWithInt:i];
        if ([arrM containsObject:number]) {
            i--;
            continue;
        }
        [arrM addObject:number];
    }
    
    for (int i = 0; i < 10; i++) {
        
        NSNumber *number = arrM[i];
        NSString *title = number.stringValue;
        
        UIButton *numBtn = [LVKeyboardTool setupBasicButtonsWithTitle:title image:image highImage:highImage];
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
}

- (void)numBtnClick:(UIButton *)numBtn {
    if ([self.delegate respondsToSelector:@selector(numberKeyboard:didClickButton:)]) {
        [self.delegate numberKeyboard:self didClickButton:numBtn];
    }
}


#pragma mark - 删除按钮可以点击 符号、ABC按钮不能点击
- (void)setupBottomButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    self.switchSymbolBtn = [LVKeyboardTool setupFunctionButtonWithTitle:@"符" image:image highImage:highImage];
    self.switchLetterBtn = [LVKeyboardTool setupFunctionButtonWithTitle:@"ABC" image:image highImage:highImage];
    self.deleteBtn = [LVKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageNamed:@"c_number_keyboardDeleteButton"] highImage:[UIImage imageNamed:@"c_number_keyboardDeleteButtonSel"]];
    
    // 切换至字符键盘切换至ABC键盘
    [self.switchSymbolBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchLetterBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.switchSymbolBtn];
    [self addSubview:self.switchLetterBtn];
    [self addSubview:self.deleteBtn];
    
}

#pragma mark - 切换键盘
- (void)functionBtnClick:(UIButton *)switchBtn {
    if ([self.delegate respondsToSelector:@selector(numberKeyboard:didClickButton:)]) {
        [self.delegate numberKeyboard:self didClickButton:switchBtn];
    }
}

#pragma mark - 点击删除按钮
- (void)deleteBtnClick:(UIButton *)deleteBtn {
    if ([self.delegate respondsToSelector:@selector(customKeyboardDidClickDeleteButton:)]) {
        [self.delegate customKeyboardDidClickDeleteButton:deleteBtn];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    CGFloat topMargin = 15;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    CGFloat topBtnW = (self.width - 2 * leftMargin - 2 * colMargin) / 3;
    CGFloat topBtnH = (self.height - topMargin - bottomMargin - 3 * rowMargin) / 4;
    
    NSUInteger count = self.subviews.count;
    
    // 布局数字按钮
    for (NSUInteger i = 0; i < count; i++) {
        if (i == 0 ) { // 0
            UIButton *buttonZero = self.subviews[i];
            buttonZero.height = topBtnH;
            buttonZero.width = topBtnW;
            buttonZero.centerX = self.centerX;
            buttonZero.centerY = self.height - bottomMargin - buttonZero.height * 0.5;
            
            // 符号、文字及删除按钮的位置
            self.deleteBtn.x = CGRectGetMaxX(buttonZero.frame) + colMargin;
            self.deleteBtn.y = buttonZero.y;
            self.deleteBtn.width = buttonZero.width;
            self.deleteBtn.height = buttonZero.height;
            
            self.switchSymbolBtn.x = leftMargin;
            self.switchSymbolBtn.y = buttonZero.y;
            self.switchSymbolBtn.width = buttonZero.width / 2 - colMargin / 2;
            self.switchSymbolBtn.height = buttonZero.height;
            
            self.switchLetterBtn.x = CGRectGetMaxX(self.switchSymbolBtn.frame) + colMargin;
            self.switchLetterBtn.y = buttonZero.y;
            self.switchLetterBtn.width = self.switchSymbolBtn.width;
            self.switchLetterBtn.height = self.switchSymbolBtn.height;
            
        }
        if (i > 0 && i < 10) { // 0 ~ 9
            
            UIButton *topButton = self.subviews[i];
            CGFloat row = (i - 1) / 3;
            CGFloat col = (i - 1) % 3;
            
            topButton.x = leftMargin + col * (topBtnW + colMargin);
            topButton.y = topMargin + row * (topBtnH + rowMargin);
            topButton.width = topBtnW;
            topButton.height = topBtnH;
        }
        
    }
    
}


@end