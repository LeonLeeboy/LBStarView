//
//  LBStarView.m
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import "LBStarView.h"
#import "LBStarContentView.h"


@interface LBStarView ()
@property (assign , nonatomic , readwrite) CGFloat currentScore;
// private
@property (assign , nonatomic , readwrite) NSUInteger starNumbers;
@property (copy , nonatomic , readwrite) NSString *foreImagename;
@property (copy, nonatomic , readwrite) NSString *backImageName;
@property (assign , nonatomic) CGFloat percent;
@property (assign , nonatomic) BOOL onlyRead;

@property(strong , nonatomic) UIPanGestureRecognizer *pan;
@property (strong , nonatomic) UITapGestureRecognizer *tap;


@property (strong , nonatomic , readwrite) LBStarContentView *foreinView;
@property (strong , nonatomic , readwrite) LBStarContentView *backView;

@property (assign , nonatomic) BOOL onlyHalfStar;
@property (assign , nonatomic) BOOL onlyInterStar;
@end

@implementation LBStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)starViewWithNumbers:(NSUInteger)numbers backImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName{
    LBStarView *view = [[self alloc] init];
    // 这边最好用refresh ，一开始设计的时候用的reset ， 后来想了想对象已经创建好了，用刷新更好一点。如果碰到需要按照数据来进行重新弄初始化，在refresh 中处理掉就好了，外部尽量不要用reset。避免借口复杂性。
    [view refreshUIWithStarNumbers:numbers BackImageName:backImageName foreImageName:foreImageName];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

// for xib
- (void)awakeFromNib{
    [super awakeFromNib];
    [self prepare];
}


- (void)refreshUIWithStarNumbers:(NSUInteger)starNumber BackImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName{
    if (![_backImageName isEqualToString:backImageName]&& _backImageName != nil && ![_backImageName isEqualToString:@""]) {
        _backImageName = backImageName;
        [_backView refresUIWithImageName:backImageName];
    }
    if (![_foreImagename isEqualToString:foreImageName] && _foreImagename != nil && ![_foreImagename isEqualToString:@""]) {
        _foreImagename = foreImageName;
        [_foreinView refresUIWithImageName:foreImageName];
    }
   
    if (_starNumbers != starNumber) {
        _starNumbers = starNumber;
        [self resetUIWithStarNumbers:starNumber foreImageName:foreImageName backImageName:backImageName];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self removeObservers];
    // 通过nil 来判断是进入改页面 还是离开该页面。
    if (newSuperview != nil) {
        [self addObservers];
    }
}

- (void)addObservers{
    if (!self.onlyRead) {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(starTap:)];
        [self addGestureRecognizer:_pan];
        [self addGestureRecognizer:_tap];
    }
    
    
}

- (void)removeObservers{
    if (self.onlyRead) {
        [self.pan removeTarget:self action:@selector(move:)];
        [self.tap removeTarget:self action:@selector(starTap:)];
        _tap = nil;
        _pan = nil;
    }
   
}


/**
 点击的时候调用的方法
 */
- (void)starTap:(UITapGestureRecognizer *)rec{
    CGPoint point = [rec locationInView:self];
    [self changeStarNumbersWithPoint:point];
}

/**
 移动手指的时候触发的方法
 */
- (void)move:(UIPanGestureRecognizer *)rec{
    CGPoint point = [rec locationInView:self];
    [self changeStarNumbersWithPoint:point];
}


/**
 改变前面（foreView）一个StarView的frame
 */
- (void)changeStarNumbersWithPoint:(CGPoint)point{
    CGFloat x = point.x;
    if (x > self.bounds.size.width|| x < 0) {
        return;
    }
    CGFloat w = self.frame.size.width;
    self.percent =  x / w;
    self.currentScore = self.starNumbers * _percent;
    if (_onlyHalfStar) {
       //以半个星为一个单位
        [self dealHalfStar];
    }
    if (_onlyInterStar) {
        [self dealInterStar];
    }
    CGRect frame = CGRectMake(0, 0, w * self.percent, self.frame.size.height);
    _foreinView.frame = frame;
    if ([self.delegate respondsToSelector:@selector(starView:score:)]) {
        [self.delegate starView:self score:(self.starNumbers * _percent)];
    }
    
}


