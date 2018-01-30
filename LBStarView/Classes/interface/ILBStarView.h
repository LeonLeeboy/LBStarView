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
 */
- (void)setOnlyread:(BOOL)flag;


/**
 设置是否有1.3，1.2，5.6 这种类型的分数。 //未实现，先填坑 （eg:1.3 -> 1.5 , 1.6 -> 2.0）
 */
- (void)setOnlyHalf:(BOOL)onlyHalf;


/**
 只有 1 ，2 ，3 ，4 ， 5 这种类型的分数。
 */
- (void)setInterStar:(BOOL)onlyInteger;

@end
