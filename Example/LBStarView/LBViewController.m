//
//  LBViewController.m
//  LBStarView
//
//  Created by j1103765636@iCloud.com on 01/25/2018.
//  Copyright (c) 2018 j1103765636@iCloud.com. All rights reserved.
//

#import "LBViewController.h"
#import "LBStarView.h"
//#import <LBSDK/LBPerson.h>

@interface LBViewController ()<LBStarViewDelegate>

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LBStarView *view = [LBStarView starViewWithNumbers:5 backImageName:@"" foreImageName:@""];
    view.delegate = self;
    [view setOnlyHalf:YES];
    [view setInterStar:YES];
    [view setScore:4.2];
    [self.view addSubview:view];
    view.frame = CGRectMake(10, 100, 250, 50);
//    [LBPerson eat];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)starView:(LBStarView *)starView score:(CGFloat)score{
    
    NSLog(@"-------%f----",score);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
