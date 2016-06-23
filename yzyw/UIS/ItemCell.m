
#import "AppCell.h"
#import <UIImageView+AFNetworking.h>


@interface AppCell ()
@property (nonatomic, strong) UILabel *name;
@end

@implementation AppCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITE_COLOR;
        self.clipsToBounds = YES;
        
        [self addSubview:self.name];
    }
    return self;
}


- (void)configVegCell:data
{
    self.name.text = data[@"name"];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.name.frame = CGRectScaleXY(10, 10, self.width-20, 12);
}


- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.font = FONT(13);
        //_titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

@end
