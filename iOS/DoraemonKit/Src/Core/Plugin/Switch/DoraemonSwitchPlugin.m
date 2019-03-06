//
//  DoraemonSwitchPlugin.m
//  AFNetworking
//
//  Created by zx on 2019/3/6.
//

#import "DoraemonSwitchPlugin.h"
#import "DoraemonManager.h"

@implementation DoraemonSwitchPlugin

- (void)pluginDidLoad{
    
}

- (void)pluginDidLoad:(NSDictionary *)itemData {
    
    BOOL isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"YXDoraemon_%@", itemData[@"name"]]] boolValue];
    [[NSUserDefaults standardUserDefaults] setValue:@(!isOn) forKey:[NSString stringWithFormat:@"YXDoraemon_%@", itemData[@"name"]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoraemonSwitchPluginValueChanged" object:nil];
    
    if ([DoraemonManager shareInstance].handleSwithValueChangedBlock) {
        [DoraemonManager shareInstance].handleSwithValueChangedBlock(itemData[@"name"], !isOn);
    }
}

@end
