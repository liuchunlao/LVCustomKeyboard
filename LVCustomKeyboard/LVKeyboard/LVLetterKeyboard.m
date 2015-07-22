//
//  LVLetterKeyboard.m
//  字母键盘
//
//  Created by PBOC CS on 15/4/9.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVLetterKeyboard.h"
#import "UIView+LVExtension.h"

@interface LVLetterKeyboard ()

@property (nonatomic, strong) NSArray *lettersArr;


@property (nonatomic, strong) NSArray *uppersArr;

/** 小写字母按钮 */
@property (nonatomic, strong) NSMutableArray *charBtnsArrM;

/** 其他按钮 */
@property (nonatomic, strong) NSMutableArray *tempArrM;

/** 其他按钮 切换大小写 */
@property (nonatomic, strong) UIButton *shiftBtn;
/** 其他按钮 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;
/** 其他按钮 切换至数字键盘 */
@property (nonatomic, strong) UIButton *switchNumBtn;
/** 其他按钮 切换至符号按钮 */
@property (nonatomic, strong) UIButton *switchSymbolBtn;
/** 其他按钮 登录 */
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, assign) BOOL isUpper;

@end


@implementation LVLetterKeyboard

- (NSArray *)lettersArr {
    if (!_lettersArr) {
        _lettersArr = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    }
    return _lettersArr;
}

- (NSArray *)uppersArr {
    if (!_uppersArr) {
        _uppersArr = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    }
    return _uppersArr;
}

- (NSMutableArray *)charBtnsArrM {
    if (!_charBtnsArrM) {
        _charBtnsArrM = [NSMutableArray array];
    }
    return _charBtnsArrM;
}

- (NSMutableArray *)tempArrM {
    if (!_tempArrM) {
        _tempArrM = [NSMutableArray array];
    }
    return _tempArrM;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isUpper = YES;
        [self setupControls];
        
    }
    return self;
}

