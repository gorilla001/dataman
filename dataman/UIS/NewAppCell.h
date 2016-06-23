//
//  NewAppCell.h
//  yzyw
//
//  Created by nmg on 16/6/10.
//  Copyright © 2016年 nmg. All rights reserved.
//

#ifndef NewAppCell_h
#define NewAppCell_h

#import <UIKit/UIKit.h>

@interface NewAppCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

- (void)configCell:(NSIndexPath *)indexPath;
@end

#endif /* NewAppCell_h */
