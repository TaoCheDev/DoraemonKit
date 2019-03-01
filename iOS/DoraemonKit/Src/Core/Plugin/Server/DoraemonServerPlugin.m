//
//  DoraemonServerPlugin.m
//  AFNetworking
//
//  Created by zx on 2019/2/28.
//

#import "DoraemonServerPlugin.h"
#import "DoraemonUtil.h"
#import "DoraemonServerViewController.h"

@implementation DoraemonServerPlugin
    
- (void)pluginDidLoad {
    DoraemonServerViewController *vc = [[DoraemonServerViewController alloc] init];
    [DoraemonUtil openPlugin:vc];
}
    
@end
