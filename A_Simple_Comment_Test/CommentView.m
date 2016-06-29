//
//  CommentView.m
//  点击评论列表弹出键盘
//
//  Created by wangguigui on 16/6/28.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

-(id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews
{
    self.commentField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-50, self.frame.size.height)];
    self.commentField.delegate = self;
    self.commentField.backgroundColor = [UIColor redColor];
    [self addSubview:self.commentField];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(CGRectGetMaxX(self.commentField.frame)+5, 0, 45, self.frame.size.height);
    self.sendBtn.backgroundColor = [UIColor greenColor];
    [self.sendBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendBtn];
}

-(void)sendComment
{
    if (self.commentField.text.length) {
        [self.delegate sendCommentWith:self.commentField.text];
        self.commentField.text = nil;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

@end