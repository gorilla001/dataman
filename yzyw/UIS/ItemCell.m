
#import "ItemCell.h"
#import <UIImageView+AFNetworking.h>

#define IMAGE_URL "http://devstatic.dataman-inc.net/app_catalog_icons"

@interface ItemCell ()
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UILabel *name;
@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITE_COLOR;
        self.clipsToBounds = YES;
        
        [self addSubview:self.photo];
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
    
    self.photo.frame = CGRectScaleXY(0, 0, 290/2.0, 232/2.0);
    self.name.frame = CGRectScaleXY(10, self.photo.bottom+10, self.width-20, 12);
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
        _name.font = FONT(13);
        _name.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

@end
