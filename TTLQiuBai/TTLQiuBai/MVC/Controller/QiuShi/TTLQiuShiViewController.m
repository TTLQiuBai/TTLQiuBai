//
//  TTLQiuShiViewController.m
//  TTLQiuBai
//
//  Created by Tarena on 10/14/15.
//  Copyright (c) 2015 TTL. All rights reserved.
//

#import "TTLQiuShiViewController.h"
#import "Constant.h"
#import "TTLAriticle.h"
#import "AFNetworking.h"






#define tLineHeight 2

@interface TTLQiuShiViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

// 主界面的滚动视图
@property (nonatomic, strong) UIScrollView *mainScroll;

@property (nonatomic, strong) UISegmentedControl *segment;

// 分类的名字
@property (nonatomic, strong) NSArray *subCategoryName;


// segment 下面的线
@property (nonatomic, strong) UIView *lineView;


// 各个分类的 tableView

// 专享
@property (nonatomic, strong) UITableView *specialTabV;
// 视频
@property (nonatomic, strong) UITableView *videoTabV;
// 段子
@property (nonatomic, strong) UITableView *articleTabV;
// 图片
@property (nonatomic, strong) UITableView *imageTabV;
// 精华
@property (nonatomic, strong) UITableView *essenceTabV;
// 最新
@property (nonatomic, strong) UITableView *newsTabV;

@property (nonatomic, strong) NSArray *articles;

@end

@implementation TTLQiuShiViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        
        self.title = @"糗事";
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // 设置自动空出导航栏加状态栏,所以 segment 的 y 设置为0  针对 ios7.0以上
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    [self.view addSubview:self.mainScroll];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.lineView];
    
    // 把 tableView 加载到 scrollVier 上
    [self requestWithURLString:@"http://m2.qiushibaike.com/article/list/text?page=1&count=30" tableView:self.articleTabV];
    


}

#pragma mark -- NetWorking
- (void)requestWithURLString:(NSString *)str tableView:(UITableView *)tableView {
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __block NSDictionary *dict = [NSDictionary dictionary];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",[NSThread currentThread]);
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self parseJSON:dict tableView:tableView];
    }];
    
    [task resume];
}

- (void)parseJSON:(NSDictionary *)dict tableView:(UITableView *)tableView{
   self.articles = [TTLAriticle articlesWithDict:dict];
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView reloadData];
    });
}

#pragma mark - lazyLoad


- (UIScrollView *)mainScroll {
    if (_mainScroll == nil) {
        _mainScroll = [[UIScrollView alloc]init];
        CGFloat y = CGRectGetMaxY(self.segment.frame);
        _mainScroll.frame = CGRectMake(0, y + tLineHeight, tScreenWidth, tScreenHeight - y);
        _mainScroll.contentSize = CGSizeMake(tScreenWidth * _subCategoryName.count, 0);
        _mainScroll.backgroundColor = [UIColor redColor];
        _mainScroll.pagingEnabled = YES;
        _mainScroll.bounces = NO;
        _mainScroll.delegate = self;
        
        [_mainScroll addSubview:self.specialTabV];
        NSLog(@"%@",NSStringFromCGRect(_mainScroll.frame));
        NSLog(@"%@",NSStringFromCGRect(self.specialTabV.frame));
        [_mainScroll addSubview:self.videoTabV];
        [_mainScroll addSubview:self.imageTabV];
        [_mainScroll addSubview:self.articleTabV];
        [_mainScroll addSubview:self.essenceTabV];
        [_mainScroll addSubview:self.newsTabV];
    }
    return _mainScroll;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segment.frame), tScreenWidth / self.subCategoryName.count, tLineHeight)];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}





- (UISegmentedControl *)segment {
    if (_segment == nil) {
        _segment = [[UISegmentedControl alloc]initWithItems:self.subCategoryName];
        _segment.frame = CGRectMake(0, 0, tScreenWidth, tNaviHeight);
        _segment.selectedSegmentIndex = 0;
        _segment.backgroundColor = [UIColor lightGrayColor];
        _segment.tintColor = [UIColor clearColor];
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    }
    return _segment;
}


#pragma mark ---- TableView 的加载
- (UITableView *)specialTabV {
    if (_specialTabV == nil) {
        _specialTabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _specialTabV.delegate = self;
        _specialTabV.dataSource = self;
        
        
    }
    return _specialTabV;
}

- (UITableView *)videoTabV {
    if (_videoTabV == nil) {
        _videoTabV = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _videoTabV.delegate = self;
        _videoTabV.dataSource = self;
    }
    return _videoTabV;
}

- (UITableView *)articleTabV {
    if (_articleTabV == nil) {
        _articleTabV = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth * 2, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _articleTabV.delegate = self;
        _articleTabV.dataSource = self;
        
       
        
    }
    return _articleTabV;
}


- (UITableView *)imageTabV {
    if (_imageTabV == nil) {
        _imageTabV = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth * 3, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _imageTabV.delegate = self;
        _imageTabV.dataSource = self;
    }
    return _imageTabV;
}

- (UITableView *)essenceTabV {
    if (_essenceTabV == nil) {
        _essenceTabV = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth * 4, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _essenceTabV.delegate = self;
        _essenceTabV.dataSource = self;
    }
    return _essenceTabV;
}

- (UITableView *)newsTabV {
    if (_newsTabV == nil) {
        _newsTabV = [[UITableView alloc]initWithFrame:CGRectMake(tScreenWidth * 5, 0, tScreenWidth, self.mainScroll.bounds.size.height) style:UITableViewStylePlain];
        _newsTabV.delegate = self;
        _newsTabV.dataSource = self;
    }
    return _newsTabV;
}



#pragma mark - data 
- (NSArray *)subCategoryName {
    if (_subCategoryName == nil) {
        _subCategoryName = [NSArray arrayWithObjects:@"专享",@"视频",@"段子",@"糗图",@"精华",@"最新",nil];
    }
    return _subCategoryName;
}


#pragma mark --- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    TTLAriticle *article = self.articles[indexPath.row];
    cell.textLabel.text = article.content;
    return cell;
}



#pragma mark ---ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainScroll) {
        NSInteger index = scrollView.contentOffset.x / tScreenWidth;
        self.segment.selectedSegmentIndex = index;
        CGRect lineFrame = self.lineView.frame;
        CGFloat temp = tScreenWidth / self.mainScroll.contentSize.width;
        lineFrame.origin.x = scrollView.contentOffset.x * temp;
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = lineFrame;
        }];
    }
}

#pragma mark --- SegmentValueChanged
- (void)segmentValueChanged:(UISegmentedControl *)sender {
    CGFloat x = sender.selectedSegmentIndex * tScreenWidth;
    CGPoint contentOffset = CGPointMake(x, 0);
    [self.mainScroll setContentOffset:contentOffset animated:YES];
//    self.mainScroll.contentOffset = contentOffset;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
