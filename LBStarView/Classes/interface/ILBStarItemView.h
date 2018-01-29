//
//  ILBStarItemView.h
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import <Foundation/Foundation.h>

@protocol ILBStarItemView <NSObject>

@required
//初始化 ， 用这个方法初始化
+ (instancetype)itemViewWithImageViewName:(NSString *)imageName;
// 刷新
- (void)refreshUIWithImageName:(NSString *)imageName;

@end
