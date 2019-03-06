//
//  AppDelegate.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "AppDelegate.h"
#import <DoraemonKit/DoraemonKit.h>
#import "DoraemonDemoHomeViewController.h"
//#import <CocoaLumberjack/CocoaLumberjack.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[[self class] handleCCrashReportWrap];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    for (int i=0; i<10; i++) {
        //DDLogInfo(@"点击添加埋点11111");
    }
//    [[DoraemonManager shareInstance] addPluginWithTitle:@"测试插件" icon:@"doraemon_guanbi" desc:@"测试插件" pluginName:@"TestPlugin" atModule:@"业务工具"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"功能开关1" atModule:@"业务工具" defaultValue:YES];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"功能开关2" atModule:@"业务工具" defaultValue:NO];
    [DoraemonManager shareInstance].handleSwithValueChangedBlock = ^(NSString *title, BOOL isOn) {
        if ([title isEqualToString:@"测试1"]) {
            NSLog(@"😃😃");
            NSLog(@"%@,%@ \n\n", @"啊哈哈哈，进来了", @(isOn));
        }
    };
    
    
    [[DoraemonManager shareInstance] install];
    
    [DoraemonManager shareInstance].handleDidSelectedTestUserBlock = ^(NSDictionary *userInfo) {
        NSLog(@"😃😃");
        NSLog(@"%@ \n\n", userInfo);
    };
    
    [[DoraemonManager shareInstance] setTestServers:@[@"hahaha"] testReleaseSevers:@[@"rrrr"] releaseServers:@[@"gg"]];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DoraemonDemoHomeViewController *homeVc = [[DoraemonDemoHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}

void uncaughtExceptionHandler(NSException*exception){
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@",[exception callStackSymbols]);
    // Internal error reporting
}

+(void) handleCCrashReportWrap{    
//    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType: PLCrashReporterSignalHandlerTypeMach symbolicationStrategy: PLCrashReporterSymbolicationStrategyAll];
//    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//
//    NSError *error;
//
//    // Check if we previously crashed
//    if ([crashReporter hasPendingCrashReport])
//        [self handleCCrashReport:crashReporter ];
//
//    // Enable the Crash Reporter
//    if (![crashReporter enableCrashReporterAndReturnError: &error])
//        NSLog(@"Warning: Could not enable crash reporter: %@", error);
}

//+ (void) handleCCrashReport:(PLCrashReporter * ) crashReporter{
//    NSData *crashData;
//    NSError *error;
//    
//    // Try loading the crash report
//    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
//    if (crashData == nil) {
//        NSLog(@"Could not load crash report: %@", error);
//        [crashReporter purgePendingCrashReport];
//        return;
//    }
//    
//    // We could send the report from here, but we'll just print out
//    // some debugging info instead
//    PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error] ;
//    
//    if (report == nil) {
//        NSLog(@"Could not parse crash report");
//        [crashReporter purgePendingCrashReport];
//        return;
//    }
//    
//    //    NSLog(@"Crashed on %@", report.systemInfo.timestamp);
//    //    NSLog(@"Crashed with signal %@ (code %@, address=0x%" PRIx64 ")", report.signalInfo.name,
//    //          report.signalInfo.code, report.signalInfo.address);
//    
//    // Purge the report
//    [crashReporter purgePendingCrashReport];
//    
////    *     //上传--这后面的代码是我加的.
//       NSString *humanText = [PLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
//    NSLog(@"yixiang crash == %@",humanText);
////    *
////    *     [self uploadCrashLog:@"c crash" crashContent:humanText withSuccessBlock:^{
////        *     }];//uploadCrashLog这个函数是把log文件上传服务器的,请自行补充哈;还可以写入沙盒,供自己就地查看,下面是写入沙盒的代码
////    *
////    *     NSString * documentDic = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
////    *     NSString * fileName = [documentDic stringByAppendingPathComponent:@"1.crash"];
////    *     NSError * err = nil;
////    *     [humanText writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&err];
////    return;
//
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