- (void)setupControls {

    // 添加26个字母按钮
    UIImage *image = [UIImage imageNamed:@"c_charKeyboardButton"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    UIImage *highImage = [UIImage imageNamed:@"c_chaKeyboardButtonSel"];
    highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width * 0.5 topCapHeight:highImage.size.height * 0.5];
    
    NSUInteger count = self.lettersArr.count;
    for (NSUInteger i = 0 ; i < count; i++) {
        
        UIButton *charBtn = [LVKeyboardTool setupBasicButtonsWithTitle:nil image:image highImage:highImage];
        [charBtn addTarget:self action:@selector(charbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:charBtn];
        [self.charBtnsArrM addObject:charBtn];
    }
    
    // 添加其他按钮 切换大小写、删除回退、确定（登录）、 数字、符号
    self.shiftBtn = [LVKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageNamed:@"c_chaKeyboardShiftButton"] highImage:[UIImage imageNamed:@"c_chaKeyboardShiftButtonSel"]];
    self.deleteBtn = [LVKeyboardTool setupFunctionButtonWithTitle:nil image:[UIImage imageNamed:@"c_character_keyboardDeleteButton"] highImage:[UIImage imageNamed:@"c_character_keyboardDeleteButtonSel"]];
    self.loginBtn = [LVKeyboardTool setupFunctionButtonWithTitle:@"确定" image:[UIImage imageNamed:@"login_c_character_keyboardLoginButton"] highImage:highImage];
    self.switchNumBtn = [LVKeyboardTool setupFunctionButtonWithTitle:@"123" image:[UIImage imageNamed:@"c_character_keyboardSwitchButton"] highImage:[UIImage imageNamed:@"c_character_keyboardSwitchButtonSel"]];
    self.switchSymbolBtn = [LVKeyboardTool setupFunctionButtonWithTitle:@"符" image:[UIImage imageNamed:@"c_character_keyboardSwitchButton"] highImage:[UIImage imageNamed:@"c_character_keyboardSwitchButtonSel"]];
    
    [self.shiftBtn addTarget:self action:@selector(changeCharacteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchNumBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchSymbolBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.shiftBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.switchNumBtn];
    [self addSubview:self.switchSymbolBtn];
    
    [self changeCharacteBtnClick:nil];
    
}

- (void)charbuttonClick:(UIButton *)charButton {
    if ([self.delegate respondsToSelector:@selector(letterKeyboard:didClickButton:)]) {
        [self.delegate letterKeyboard:self didClickButton:charButton];
    }
}

- (void)changeCharacteBtnClick:(UIButton *)shiftBtn {
    
    [self.tempArrM removeAllObjects];
    NSUInteger count = self.charBtnsArrM.count;

    if (self.isUpper) {
        self.tempArrM = [NSMutableArray arrayWithArray:self.lettersArr];
        self.isUpper = NO;
    } else {
        
        self.tempArrM = [NSMutableArray arrayWithArray:self.uppersArr];
        self.isUpper = YES;
    }
    for (int i = 0; i < count; i++) {
        UIButton *charBtn = (UIButton *)self.charBtnsArrM[i];
        NSString *upperTitle = self.tempArrM[i];
        [charBtn setTitle:upperTitle forState:UIControlStateNormal];
        [charBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)deleteBtnClick:(UIButton *)deleteBtn {
    if ([self.delegate respondsToSelector:@selector(customKeyboardDidClickDeleteButton:)]) {
        [self.delegate customKeyboardDidClickDeleteButton:deleteBtn];
    }
    
}

- (void)functionBtnClick:(UIButton *)switchBtn {
    if ([self.delegate respondsToSelector:@selector(letterKeyboard:didClickButton:)]) {
        [self.delegate letterKeyboard:self didClickButton:switchBtn];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat topMargin = 15;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    // 布局字母按钮
    CGFloat buttonW = (self.width - 2 * leftMargin - 9 * colMargin) / 10;
    CGFloat buttonH = (self.height - topMargin - bottomMargin - 3 * rowMargin) / 4;
    
    NSUInteger count = self.charBtnsArrM.count;
    for (NSUInteger i = 0; i < count; i++) {
        
        UIButton *button = (UIButton *)self.charBtnsArrM[i];
        button.width = buttonW;
        button.height = buttonH;
        
        if (i < 10) { // 第一行
            button.x = (colMargin + buttonW) * i + leftMargin;
            button.y = topMargin;
        } else if (i < 19) { // 第二行
            button.x = (colMargin + buttonW) * (i - 10) + leftMargin + buttonW / 2 + colMargin;
            button.y = topMargin + rowMargin + buttonH;
        } else if (i < count) {
            button.y = topMargin + 2 * rowMargin + 2 * buttonH;
            button.x = (colMargin + buttonW) * (i - 19) + leftMargin + buttonW / 2 + colMargin + buttonW + colMargin;
        }
    }
    
    // 布局其他功能按钮  切换大小写、删除回退、确定（登录）、 数字、符号
    CGFloat shiftBtnW = buttonW / 2 + colMargin + buttonW;
    CGFloat shiftBtnY = topMargin + 2 * rowMargin + 2 * buttonH;
    self.shiftBtn.frame = CGRectMake(leftMargin, shiftBtnY, shiftBtnW, buttonH);
    
    CGFloat deleteBtnW = buttonW / 2 + buttonW;
    self.deleteBtn.frame = CGRectMake(self.width - leftMargin - deleteBtnW, shiftBtnY, deleteBtnW, buttonH);
    
    CGFloat loginBtnW = 2 * buttonW + colMargin;
    CGFloat loginBtnY = self.height - bottomMargin - buttonH;
    CGFloat loginBtnX = self.width - leftMargin - loginBtnW;
    
    self.loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, buttonH);
    
    CGFloat switchBtnW = (loginBtnX - 2 * colMargin - leftMargin) / 2;
    
    self.switchNumBtn.frame = CGRectMake(leftMargin, loginBtnY, switchBtnW, buttonH);
    self.switchSymbolBtn.frame = CGRectMake(CGRectGetMaxX(self.switchNumBtn.frame) + colMargin, loginBtnY, switchBtnW, buttonH);
}



@end
