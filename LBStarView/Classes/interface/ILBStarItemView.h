//
//  ILBStarItemView.h
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import <Foundation/Foundation.h>

@protocol ILBStarItemView <NSObject>

@required
+ (instancetype)itemViewWithImageViewName:(NSString *)imageName;

- (void)refreshUIWithImageName:(NSString *)imageName;

@end
