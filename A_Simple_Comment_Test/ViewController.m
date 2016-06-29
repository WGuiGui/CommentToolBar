//
//  ViewController.m
//  A_Simple_Comment_Test
//
//  Created by wangguigui on 16/6/29.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ViewController.h"
#import "CommentView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CommentViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) CommentView * commentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [NSMutableArray array];
    
    for (int i=0; i<20; i++) {
        [self.dataList addObject:@"ahsfdjsdhjhjksd"];
    }
    
    [self addSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)keyboardWillChangeFrame:(NSNotification*)note
{
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSLog(@"键盘升降的时间%.2f",time);
    
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.commentView.frame;
    CGFloat height = keyboardFrame.origin.y - self.view.frame.size.height;
    if (height < 0) {
        frame.origin.y = keyboardFrame.origin.y-frame.size.height;
    } else {
        frame.origin.y = self.view.frame.size.height;
    }
    [UIView animateWithDuration:time animations:^{
        [self.commentView setFrame:frame];
    }];
}

-(void)sendCommentWith:(NSString *)text
{
    NSLog(@"评论是：%@",text);
    [self.view endEditing:YES];
}

-(void)addSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.commentView = [[CommentView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    self.commentView.delegate = self;
    self.commentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.commentView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = self.dataList[indexPath.row];
    //弹出键盘
    NSLog(@"cell内容%@",str);
    [self.commentView.commentField becomeFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
