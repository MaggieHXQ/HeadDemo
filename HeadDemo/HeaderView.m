//
//  HeaderView.m
//  HeadDemo
//
//  Created by yr on 2019/5/10.
//  Copyright © 2019 yr. All rights reserved.
//

#import "HeaderView.h"
#import "SDAutoLayout.h"
#import "SystemEnum.h"

#define TabHeadHeight 335
#define MovedHeadHeight 119

@interface HeaderView ()

@end

@implementation HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubview];
    }
    return self;
}
- (void)setSubview
{
    [self sd_addSubviews:@[self.imageView,self.headImg,self.focusBtn,self.nameLab,self.sexImg,self.detailLab,self.postBtn,self.zanBtn,self.fanBtn,self.attentionBtn,self.bottomLab]];
    [self.bottomLab sd_addSubviews:@[self.tagImg,self.tagLab]];
    
    self.imageView.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self);
    self.postBtn.sd_layout.leftSpaceToView(self, 24).bottomSpaceToView(self, 90);
    [self.postBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    self.zanBtn.sd_layout.leftSpaceToView(self.postBtn, -6).bottomEqualToView(self.postBtn);
    [self.zanBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    self.fanBtn.sd_layout.leftSpaceToView(self.zanBtn, -6).bottomEqualToView(self.postBtn);
    [self.fanBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    self.attentionBtn.sd_layout.leftSpaceToView(self.fanBtn, -6).bottomEqualToView(self.postBtn);
    [self.attentionBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    
    self.tagImg.sd_layout.heightIs(10).widthIs(10).leftSpaceToView(self.bottomLab, 24).bottomSpaceToView(self.bottomLab, 13);
    self.tagLab.sd_layout.heightIs(15).leftSpaceToView(self.tagImg, 5).centerYEqualToView(self.tagImg).rightSpaceToView(self.bottomLab, 24);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomLab.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bottomLab.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bottomLab.layer.mask = maskLayer;
    
}
- (void)updateLayoutAtOffset:(CGPoint)offset
{
    if (offset.y <= 0.0f)
    {
        float height = (TabHeadHeight-MovedHeadHeight)+offset.y;
        
//        NSLog(@"height = %f",height);
        
        CGFloat scale = 1.0;
        CGFloat focus_x_scale = 1.0;
        CGFloat focus_y_scale = 1.0;
        if (height <= 0.0f) {
            //底部视图动画
            CGRect frame = self.bottomLab.frame;
            frame.origin.y = CGRectGetHeight(self.frame)-55;
            self.bottomLab.frame = frame;
            
            //头像动画
            if (height < 0) {
                scale = MIN(1, 1-height/300);
            }else{
                scale = 1;
            }
            CGRect frame1 = self.headImg.frame;
            frame1.origin.y = -height+79;
            frame1.origin.x = 20;
            self.headImg.frame = frame1;
            
            //关注按钮动画
            self.focusBtn.transform = CGAffineTransformMakeScale(scale, scale);
            CGRect frame2 = self.focusBtn.frame;
            frame2.origin.y = -height+88;
            self.focusBtn.frame = frame2;
            
            //昵称动画
//            self.nameLab.transform = CGAffineTransformMakeScale(scale, scale);
            self.nameLab.font = [UIFont systemFontOfSize:19];
            CGRect frame3 = self.nameLab.frame;
            frame3.origin.x = 23;
            frame3.origin.y = CGRectGetMaxY(self.headImg.frame)+13;
            self.nameLab.frame = frame3;
            
            //其它动画
            CGRect frame4 = self.sexImg.frame;
            frame4.origin.y = CGRectGetMidY(self.nameLab.frame)-7.5;
            self.sexImg.frame = frame4;
            
            CGRect frame5 = self.detailLab.frame;
            frame5.origin.y = CGRectGetMaxY(self.headImg.frame)+41;
            self.detailLab.frame = frame5;
            
        } else {
            //底部视图动画
            CGRect frame = self.bottomLab.frame;
            frame.origin.y = CGRectGetHeight(self.frame)-height-55;
            self.bottomLab.frame = frame;
            
            //头像动画
            scale = MAX((CGFloat)32/76, 1-height/300);
            CGRect frame1 = self.headImg.frame;
            frame1.origin.y = 79-(CGFloat)height/216*53;
            frame1.origin.x = 20+(CGFloat)height/216*34;
            self.headImg.frame = frame1;
            
            //关注按钮动画
            focus_x_scale = MAX((CGFloat)55/65, 1-height/300);
            focus_y_scale = MAX((CGFloat)24/32, 1-height/300);
            self.focusBtn.transform = CGAffineTransformMakeScale(focus_x_scale, focus_y_scale);
            CGRect frame2 = self.focusBtn.frame;
            frame2.origin.y = 88-(CGFloat)height/216*58;
            frame2.origin.x = KSWidth-55-20-(CGFloat)height/216*42;
            self.focusBtn.frame = frame2;
            
            //昵称动画
            self.nameLab.font = [UIFont systemFontOfSize:(19-(CGFloat)height/216*5)];
            CGRect frame3 = self.nameLab.frame;
            frame3.origin.y = 168-(CGFloat)height/216*133;
            frame3.origin.x = 23+(CGFloat)height/216*68;
            self.nameLab.frame = frame3;
            
            //其他
            self.sexImg.alpha = 1-(CGFloat)height/216;

        }
        self.headImg.transform = CGAffineTransformMakeScale(scale, scale);
        
    } else {
        //底部视图动画
        CGRect frame = self.bottomLab.frame;
        frame.origin.y = MovedHeadHeight-55;
        self.bottomLab.frame = frame;
        
        //头像动画
        self.headImg.transform = CGAffineTransformMakeScale((CGFloat)32/76, (CGFloat)32/76);
        CGRect frame1 = self.headImg.frame;
        frame1.origin.y = 26;
        frame1.origin.x = 54;
        self.headImg.frame = frame1;
        
        //关注按钮动画
        self.focusBtn.transform = CGAffineTransformMakeScale((CGFloat)55/65, (CGFloat)24/32);
        CGRect frame2 = self.focusBtn.frame;
        frame2.origin.y = 30;
        frame2.origin.x = KSWidth-55-62;
        self.focusBtn.frame = frame2;
        
        //昵称动画
        self.nameLab.font = [UIFont systemFontOfSize:14];
        CGRect frame3 = self.nameLab.frame;
        frame3.origin.y = 35;
        frame3.origin.x = CGRectGetMaxX(self.headImg.frame)+6;
        self.nameLab.frame = frame3;
    }
}
//
- (void)setNameStr:(NSString *)nameStr
{
    //
    _nameLab.text = nameStr;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:19],};
    CGSize textSize = [_nameLab.text boundingRectWithSize:CGSizeMake(300, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;;
    
    [_nameLab setFrame:CGRectMake(23, CGRectGetMaxY(self.headImg.frame)+13, textSize.width, 18)];
    [_sexImg setFrame:CGRectMake(CGRectGetMaxX(self.nameLab.frame)+6, CGRectGetMidY(self.nameLab.frame)-7.5, 20, 15)];
    
    //
    NSString *postStr = [NSString stringWithFormat:@"%@ 发布",@"20"];
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(0xffffff, 1) range:NSMakeRange(0, postStr.length)];
    [attrDescribeStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size: 10] range:[postStr rangeOfString:@"发布"]];
    [_postBtn setAttributedTitle:attrDescribeStr forState:UIControlStateNormal];
    
    NSString *zanStr = [NSString stringWithFormat:@"%@ 获赞",@"136"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:zanStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(0xffffff, 1) range:NSMakeRange(0, zanStr.length)];
    [attrStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size: 10] range:[zanStr rangeOfString:@"获赞"]];
    [_zanBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    NSString *fanStr = [NSString stringWithFormat:@"%@ 粉丝",@"96"];
    NSMutableAttributedString *attrStrFan = [[NSMutableAttributedString alloc] initWithString:fanStr];
    [attrStrFan addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(0xffffff, 1) range:NSMakeRange(0, fanStr.length)];
    [attrStrFan addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size: 10] range:[fanStr rangeOfString:@"粉丝"]];
    [_fanBtn setAttributedTitle:attrStrFan forState:UIControlStateNormal];
    
    NSString *attentionStr = [NSString stringWithFormat:@"%@ 关注",@"88"];
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:attentionStr];
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(0xffffff, 1) range:NSMakeRange(0, attentionStr.length)];
    [attrStr1 addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size: 10] range:[attentionStr rangeOfString:@"关注"]];
    [_attentionBtn setAttributedTitle:attrStr1 forState:UIControlStateNormal];
    

}
#pragma mark -------
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"组 4"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
- (UIView *)bottomLab
{
    if (!_bottomLab) {
        _bottomLab = [[UIView alloc]initWithFrame:CGRectMake(0, TabHeadHeight-55, KSWidth, 55)];
        _bottomLab.backgroundColor = UIColorFromRGBA(0xffffff, 1);
    }
    return _bottomLab;
}
- (UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 79, 76, 76)];
        _headImg.backgroundColor = [UIColor orangeColor];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 38;
        
    }
    return _headImg;
}
- (UIButton *)focusBtn
{
    if (!_focusBtn) {
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _focusBtn.frame = CGRectMake(KSWidth-65-20, 88, 65, 32);
        [_focusBtn setImage:[UIImage imageNamed:@"mine_btn_follow"] forState:UIControlStateNormal];
        _focusBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _focusBtn;
}
- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = UIColorFromRGBA(0xffffff, 1);
        _nameLab.font = [UIFont systemFontOfSize:19];
    }
    return _nameLab;
}
- (UIImageView *)sexImg
{
    if (!_sexImg) {
        _sexImg = [[UIImageView alloc]init];
        _sexImg.image = [UIImage imageNamed:@"mine_icon_girl"];
    }
    return _sexImg;
}
- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(self.headImg.frame)+41, KSWidth-46, 13)];
        _detailLab.text = @"他注定是个低调的逗粉 所以啥都没写";
        _detailLab.textColor = UIColorFromRGBA(0xffffff, 1);
        _detailLab.font = [UIFont systemFontOfSize:13];
    }
    return _detailLab;
}
- (UIButton *)postBtn
{
    if (!_postBtn) {
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _postBtn;
}
- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _zanBtn;
}
- (UIButton *)fanBtn
{
    if (!_fanBtn) {
        _fanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _fanBtn;
}
- (UIButton *)attentionBtn
{
    if (!_attentionBtn) {
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _attentionBtn;
}
- (UIImageView *)tagImg
{
    if (!_tagImg) {
        _tagImg = [[UIImageView alloc]init];
        _tagImg.backgroundColor = UIColorFromRGBA(0xFFCE26, 1);
    }
    return _tagImg;
}
- (UILabel *)tagLab
{
    if (!_tagLab) {
        _tagLab = [[UILabel alloc]init];
        _tagLab.textColor = UIColorFromRGBA(0x333333, 1);
        _tagLab.font = [UIFont systemFontOfSize:15];
        _tagLab.text = @"逗闻趣事 16";
    }
    return _tagLab;
}

@end
