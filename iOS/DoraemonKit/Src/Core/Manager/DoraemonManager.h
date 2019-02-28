//
//  DoraemonManager.h
//  DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import <Foundation/Foundation.h>

typedef void (^DoraemonH5DoorBlock)(NSString *);
typedef void (^DoraemonServerChangedBlock)(NSString *serverDomain);

typedef NS_ENUM(NSUInteger, DoraemonManagerServerType) {
    DoraemonManagerServerType_Test,
    DoraemonManagerServerType_TestRelease,
    DoraemonManagerServerType_Release,
};

typedef NS_ENUM(NSUInteger, DoraemonManagerPluginType) {
    
#pragma mark - 业务工具
    // 环境切换
    DoraemonManagerPluginType_Server,
    // 账号切换
    DoraemonManagerPluginType_Account,
    
    #pragma mark - 常用工具
    // App信息
    DoraemonManagerPluginType_DoraemonAppInfoPlugin,
    // 沙盒浏览
    DoraemonManagerPluginType_DoraemonSandboxPlugin,
    // MockGPS
    DoraemonManagerPluginType_DoraemonGPSPlugin,
    // H5任意门
    DoraemonManagerPluginType_DoraemonH5Plugin,
    // Crash查看
    DoraemonManagerPluginType_DoraemonCrashPlugin,
    // 子线程UI
    DoraemonManagerPluginType_DoraemonSubThreadUICheckPlugin,
    // 清除本地数据
    DoraemonManagerPluginType_DoraemonDeleteLocalDataPlugin,
    // NSLog
    DoraemonManagerPluginType_DoraemonNSLogPlugin,
    // 日志显示
    DoraemonManagerPluginType_DoraemonCocoaLumberjackPlugin,
    
    #pragma mark - 性能检测
    // 帧率监控
    DoraemonManagerPluginType_DoraemonFPSPlugin,
    // CPU监控
    DoraemonManagerPluginType_DoraemonCPUPlugin,
    // 内存监控
    DoraemonManagerPluginType_DoraemonMemoryPlugin,
    // 流量监控
    DoraemonManagerPluginType_DoraemonNetFlowPlugin,
    // 卡顿检测
    DoraemonManagerPluginType_DoraemonANRPlugin,
    // 自定义 性能数据保存到本地
    DoraemonManagerPluginType_DoraemonAllTestPlugin,
    // Load耗时
    DoraemonManagerPluginType_DoraemonMethodUseTimePlugin,
    
    #pragma mark - 视觉工具
    // 颜色吸管
    DoraemonManagerPluginType_DoraemonColorPickPlugin,
    // 组件检查
    DoraemonManagerPluginType_DoraemonViewCheckPlugin,
    // 对齐标尺
    DoraemonManagerPluginType_DoraemonViewAlignPlugin,
    // 元素边框线
    DoraemonManagerPluginType_DoraemonViewMetricsPlugin
};

@interface DoraemonManagerPluginTypeModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *pluginName;
@property(nonatomic, copy) NSString *atModule;

@end

@interface DoraemonManager : NSObject

+ (nonnull DoraemonManager *)shareInstance;

- (void)install;

- (void)installWithCustomBlock:(void(^)())customBlock;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, copy, readonly) NSMutableArray *servers; /**< 服务器地址 */

@property (nonatomic, copy) DoraemonH5DoorBlock h5DoorBlock;
@property (nonatomic, copy) DoraemonServerChangedBlock serverChangedBlock; /**< 切换环境回调 */
@property (nonatomic, copy) NSString *currentServerDomain; /**< 当前服务器域名 */

- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName;

- (void)removePluginWithPluginType:(DoraemonManagerPluginType)pluginType;
// 推荐使用 removePluginWithPluginType 方法
- (void)removePluginWithPluginName:(NSString *)pluginName atModule:(NSString *)moduleName;

- (void)addStartPlugin:(NSString *)pluginName;
    
- (void)addH5DoorBlock:(void(^)(NSString *h5Url))block;

- (void)addANRBlock:(void(^)(NSDictionary *anrDic))block;

- (void)addperformanceBlock:(void(^)(NSDictionary *performanceDic))block;

- (void)hiddenDoraemon;

- (void)hiddenHomeWindow;

/**
 配置服务器地址

 @param testServer 测试服务器
 @param testReleaseSever 仿真服务器
 @param releaseServer 正式服务器
 @param currentServerType 当前服务器
 */
- (void)configTestServer:(NSString *)testServer
        testReleaseSever:(NSString *)testReleaseSever
           releaseServer:(NSString *)releaseServer
       currentServerType:(DoraemonManagerServerType)currentServerType;

@end
