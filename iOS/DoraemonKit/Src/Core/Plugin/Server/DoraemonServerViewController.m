//
//  DoraemonServerViewController.m
//  AFNetworking
//
//  Created by zx on 2019/2/28.
//

#import "DoraemonServerViewController.h"
#import "DoraemonAppInfoCell.h"
#import "DoraemonDefine.h"
#import "DoraemonAppInfoUtil.h"
#import "Doraemoni18NUtil.h"
#import "UIView+Doraemon.h"
#import "UIColor+Doraemon.h"
#import "DoraemonManager.h"

@interface DoraemonServerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *authority;
    
@end

@implementation DoraemonServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}
    
- (BOOL)needBigTitleView{
    return YES;
}
    
- (void)initUI
    {
        self.title = DoraemonLocalizedString(@"环境切换");
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, self.view.doraemon_height-self.bigTitleView.doraemon_bottom) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 0.;
        self.tableView.estimatedSectionFooterHeight = 0.;
        self.tableView.estimatedSectionHeaderHeight = 0.;
        [self.view addSubview:self.tableView];
    }
    
#pragma mark - default data
    
- (void)initData
    {
        
        NSArray *dataArray = @[
                               @{
                                   @"title":DoraemonLocalizedString(@"选择服务器"),
                                   @"array":@[
                                           @{
                                               @"title":DoraemonLocalizedString(@"测试"),
                                               @"value": @""
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"仿真"),
                                               @"value":@""
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"正式"),
                                               @"value":@""
                                               }
                                           ]
                                   },
                               ];
        _dataArray = dataArray;
    }
    
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataArray[section][@"array"];
    return array.count;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DoraemonAppInfoCell cellHeight];
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDoraemonSizeFrom750(120);
}
    
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.doraemon_width, kDoraemonSizeFrom750(120))];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDoraemonSizeFrom750(32), 0, DoraemonScreenWidth-kDoraemonSizeFrom750(32), kDoraemonSizeFrom750(120))];
    NSDictionary *dic = _dataArray[section];
    titleLabel.text = dic[@"title"];
    titleLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750(28)];
    titleLabel.textColor = [UIColor doraemon_black_3];
    [sectionView addSubview:titleLabel];
    return sectionView;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"httpcell";
    DoraemonAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[DoraemonAppInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSArray *array = _dataArray[indexPath.section][@"array"];
    NSDictionary *item = array[indexPath.row];
    if (indexPath.section == 2 && indexPath.row == 1 && self.authority) {
        NSMutableDictionary *tempItem = [item mutableCopy];
        [tempItem setValue:self.authority forKey:@"value"];
        [cell renderUIWithData:tempItem];
    }else{
        [cell renderUIWithData:item];
    }
    
    DoraemonManagerServerType currentType = [[DoraemonManager shareInstance] currentServerType];
    
    cell.accessoryType = (currentType == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.backgroundColor = (currentType == indexPath.row) ? [UIColor colorWithWhite:0 alpha:0.1] : [UIColor whiteColor];
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[DoraemonManager shareInstance] setCurrentServerType:indexPath.row];
    [DoraemonManager shareInstance].serverChangedBlock([[DoraemonManager shareInstance] currentServers]);
    [tableView reloadData];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该功能需要重启App才能生效" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
