
#import "ItemCell.h"
#import <UIImageView+AFNetworking.h>

#define IMAGE_URL "http://devstatic.dataman-inc.net/app_catalog_icons"

@interface ItemCell ()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *image;
@property (nonatomic, strong) UILabel *version;
@end

@implementation ItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WHITE_COLOR;
        self.clipsToBounds = YES;
        
        [self addSubview:self.name];
        [self addSubview:self.image];
        [self addSubview:self.version];
    }
    return self;
}


- (void)configItemCell:data
{
   
    self.name.text = data[@"name"];
    self.image.text = data[@"imageName"];
    self.version.text = data[@"imageVersion"];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.name.frame = CGRectMake(10, 0, self.width/4, 60);
    self.image.frame = CGRectMake(self.name.right, 0, self.width/2, 60);
    self.version.frame = CGRectMake(self.image.right, 0, self.width/4, 60);
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.font = FONT(16);
    }
    return _name;
}

- (UILabel *)image
{
    if (!_image) {
        _image = [UILabel new];
        _image.font = FONT(16);
    }
    return _image;
}

- (UILabel *)version
{
    if (!_version) {
        _version = [UILabel new];
        _version.font = FONT(16);
    }
    return _version;
}


@end
