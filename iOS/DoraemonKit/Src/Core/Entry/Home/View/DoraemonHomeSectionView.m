//
//  DoraemonHomeSectionView.m
//  AFNetworking
//
//  Created by yixiang on 2018/11/27.
//

#import "DoraemonHomeSectionView.h"
#import "DoraemonDefine.h"
#import "UIView+Doraemon.h"
#import "UIColor+Doraemon.h"
#import "UIImage+Doraemon.h"
#import "DoraemonPluginProtocol.h"

@interface DoraemonHomeSectionItemView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSDictionary *itemData;

@end

@implementation DoraemonHomeSectionItemView

- (instancetype)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.doraemon_width/2-kDoraemonSizeFrom750(68)/2, 0, kDoraemonSizeFrom750(68), kDoraemonSizeFrom750(68))];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.doraemon_bottom+kDoraemonSizeFrom750(12), self.doraemon_width, kDoraemonSizeFrom750(33))];
        _titleLabel.textColor = [UIColor doraemon_colorWithString:@"#666666"];
        _titleLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750(24)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"DoraemonSwitchPluginValueChanged" object:nil];
    }
    return self;
}

- (void)reloadData {
    [self renderUIWithData:self.itemData];
}

- (void)renderUIWithData: (NSDictionary *)data{
    _itemData = data;
    NSString *iconName = data[@"icon"];
    NSString *name = data[@"name"];
    
    if ([data[@"pluginName"] isEqualToString:@"DoraemonSwitchPlugin"]) {
        BOOL isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"YXDoraemon_%@", data[@"name"]]] boolValue];
        _imageView.image = [UIImage doraemon_imageNamed:isOn ? @"doraemon_on" : @"doraemon_off"];
        _titleLabel.text = [NSString stringWithFormat:@"%@%@", (isOn ? @"关闭" : @"开启"), name];
    } else {
        _imageView.image = [UIImage doraemon_imageNamed:iconName];
        _titleLabel.text = name;
    }
}

- (void)itemClick{
    NSString *pluginName = _itemData[@"pluginName"];
    
    if(pluginName){
        Class pluginClass = NSClassFromString(pluginName);
        id<DoraemonPluginProtocol> plugin = [[pluginClass alloc] init];
        if ([plugin respondsToSelector:@selector(pluginDidLoad)]) {
            [plugin pluginDidLoad];
        }
        if ([plugin respondsToSelector:@selector(pluginDidLoad:)]) {
            [plugin pluginDidLoad:(NSDictionary *)_itemData];
        }
    }

}

@end

@interface DoraemonHomeSectionView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DoraemonHomeSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor doraemon_colorWithString:@"#324456"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:kDoraemonSizeFrom750(32)];
        [self addSubview:_titleLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kDoraemonSizeFrom750(8);
    }
    return self;
}

- (void)renderUIWithData:(NSDictionary *)data{
    NSString *moduleName = data[@"moduleName"];
    _titleLabel.text = moduleName;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(kDoraemonSizeFrom750(32), kDoraemonSizeFrom750(32), _titleLabel.doraemon_width, _titleLabel.doraemon_height);
    NSArray *pluginArray = data[@"pluginArray"];
    
    CGFloat offsetX = 0;
    CGFloat offsetY = kDoraemonSizeFrom750(32+45+32);
    CGFloat itemWidth = self.doraemon_width/4;
    CGFloat itemHeight = kDoraemonSizeFrom750(68+12+33);
    CGFloat itemSpace = kDoraemonSizeFrom750(32);
    for (int i=0; i<pluginArray.count;i++) {
        NSDictionary *itemData = pluginArray[i];
        
        if (i%4 == 0 && i !=0 ) {
            offsetY += itemHeight + itemSpace;
            offsetX = 0;
        }
        
        DoraemonHomeSectionItemView *itemView = [[DoraemonHomeSectionItemView alloc] initWithFrame:CGRectMake(offsetX, offsetY, itemWidth, itemHeight)];
        [itemView renderUIWithData:itemData];
        [self addSubview:itemView];
        
        offsetX += itemWidth;
    }
}

+ (CGFloat)viewHeightWithData:(NSDictionary *)data{
    CGFloat titleHeight = kDoraemonSizeFrom750(32+45+32);
    NSArray *pluginArray = data[@"pluginArray"];
    NSInteger count = pluginArray.count;
    NSInteger row = 0;
    if (count%4 == 0) {
        row = count/4;
    }else{
        row = count/4 + 1;
    }
    CGFloat itemHeight = kDoraemonSizeFrom750(68+12+33);
    CGFloat itemSpace = kDoraemonSizeFrom750(32);
    CGFloat totalHeight = titleHeight + row*(itemHeight+itemSpace);
    
    return totalHeight;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