/**
 处理一下全局变量，当只能显示半颗星的是欧
 */
- (void)dealHalfStar{
    //以半个星为一个单位
    NSInteger count = ((_currentScore + 0.5) * 10) / (0.5 * 10) ;
    _currentScore = count * (1 / 2.0) ;
    self.percent = _currentScore / self.starNumbers;
}


/**
 处理一下全局变量，当只能显示颗星的是欧
 */
- (void)dealInterStar{
    NSInteger count = ((_currentScore + 1.0) * 10 ) /( 1.0 * 10);
    _currentScore = count * 1;
    self.percent = _currentScore / self.starNumbers;
}

- (void)setOnlyread:(BOOL)flag{
    if (_onlyRead == flag) {
        return;
    }
    self.onlyRead = flag;
    [self removeObservers];
    [self addObservers];
}


- (void)resetUIWithStarNumbers:(NSUInteger)starNumbers foreImageName:(NSString *)foreImageName backImageName:(NSString *)backImageName{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self prepareUIWIthStarNumbers:starNumbers backImageName:backImageName foreImageName:foreImageName];
}

- (void)setScore:(CGFloat)score{
    if (score > self.starNumbers / 1.0) {
        score = self.starNumbers / 1.0;
    }
    self.percent = score / self.starNumbers;
    _currentScore =  score;
    if (_onlyHalfStar) {
        //以半个星为一个单位
        [self dealHalfStar];
    }
    if (_onlyInterStar) {
        [self dealInterStar];
    }
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width * self.percent, self.bounds.size.height);
    _foreinView.frame = frame;
}

- (void)prepare{
    // data
    _starNumbers = 5;
    _backImageName = @"LBStarbackgroundStar";
    _foreImagename = @"LBStarforegroundStar";
    _percent = 0.0;
    _onlyRead = NO;
    _onlyHalfStar = NO;
    _onlyInterStar = NO;
    // UI
    [self prepareUIWIthStarNumbers:_starNumbers backImageName:_backImageName foreImageName:_foreImagename];
}


//初始化UI ， 当需要依据数据的时候
- (void)prepareUIWIthStarNumbers:(NSUInteger)starNumbers backImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName{
    _backView = [LBStarContentView viewWithStarNumbers:starNumbers ImageName:backImageName];
    _backView.clipsToBounds = YES;
    [self addSubview:_backView];
    _foreinView = [LBStarContentView viewWithStarNumbers:starNumbers ImageName:foreImageName];
    _foreinView.clipsToBounds = YES;
    [self addSubview:_foreinView];
}


- (void)layoutSubviews{
    _backView.frame = self.bounds;
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width * self.percent, self.bounds.size.height);
    _foreinView.frame = frame;
    [super layoutSubviews];
    
}

- (void)setOnlyHalf:(BOOL)onlyHalf{
    if (_onlyHalfStar == onlyHalf) {
        return;
    }
    _onlyHalfStar = onlyHalf;
    if (_onlyHalfStar == YES) {
        _onlyInterStar = NO;
    }
    [self resetUIWithStarNumbers:_starNumbers foreImageName:_foreImagename backImageName:_backImageName];
}

- (void)setInterStar:(BOOL)onlyInteger{
    if (_onlyInterStar == onlyInteger) {
        return;
    }
    _onlyInterStar = onlyInteger;
    if (_onlyInterStar == YES) {
        _onlyHalfStar = NO;
    }
    [self resetUIWithStarNumbers:_starNumbers foreImageName:_foreImagename backImageName:_backImageName];
}

@end
