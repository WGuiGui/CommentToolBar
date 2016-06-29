//
//  CommentView.h
//  点击评论列表弹出键盘
//
//  Created by wangguigui on 16/6/28.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentViewDelegate <NSObject>

-(void)sendCommentWith:(NSString *)text;

@end

@interface CommentView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * commentField;
@property (nonatomic, strong) UIButton * sendBtn;
@property (nonatomic, assign) id<CommentViewDelegate>delegate;

@end
