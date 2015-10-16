//
//  TTLQiuYouTableViewController.m
//  TTLQiuBai
//
//  Created by Tarena on 10/14/15.
//  Copyright (c) 2015 TTL. All rights reserved.
//

#import "TTLQiuYouTableViewController.h"
#import "Constant.h"
@interface TTLQiuYouTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
//滑动界面
@property (nonatomic, strong) UIScrollView *scrollView;

//滑动界面
@property (nonatomic, strong) UITableView *nextDoorTableView;
@property (nonatomic, strong) UITableView *fansTableView;

//滑动的主题
@property (nonatomic, strong) UISegmentedControl *subjectContrl;
@property (nonatomic, strong) NSArray *subjectName;
//滑动线
@property (nonatomic, strong) UIView *lineView;


@end

@implementation TTLQiuYouTableViewController

//滑动条宽度
#define tlineY 3

//懒加载滑屏
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        CGFloat y = CGRectGetMaxY(self.subjectContrl.frame);
        _scrollView.frame = CGRectMake(0, y + tlineY, tScreenWidth, tScreenHeight-y);
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*2, 0);
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //是否整页翻动
        _scrollView.pagingEnabled = YES;
        //是否反弹
        _scrollView.bounces = YES;
        [_scrollView addSubview:self.nextDoorTableView];
        [_scrollView addSubview:self.fansTableView];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
//滑动界面
- (UISegmentedControl *)subjectContrl{
    if (!_subjectContrl) {
        _subjectContrl = [[UISegmentedControl alloc]initWithItems:self.subjectName];
        _subjectContrl.frame = CGRectMake(0, 0, tScreenWidth, 44);
        _subjectContrl.selectedSegmentIndex = 0 ;
        _subjectContrl.tintColor = [UIColor redColor];
        _subjectContrl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _subjectContrl.tintColor = [UIColor clearColor];
        [_subjectContrl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        [_subjectContrl setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
        //  [_subjectContrl setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    }
    return _subjectContrl;
}
//滑动的主题
- (NSArray *)subjectName{
    if (!_subjectName) {
        _subjectName = @[@"隔壁",@"已粉"];
    }
    return _subjectName;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.title = @"糗友圈";
    }
    return self;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.subjectContrl.frame.size.width/8, self.subjectContrl.frame.size.height, self.subjectContrl.frame.size.width/4 , tlineY)];
        _lineView.backgroundColor = [UIColor orangeColor];
    }
    return _lineView;
}
#pragma mark -- TableViewloading
- (UITableView *)nextDoorTableView{
    if (!_nextDoorTableView) {
        _nextDoorTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, tScreenWidth, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _nextDoorTableView.delegate = self;
        _nextDoorTableView.dataSource = self;
    }
    return _nextDoorTableView;
}

- (UITableView *)fansTableView{
    if (!_fansTableView) {
        _fansTableView = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth, 0, tScreenWidth, self.scrollView.bounds.size.height)  style:UITableViewStylePlain];
        _fansTableView.delegate = self;
        _fansTableView.dataSource = self;
    }
    return _fansTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.subjectContrl];
    [self.view addSubview:self.lineView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"222";
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offSet = scrollView.contentOffset;
    CGRect linframe = self.lineView.frame;
    linframe.origin.x = offSet.x/2  + self.subjectContrl.frame.size.width/8;
    [UIView animateWithDuration:0.4 animations:^{
        self.lineView.frame = linframe;
    }];
}
- (void)segmentChange:(UISegmentedControl* )sender{
    NSInteger segmentIndex = self.subjectContrl.selectedSegmentIndex;
    CGPoint  scollPoint = self.scrollView.contentOffset;
    scollPoint.x = segmentIndex*tScreenWidth;
    [self.scrollView setContentOffset:scollPoint animated:YES];
}
@end
