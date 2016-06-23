
#import "ItemCell.h"
#import <UIImageView+AFNetworking.h>

#define IMAGE_URL "http://devstatic.dataman-inc.net/app_catalog_icons"

@interface ItemCell ()
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIView *line;
@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITE_COLOR;
        self.clipsToBounds = YES;
        
        [self addSubview:self.photo];
        [self addSubview:self.line];
        [self addSubview:self.name];
    }
    return self;
}


- (void)configItemCell:data
{
    NSString *photo = [NSString stringWithFormat:@"%s/%@.png", IMAGE_URL, data[@"name"]];
    [self.photo sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"home_rec"]];
    self.name.text = data[@"name"];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photo.frame = CGRectScaleXY(0, 0, 290/2.0, 150);
    self.line.frame = CGRectScaleXY(0, self.photo.bottom + 5, self.width, 1);
    self.name.frame = CGRectScaleXY(0, self.line.bottom+5, self.width-20, 30);
}

- (UIImageView *)photo
{
    if (!_photo) {
        _photo = [UIImageView new];
    }
    return _photo;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.font = FONT(16);
        _name.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = RGB_COLOR(242, 242, 242);
    }
    return _line;
}

@end
