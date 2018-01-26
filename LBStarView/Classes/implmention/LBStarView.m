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
@property (assign , nonatomic , readwrite) NSUInteger starNumbers;
@property (copy , nonatomic , readwrite) NSString *foreImagename;
@property (copy, nonatomic , readwrite) NSString *backImageName;
@property (assign , nonatomic) CGFloat percent;
@property (assign , nonatomic) BOOL onlyRead;

@property(strong , nonatomic) UIPanGestureRecognizer *pan;
@property (strong , nonatomic) UITapGestureRecognizer *tap;


@property (strong , nonatomic , readwrite) LBStarContentView *foreinView;
@property (strong , nonatomic , readwrite) LBStarContentView *backView;
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
    [view refreshUIWithStarNumbers:numbers BackImageName:backImageName foreImageName:foreImageName];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)refreshUIWithStarNumbers:(NSUInteger)starNumber BackImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName{
    if (![_backImageName isEqualToString:backImageName]) {
        _backImageName = backImageName;
        [_backView refresUIWithImageName:backImageName];
    }
    if (![_foreImagename isEqualToString:foreImageName]) {
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
    if (newSuperview != nil) {
        [self addObservers];
    }
}

- (void)addObservers{
    if (!self.onlyRead) {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [self addGestureRecognizer:_pan];
        [self addGestureRecognizer:_tap];
    }
    
    
}

- (void)removeObservers{
    if (self.onlyRead) {
        [self.pan removeTarget:self action:@selector(move:)];
        [self.tap removeTarget:self action:@selector(move:)];
        _tap = nil;
        _pan = nil;
    }
   
}

- (void)move:(UIPanGestureRecognizer *)rec{
    CGPoint point = [rec locationInView:self];
    [self changeStarNumbersWithPoint:point];
}

- (void)changeStarNumbersWithPoint:(CGPoint)point{
    CGFloat x = point.x;
    if (x > self.bounds.size.width|| x < 0) {
        return;
    }
    CGFloat w = self.frame.size.width;
    self.percent =  x / w;
    self.currentScore = self.starNumbers * _percent;
    CGRect frame = CGRectMake(0, 0, w * self.percent, self.frame.size.height);
    _foreinView.frame = frame;
    if ([self.delegate respondsToSelector:@selector(starView:score:)]) {
        [self.delegate starView:self score:(self.starNumbers * _percent)];
    }
    
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
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width * self.percent, self.bounds.size.height);
    _foreinView.frame = frame;
}

- (void)prepare{
    // data
    _starNumbers = 5;
    _backImageName = @"";
    _foreImagename = @"";
    _percent = 0.0;
    _onlyRead = NO;
    // UI
    [self prepareUIWIthStarNumbers:_starNumbers backImageName:_backImageName foreImageName:_foreImagename];
}



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

@end
