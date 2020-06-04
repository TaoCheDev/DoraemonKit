//
//  DoraemonManager.h
//  DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static const NSString *DMKeyServers = @"DMKey_Servers";
static const NSString *DMKeyCurrentServerType = @"DMKey_CurrentServerType";

typedef void (^DoraemonH5DoorBlock)(NSString *);

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
    #pragma mark - weex专项工具
    // 日志
    DoraemonManagerPluginType_DoraemonWeexLogPlugin,
    // 缓存
    DoraemonManagerPluginType_DoraemonWeexStoragePlugin,
    // 信息
    DoraemonManagerPluginType_DoraemonWeexInfoPlugin,
    // DevTool
    DoraemonManagerPluginType_DoraemonWeexDevToolPlugin,
    #pragma mark - 常用工具
    // App设置
    DoraemonManagerPluginType_DoraemonAppSettingPlugin,
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
    // 清理缓存
    DoraemonManagerPluginType_DoraemonDeleteLocalDataPlugin,
    // NSLog
    DoraemonManagerPluginType_DoraemonNSLogPlugin,
    // 日志显示
    DoraemonManagerPluginType_DoraemonCocoaLumberjackPlugin,
    // 数据库工具
    DoraemonManagerPluginType_DoraemonDatabasePlugin,
    // NSUserDefaults工具
    DoraemonManagerPluginType_DoraemonNSUserDefaultsPlugin,
    
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
    // Load耗时
    DoraemonManagerPluginType_DoraemonMethodUseTimePlugin,
    // 大图检测
    DoraemonManagerPluginType_DoraemonLargeImageFilter,
    // 启动耗时
    DoraemonManagerPluginType_DoraemonStartTimePlugin,
    // 内存泄漏
    DoraemonManagerPluginType_DoraemonMemoryLeakPlugin,
    // UI层级检查
    DoraemonManagerPluginType_DoraemonUIProfilePlugin,
    // UI结构调整
    DoraemonManagerPluginType_DoraemonHierarchyPlugin,
    // 函数耗时
    DoraemonManagerPluginType_DoraemonTimeProfilePlugin,
    // 模拟弱网
    DoraemonManagerPluginType_DoraemonWeakNetworkPlugin,
    
    #pragma mark - 视觉工具
    // 颜色吸管
    DoraemonManagerPluginType_DoraemonColorPickPlugin,
    // 组件检查
    DoraemonManagerPluginType_DoraemonViewCheckPlugin,
    // 对齐标尺
    DoraemonManagerPluginType_DoraemonViewAlignPlugin,
    // 元素边框线
    DoraemonManagerPluginType_DoraemonViewMetricsPlugin,
    
    #pragma mark - 平台工具
    // Mock 数据
    DoraemonManagerPluginType_DoraemonMockPlugin,
    DoraemonManagerPluginType_DoraemonHealthPlugin
};

@interface DoraemonManagerPluginTypeModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *pluginName;
@property(nonatomic, copy) NSString *atModule;
@property(nonatomic, copy) NSString *buriedPoint;

@end

@interface DoraemonManager : NSObject

+ (nonnull DoraemonManager *)shareInstance;

@property (nonatomic, copy) NSString *appKey __attribute__((deprecated("此属性已被弃用，替换方式请参考最新 https://www.dokit.cn/ 的使用手册")));

@property (nonatomic, copy) NSString *pId; //产品id 平台端的工具必须填写

@property (nonatomic, assign) BOOL autoDock; //dokit entry icon support autoDock，deffault yes

- (void)install;
//带有平台端功能的s初始化方式
- (void)installWithPid:(NSString *)pId;

// 定制起始位置 | 适用正好挡住关键位置
- (void)installWithStartingPosition:(CGPoint) position;

- (void)installWithCustomBlock:(void(^)(void))customBlock;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, copy) DoraemonH5DoorBlock h5DoorBlock;
@property (nonatomic, copy) void (^handleDidSelectedTestUserBlock)(NSDictionary *userInfo); /**< 已选择切换测试账号Block */
@property (nonatomic, copy) void (^handleSwithValueChangedBlock)(NSString *title, BOOL isOn); /**< 开关选择器状态发生变化Block */
@property (nonatomic, copy) void (^handleClickEventButtonBlock)(NSString *title); /**< 点击按钮类型Block */

- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName;
- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName handle:(void(^)(NSDictionary *itemData))handleBlock;


/**
 添加开关，结合handleSwithValueChangedBlock使用

 @param title 开关名称
 @param moduleName 类别
 @param isOn 默认值 YES or NO
 */
- (void)addSwitchPluginWithTitle:(NSString *)title atModule:(NSString *)moduleName defaultValue:(BOOL)isOn;

/**
 添加点击事件的按钮

 @param title 标题
 @param iconName 图片icon
 @param moduleName 类别
 */
- (void)addEventPluginWithTitle:(NSString *)title icon:(NSString *)iconName atModule:(NSString *)moduleName;

- (void)removePluginWithPluginType:(DoraemonManagerPluginType)pluginType;

// 推荐使用 removePluginWithPluginType 方法
- (void)removePluginWithPluginName:(NSString *)pluginName atModule:(NSString *)moduleName;

- (void)addStartPlugin:(NSString *)pluginName;
    
- (void)addH5DoorBlock:(void(^)(NSString *h5Url))block;

- (void)addANRBlock:(void(^)(NSDictionary *anrDic))block;

- (void)addPerformanceBlock:(void(^)(NSDictionary *performanceDic))block;

- (BOOL)isShowDoraemon;

- (void)showDoraemon;

- (void)hiddenDoraemon;

- (void)hiddenHomeWindow;

/**
 配置服务器地址

 @param testServers 测试服务器
 @param testReleaseSevers 仿真服务器
 @param releaseServers 正式服务器
 */
- (void)setTestServers:(NSArray<NSString *> *)testServers testReleaseSevers:(NSArray<NSString *> *)testReleaseSevers releaseServers:(NSArray<NSString *> *)releaseServers;

/**
 当前服务器集合

 @return 当前服务器集合
 */
- (NSArray<NSString *> *)currentServers;

/**
 当前服务器类别

 @return 当前服务器类别
 */
- (DoraemonManagerServerType)currentServerType;

/**
 设置服务器类别

 @param serverType 设置服务器类别
 */
- (void)setCurrentServerType:(DoraemonManagerServerType)serverType;

/** 设置第一次启动时App的环境 */
- (void)setInstallAppServerType:(DoraemonManagerServerType)serverType;

@property (nonatomic, assign) int64_t bigImageDetectionSize; // 外部设置大图检测的监控数值  比如监控所有图片大于50K的图片 那么这个值就设置为 50 * 1024；

@property (nonatomic, copy) NSString *startClass; //如果你的启动代理不是默认的AppDelegate,需要传入才能获取正确的启动时间

@property (nonatomic, copy) NSArray *vcProfilerBlackList;//使用vcProfiler的使用，兼容一些异常情况，比如issue416

@property (nonatomic, strong) NSMutableDictionary *keyBlockDic;//保存key和block的关系


@end
NS_ASSUME_NONNULL_END
