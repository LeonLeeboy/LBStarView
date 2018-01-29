//
//  ILBStarView.h
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import <Foundation/Foundation.h>

@protocol ILBStarView <NSObject>

@property (assign , nonatomic , readonly) CGFloat currentScore;


@required
//用这个初始化方法 初始化
+ (instancetype)starViewWithNumbers:(NSUInteger)numbers backImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName;

@optional
//设置分数
- (void)setScore:(CGFloat)score;


/**
 设置是否是只能可读

 @param flag <#flag description#>
 */
- (void)setOnlyread:(BOOL)flag;

@end
