//
//  HeaderView.h
//  HeadDemo
//
//  Created by yr on 2019/5/10.
//  Copyright © 2019 yr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *bottomLab;

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIButton *focusBtn;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIImageView *sexImg;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UIButton *postBtn;
@property (nonatomic,strong) UIButton *zanBtn;
@property (nonatomic,strong) UIButton *fanBtn;
@property (nonatomic,strong) UIButton *attentionBtn;

@property (nonatomic,strong) UIImageView *tagImg;
@property (nonatomic,strong) UILabel *tagLab;

@property (nonatomic,strong) NSString *nameStr;

- (void)updateLayoutAtOffset:(CGPoint)offset;

@end

NS_ASSUME_NONNULL_END
