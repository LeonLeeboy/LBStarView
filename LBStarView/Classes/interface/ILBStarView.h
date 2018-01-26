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
+ (instancetype)starViewWithNumbers:(NSUInteger)numbers backImageName:(NSString *)backImageName foreImageName:(NSString *)foreImageName;

@optional
- (void)setScore:(CGFloat)score;

- (void)setOnlyread:(BOOL)flag;

@end
