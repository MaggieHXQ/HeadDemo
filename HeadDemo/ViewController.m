//
//  ViewController.m
//  HeadDemo
//
//  Created by yr on 2019/5/9.
//  Copyright © 2019 yr. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "SDAutoLayout.h"
#import "SystemEnum.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HeaderView *headerView;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *feedBtn;
@property (nonatomic, strong) UIImageView *headImg;


@property (nonatomic, assign) BOOL isShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
   
    [_headerView setNameStr:@"是你得不到的喵"];
    //
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)setSubview
{
    [self.view sd_addSubviews:@[self.headerView,self.tableView,self.backBtn,self.feedBtn]];
    self.headerView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(TabHeadHeight);
    self.backBtn.sd_layout.heightIs(24).widthIs(24).leftSpaceToView(self.view, 18).topSpaceToView(self.view, 31);
    self.feedBtn.sd_layout.heightIs(24).widthIs(24).rightSpaceToView(self.view, 19).topSpaceToView(self.view, 31);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([object isKindOfClass:[UITableView class]]) {
            [_headerView updateLayoutAtOffset:((UITableView*)object).contentOffset];
            CGFloat y = ((UITableView*)object).contentOffset.y;
            if (-y > TabHeadHeight-MovedHeadHeight) {
                _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), (-y)+MovedHeadHeight);
            }
        }
    }
}

#pragma mark - 表格相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
//- ()
#pragma mark -----  getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, MovedHeadHeight, KSWidth, KSHeight-MovedHeadHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(TabHeadHeight-MovedHeadHeight, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc]init];
    }
    return _headerView;
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"mine_icon_back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}
- (UIButton *)feedBtn
{
    if (!_feedBtn) {
        _feedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_feedBtn setImage:[UIImage imageNamed:@"mine_icon_jb"] forState:UIControlStateNormal];
    }
    return _feedBtn;
}
- (UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 79, 76, 76)];
        _headImg.backgroundColor = [UIColor orangeColor];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 38;
        
    }
    return _headImg;
}

//禁止横屏
- (BOOL)shouldAutorotate {
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
