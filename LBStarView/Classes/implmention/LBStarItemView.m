//
//  LBStarItemView.m
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import "LBStarItemView.h"

@interface LBStarItemView ()
@property (nonatomic , weak) UIImageView *imageView;
@property (nonatomic , copy) NSString *imageName;
@end

@implementation LBStarItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)itemViewWithImageViewName:(NSString *)imageName{
    LBStarItemView *view = [[LBStarItemView alloc] init];
    view.imageName = imageName;
    [view refreshUIWithImageName:imageName];
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
    // UI
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _imageView = imageView;
}

- (void)refreshUIWithImageName:(NSString *)imageName{
    _imageName = imageName;
//     self.imageView.image = [UIImage imageNamed:imageName];
    if ([imageName containsString:@"LBStar"]) {
        NSLog(@"-------imageName:%@----",imageName);
        self.imageView.image =  [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:self.class]
                      compatibleWithTraitCollection:nil];
    }else{
        self.imageView.image = [UIImage imageNamed:imageName];
    }
    
}

- (void)layoutSubviews{
    self.imageView.frame = self.bounds;
    [super layoutSubviews];

}

@end

