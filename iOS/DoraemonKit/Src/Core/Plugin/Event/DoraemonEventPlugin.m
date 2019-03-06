//
//  DoraemonEventPlugin.m
//  AFNetworking
//
//  Created by zx on 2019/3/6.
//

#import "DoraemonEventPlugin.h"
#import "DoraemonManager.h"

@implementation DoraemonEventPlugin

- (void)pluginDidLoad:(NSDictionary *)itemData {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoraemonEventPlugin" object:nil];
    
    if ([DoraemonManager shareInstance].handleClickEventButtonBlock) {
        [DoraemonManager shareInstance].handleClickEventButtonBlock(itemData[@"name"]);
    }
    
}

@end
