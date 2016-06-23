//
//  HomeHeader.h
//  dataman
//
//  Created by niuminguo on 16/6/23.
//  Copyright © 2016年 nmg. All rights reserved.
//

#ifndef HomeHeader_h
#define HomeHeader_h

#import <UIKit/UIKit.h>

@protocol HomeHeaderDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface HomeHeader : UIView

@property (nonatomic, strong) UIButton *allCaiBtn;
@property (nonatomic, strong) UIButton *myCaiBtn;
@property (nonatomic, assign) id<HomeHeaderDelegate>delegate;

- (void)configHomeHeader:(NSMutableArray *)data;

- (void)stopTimer;

@end

#endif /* HomeHeader_h */
