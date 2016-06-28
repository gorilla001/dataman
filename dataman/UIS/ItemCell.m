
#import "ItemCell.h"
#import <UIImageView+AFNetworking.h>

#define IMAGE_URL "http://devstatic.dataman-inc.net/app_catalog_icons"

@interface ItemCell ()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UIView *image;
@end

@implementation ItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WHITE_COLOR;
        self.clipsToBounds = YES;
        
        [self addSubview:self.name];
        [self addSubview:self.status];
        [self addSubview:self.image];
    }
    return self;
}


- (void)configItemCell:data
{
    self.name.text = data[@"name"];
    switch ([data[@"status"] integerValue]) {
        case 1:
            self.status.text = @"部署中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        case 2:
            self.status.text = @"运行中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 102);
            break;
        case 3:
            self.status.text = @"已停止";
            self.image.backgroundColor = RGB_COLOR(136, 136, 136);
            break;
        case 4:
            self.status.text = @"停止中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        case 5:
            self.status.text = @"删除中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        case 6:
            self.status.text = @"扩张中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        case 7:
            self.status.text = @"启动中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        case 8:
            self.status.text = @"撤销中";
            self.image.backgroundColor = RGB_COLOR(0, 204, 255);
            break;
        
            
        default:
            break;
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.name.frame = CGRectMake(10, 0, self.width/2, 60);
    self.status.frame = CGRectMake(self.right-120, 0, 60, 60);
    self.image.frame = CGRectMake(self.status.right+20, 22.5, 15, 15);
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.font = FONT(16);
        _name.textColor = RGB_COLOR(119, 119, 119);
    }
    return _name;
}

- (UILabel *)status
{
    if (!_status) {
        _status = [UILabel new];
        _status.font = FONT(16);
        _status.textColor = RGB_COLOR(119, 119, 119);
    }
    return _status;
}

- (UIView *) image
{
    if (!_image){
        _image =  [[UIView alloc] initWithFrame:CGRectZero];
        _image.layer.cornerRadius = 7.5;
        _image.layer.masksToBounds = YES;
    }
    
    return _image;
}

@end
