//
//  DoraemonNetFlowManager.m
//  Aspects
//
//  Created by yixiang on 2018/4/11.
//

#import "DoraemonNetFlowManager.h"
#import "DoraemonNSURLProtocol.h"
#import "DoraemonNetFlowDataSource.h"
#import "NSObject+Doraemon.h"


@implementation DoraemonNetFlowManager

+ (DoraemonNetFlowManager *)shareInstance{
    static dispatch_once_t once;
    static DoraemonNetFlowManager *instance;
    dispatch_once(&once, ^{
        instance = [[DoraemonNetFlowManager alloc] init];
    });
    return instance;
}

- (void)canInterceptNetFlow:(BOOL)enable{
    _canIntercept = enable;
    if (enable) {
        [NSURLProtocol registerClass:[DoraemonNSURLProtocol class]];
        _startInterceptDate = [NSDate date];
    }else{
        [NSURLProtocol unregisterClass:[DoraemonNSURLProtocol class]];
        _startInterceptDate = nil;
        [[DoraemonNetFlowDataSource shareInstance] clear];
    }
}

@end
