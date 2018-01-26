//
//  LBStarView.h
//  LBStarView
//
//  Created by ivan on 2018/1/25.
//

#import <UIKit/UIKit.h>
#import "ILBStarView.h"

@class LBStarView;

@protocol LBStarViewDelegate<NSObject>

@optional

- (void)starView:(LBStarView *)starView score:(CGFloat)score;

@end

@interface LBStarView : UIView <ILBStarView>

@property (weak , nonatomic) id <LBStarViewDelegate> delegate;

@end
