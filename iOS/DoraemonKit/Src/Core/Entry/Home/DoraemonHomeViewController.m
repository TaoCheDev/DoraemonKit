//
//  DoraemonHomeViewController.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "DoraemonHomeViewController.h"
#import "UIView+Doraemon.h"
#import "DoraemonUtil.h"
#import "UIColor+Doraemon.h"
#import "DoraemonManager.h"
#import "DoraemonPluginProtocol.h"
#import "DoraemonHomeWindow.h"
#import "DoraemonDefine.h"
#import "DoraemonHomeSectionView.h"
#import "Doraemoni18NUtil.h"

@interface DoraemonHomeViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation DoraemonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initData{
    _dataArray = [DoraemonManager shareInstance].dataArray;
}

- (void)initUI{
    
    // YXKit：添加开发者工具标题
    self.title = DoraemonLocalizedString(@"开发者工具(淘车iOSv1.0)");
    
    self.view.backgroundColor = [UIColor doraemon_colorWithString:@"#F4F5F6"];
    // YXKit：显示标题栏，scrollview需要下移
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, DoraemonScreenWidth, DoraemonScreenHeight)];
    [self.view addSubview:_scrollView];
    
    CGFloat offsetY = kDoraemonSizeFrom750(32);
    for (int i=0; i<_dataArray.count; i++) {
        NSDictionary *itemData = _dataArray[i];
        CGFloat sectionHeight = [DoraemonHomeSectionView viewHeightWithData:itemData];
        DoraemonHomeSectionView *sectionView = [[DoraemonHomeSectionView alloc] initWithFrame:CGRectMake(kDoraemonSizeFrom750(16), offsetY, self.view.doraemon_width-kDoraemonSizeFrom750(16)*2, sectionHeight)];
        [sectionView renderUIWithData:itemData];
        [_scrollView addSubview:sectionView];
        offsetY += sectionHeight+kDoraemonSizeFrom750(32);
    }
    
    offsetY = offsetY - kDoraemonSizeFrom750(32) + kDoraemonSizeFrom750(56);
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDoraemonSizeFrom750(30), offsetY, self.view.doraemon_width-2*kDoraemonSizeFrom750(30), kDoraemonSizeFrom750(100))];
    closeBtn.backgroundColor = [UIColor whiteColor];
    [closeBtn setTitle:@"关闭DoraemonKit" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor doraemon_colorWithString:@"#CC3A4B"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:closeBtn];
    
    offsetY += closeBtn.doraemon_height+kDoraemonSizeFrom750(30);
    
    _scrollView.contentSize = CGSizeMake(self.view.doraemon_width, offsetY);
    
    // YXKit：摇一摇说明
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.text = @"摇一摇可打开开发者工具";
    desLabel.textColor = [UIColor doraemon_black_3];
    desLabel.font = [UIFont systemFontOfSize:13];
    [desLabel sizeToFit];
    desLabel.frame = CGRectMake(17, (IS_IPHONE_X_Series ? IPHONE_NAVIGATIONBAR_HEIGHT - 15 : _scrollView.frame.origin.y), desLabel.frame.size.width, desLabel.frame.size.height);
    [self.view addSubview:desLabel];
}

- (void)close{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:DoraemonLocalizedString(@"提示") message:DoraemonLocalizedString(@"Doraemon关闭之后需要重启App才能重新打开") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:DoraemonLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:DoraemonLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DoraemonManager shareInstance] hiddenDoraemon];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [[DoraemonUtil topViewControllerForKeyWindow] presentViewController:alertController animated:YES completion:nil];
    
    [[DoraemonHomeWindow shareInstance] hide];
}

// YXKit：显示开发者工具标题
- (BOOL)needBigTitleView {
    return YES;
}

@end
