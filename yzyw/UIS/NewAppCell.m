//
//  NewAppCell.m
//  yzyw
//
//  Created by nmg on 16/6/10.
//  Copyright © 2016年 nmg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewAppCell.h"

@interface NewAppCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) NSString *textValue;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *localView;
@end

@implementation NewAppCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WHITE_COLOR;
        [self addSubview:self.nameLabel];
        [self addSubview:self.textField];
        
    }
    return self;
}


- (void)configCell:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
        
        if (indexPath.row == 0) {
//            _nameLabel.text = [NSString stringWithFormat:@"应用名称"];
            _textField.placeholder = @"应用名称";
        }else{
//            _nameLabel.text = [NSString stringWithFormat:@"电话:"];
//            _textField.keyboardType = UIKeyboardTypeDecimalPad;
            _textField.placeholder = @"收货人手机号";
            
        }
        
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(18, (self.height-20)/2.0, 40, 20);
    _textField.frame = CGRectMake(_nameLabel.right+5, (self.height-40)/2.0, self.width-30-_nameLabel.right-5, 40);
    
    if (_indexPath.section == 1) {
        _nameLabel.frame = CGRectMake(18, (self.height-20)/2.0, 70, 20);
        _textField.frame = CGRectMake(_nameLabel.right+5, (self.height-40)/2.0, self.width-30-_nameLabel.right-5, 40);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



#pragma mark - Getter
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = FONT(16);
        _nameLabel.textColor = RGB_COLOR(57, 57, 57);
    }
    return _nameLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.font = FONT(16);
        _textField.placeholder = @"必填";
        //        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}


- (UIImageView *)localView
{
    if (!_localView) {
        _localView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_add"]];
        _localView.frame = CGRectMake(0, 0, 17, 17);
    }
    return _localView;
}

@end