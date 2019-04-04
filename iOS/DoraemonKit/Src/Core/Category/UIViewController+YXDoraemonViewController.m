//
//  NSObject+YXDoraemonViewController.m
//  AFNetworking
//
//  Created by zx on 2019/3/6.
//

#import "UIViewController+YXDoraemonViewController.h"
#import "DoraemonHomeWindow.h"

@implementation UIViewController (YXDoraemonViewController)

#ifdef DEBUG
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        if ([DoraemonHomeWindow shareInstance].hidden) {
            [[DoraemonHomeWindow shareInstance] show];
        } else {
            [[DoraemonHomeWindow shareInstance] hide];
        }
    }
}
#endif

@end
