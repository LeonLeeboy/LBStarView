//
//  LBStarContentView.h
//  LBStarView
//
//  Created by ivan on 2018/1/26.
//

#import <UIKit/UIKit.h>

@interface LBStarContentView : UIView

+ (instancetype)viewWithStarNumbers:(NSUInteger)starNumber ImageName:(NSString *)imageName;

- (void)refreshUIWithStarNumbers:(NSUInteger)starNumber imageName:(NSString *)imageName;

- (void)refresUIWithImageName:(NSString *)imageName;

@end
