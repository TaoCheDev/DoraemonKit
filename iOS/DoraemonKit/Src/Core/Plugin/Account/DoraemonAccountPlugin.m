//
//  DoraemonAccountPlugin.m
//  AFNetworking
//
//  Created by zx on 2019/3/1.
//

#import "DoraemonAccountPlugin.h"
#import "DoraemonUtil.h"
#import "DoraemonAccountViewController.h"

@implementation DoraemonAccountPlugin

- (void)pluginDidLoad {
    DoraemonAccountViewController *vc = [[DoraemonAccountViewController alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end
