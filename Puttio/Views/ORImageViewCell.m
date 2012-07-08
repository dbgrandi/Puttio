//
//  ORImageViewCell.m
//  Puttio
//
//  Created by orta therox on 27/03/2012.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

#import "ORImageViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+ImageRect.h"

static UIEdgeInsets ImageContentInsets = {.top = 10, .left = 6, .right = 6, .bottom = 35};

static CGFloat TitleLabelHeight = 44;
static CGFloat ImageBottomMargin = 10;

@interface ORImageViewCell (){
    UIImage *image;
    UIImageView *watchedSash;
}

@end

@implementation ORImageViewCell

+ (CGFloat) cellHeight { return 140; }
+ (CGFloat) cellWidth { return 160; }

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIColor *black = [UIColor blackColor];
                
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.opaque = YES;
        
        CGRect imageFrame = frame;
        imageFrame.size.width = CGRectGetWidth(self.frame) - ImageContentInsets.left - ImageContentInsets.right;
        imageFrame.size.height = CGRectGetHeight(self.frame) - ImageContentInsets.bottom - ImageContentInsets.top;
        
        imageFrame.origin.x = ImageContentInsets.left;
        imageFrame.origin.y = ImageContentInsets.top;
        imageView.frame = imageFrame;  
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = black;
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.opaque = NO;
        titleLabel.userInteractionEnabled = YES;
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)prepareForReuse {
    titleLabel.text = @"";
    self.image = nil;

    self.watched = NO;
    [watchedSash removeFromSuperview];
    watchedSash = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([_title length]) {
        titleLabel.frame = CGRectMake(ImageContentInsets.left, 
                                      CGRectGetMaxY(imageView.frame) + ImageBottomMargin, 
                                      CGRectGetWidth(self.bounds) - ImageContentInsets.left - ImageContentInsets.right, 
                                      TitleLabelHeight);        
    }
    else {
        titleLabel.frame = CGRectMake(ImageContentInsets.left, 
                                      CGRectGetMaxY(imageView.frame) + ImageBottomMargin, 
                                      CGRectGetWidth(self.bounds) - ImageContentInsets.left - ImageContentInsets.right, 
                                      0);
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    titleLabel.text = title;
}

- (void)setImageURL:(NSURL *)anImageURL {
    _imageURL = anImageURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:anImageURL];

    __weak ORImageViewCell *this = self;
    [imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"Placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

        __strong ORImageViewCell *strongSelf = this;
        if([strongSelf watched]){
            [strongSelf addWatchedEffects];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

- (void)setImage:(UIImage *)anImage {
    _image = anImage;
    [imageView setImage:anImage];
}

- (void) addWatchedEffects {
    bool isRetina = [[UIScreen mainScreen] scale] > 1;
    CGRect imageRect = [imageView frameForImage];
    
    watchedSash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WatchedSash"]];
    imageRect.size.width = CGRectGetWidth(watchedSash.frame);
    imageRect.size.height = CGRectGetHeight(watchedSash.frame);
    imageRect.origin.x -= isRetina? 1 : 2;
    imageRect.origin.y -= isRetina? 1 : 2;;
    watchedSash.frame = imageRect;
    [imageView addSubview:watchedSash];
}
@end
