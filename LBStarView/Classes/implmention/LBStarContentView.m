//
//  LBStarContentView.m
//  LBStarView
//
//  Created by ivan on 2018/1/26.
//

#import "LBStarContentView.h"
#import "LBStarItemView.h"

@interface LBStarContentView ()
@property (assign , nonatomic , readwrite) NSUInteger starNumbers;
@property (copy, nonatomic , readwrite) NSString *imageName;
@property (strong , nonatomic) NSMutableArray <LBStarItemView *>*starImageViewArray;
@end

@implementation LBStarContentView

# pragma mark - lazy
- (NSMutableArray<LBStarItemView *> *)starImageViewArray{
    if (_starImageViewArray == nil) {
        _starImageViewArray = [NSMutableArray array];
    }
    return _starImageViewArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)viewWithStarNumbers:(NSUInteger)starNumber ImageName:(NSString *)imageName{
    LBStarContentView *view = [[LBStarContentView alloc] init];
    [view refreshUIWithStarNumbers:starNumber imageName:imageName];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)prepare{
    //data
    _starNumbers = 5;
    _imageName = @"";
    //UI
    [self prepareUIWithStarNumbers:_starNumbers imageName:_imageName];
}

- (void)refreshUIWithStarNumbers:(NSUInteger)starNumber imageName:(NSString *)imageName{
    if (_starNumbers != starNumber) {
        _starNumbers = starNumber;
        [self resetUIWithStarNumbers:starNumber imageName:imageName];
    }
    if (![_imageName isEqualToString:imageName]) {
        _imageName = imageName;
        [self refresUIWithImageName:imageName];
    }
}


- (void)resetUIWithStarNumbers:(NSUInteger)starNumber imageName:(NSString *)imageName{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self prepareUIWithStarNumbers:starNumber imageName:imageName];
}

- (void)prepareUIWithStarNumbers:(NSUInteger)starNumbers imageName:(NSString *)imageName{
    for (int i = 0; i < starNumbers; i++) {
        LBStarItemView *itemView = [LBStarItemView itemViewWithImageViewName:imageName];
        [self.starImageViewArray addObject:itemView];
        [self addSubview: itemView];
    }
}

- (void)refresUIWithImageName:(NSString *)imageName{
    [self.starImageViewArray enumerateObjectsUsingBlock:^(LBStarItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj refreshUIWithImageName:imageName];
    }];
}

- (void)layoutSubviews{
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat w = superViewWidth / self.starImageViewArray.count;
    CGFloat h = self.frame.size.height;
    __block CGFloat x = 0.0;
    CGFloat y = 0.0;
    [self.starImageViewArray enumerateObjectsUsingBlock:^(LBStarItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        x = w * idx;
        obj.frame = CGRectMake(x, y, w, h);
    }];
    [super layoutSubviews];
   
}

@end
