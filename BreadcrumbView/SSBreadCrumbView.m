//
//  SSBreadCrumbView.m
//  BreadcrumbView
//
//  Created by Sopan Shekhar Sharma on 31/12/13.
//  Copyright (c) 2013 Sopan. All rights reserved.
//

/*! @file HUBBreadcrumbView.m
    Implements a view to display breadcrumb design for various items.
 */

#import "SSBreadCrumbView.h"
#import "SSBreadCrumbSubPartView.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.5
#define kShadowOpacity   0.3
#define kShadowOffset    CGSizeMake(1, 1)
#define kShadowRadius    1.0
#define kShadowColor     [UIColor blackColor].CGColor
#define kStartButtonWidth 50
#define kBreadcrumbHeight 23

#define mSSSetShadow(_view) \
CALayer *aLayer = [_view layer]; \
aLayer.shadowOffset = kShadowOffset; \
aLayer.shadowOpacity = kShadowOpacity; \
aLayer.shadowRadius = kShadowRadius; \
aLayer.shadowColor = kShadowColor

#define mRGBA(_red,_green,_blue,_alpha) \
[UIColor colorWithRed:(_red/255.0) green:(_green/255.0) blue:(_blue/255.0) alpha:_alpha]

#define mRect(_w,_h) CGRectMake(0,0,_w,_h)
#define kSSSpaceForTruncatedString @"..."
#define kSSStartElementTitle @"Home"


@implementation SSBreadcrumbItem

@end


@interface SSBreadCrumbView ()

/*! @property UIView *containerView
    @brief main view holding the child views.
 */
@property (nonatomic, strong) UIView *containerView;

/*! @property UIButton *startButton
    @brief representing the start button.
 */
@property (nonatomic, strong) UIButton *startButton;

/*! @property BOOL animating
    @brief bool for checking the animation.
 */
@property (nonatomic) BOOL animating;

/*! @fn - (void)tapStartButton:(id)iSender;
    @brief  called when the start button is pressed.
    @param iSender
 */
- (void)tapStartButton:(id)iSender;

/*! @fn - (void)tapItemButton:(id)iSender;
    @brief called when an item is pressed.
    @param iSender
 */
- (void)tapItemButton:(id)iSender;

/*! @fn - (CGSize)sizeThatFits:(CGSize)iSize;
    @brief return the size that best fits its subviews.
    @param iSize the current size of receiver
 */
- (CGSize)sizeThatFits:(CGSize)iSize;

/*! @fn - (UIButton *)startButtonWithPortlet:(NSString *)iString;
    @brief create a start button with a specific string name.
    @param iString string name
 */
- (UIButton *)startButtonWithName:(NSString *)iString;

/*! @fn - (UIButton *)itemButton:(SSBreadcrumbItem *)iItem;
    @brief initialize an item button.
    @param iItem instance of SSBreadcrumbItem
 */
- (UIButton *)itemButton:(SSBreadcrumbItem *)iItem;

/*! @fn - (void)layoutSubviews;
    @brief to determine size of the view.
 */
- (void)layoutSubviews;

@end


@implementation SSBreadCrumbView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.autoresizesSubviews = YES;
        
        self.containerView = [[UIView alloc] initWithFrame:self.bounds];
        self.containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.containerView.backgroundColor = [UIColor clearColor];
        self.containerView.clipsToBounds = YES;
        [self addSubview:self.containerView];
        
        self.itemsArray = [NSMutableArray array];
        
        // Create fixed subviews
        self.startButton = [self startButtonWithName:kSSStartElementTitle];
        [self.containerView addSubview:self.startButton];
        
        self.itemViews = [[NSMutableArray alloc] init];
        self.itemList = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (CGSize)sizeThatFits:(CGSize)iSize {
    
    CGFloat theTotalWidth = self.startButton.frame.size.width;
    
    for (UIView *anItemView in self.itemViews) {
        
        theTotalWidth += anItemView.bounds.size.width;
    }
    
    if (self.itemViews.count > 0) {
        
        UIButton *aLastButton = [self.itemViews lastObject];
        
        if (aLastButton.titleEdgeInsets.right > 10.0f) {
            
            theTotalWidth -= 20.0f;
        }
    }
    
    return CGSizeMake(theTotalWidth, kBreadcrumbHeight);
}


- (UIButton *)startButtonWithName:(NSString *)iString {
    
    self.startBreadcrumbView = [[SSBreadCrumbStartView alloc] init];
    self.startBreadcrumbView.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.startBreadcrumbView.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (iString.length >= 16) {
        
        iString = [iString substringToIndex:13];
        iString = [iString stringByAppendingString:kSSSpaceForTruncatedString];
    }
    
    CGRect theStringFrame = [iString boundingRectWithSize:CGSizeMake(1000.0f, 10000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]} context:nil];
    [self.startBreadcrumbView setTitle:iString forState:UIControlStateNormal];
    
    /*------------------ Change the text color based on the color of the block if using it ------------------------------*/
    
    [self.startBreadcrumbView setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    if ([iString length] > 2) {
        
        self.startBreadcrumbView.frame = CGRectMake(-2.0f, 0.0f, theStringFrame.size.width + 20.0f, kBreadcrumbHeight);
    } else {
        
        self.startBreadcrumbView.frame = CGRectMake(-2.0f, 0.0f, theStringFrame.size.width, kBreadcrumbHeight);
    }
    
    self.startBreadcrumbView.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.startBreadcrumbView.titleEdgeInsets = UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, 0.0f);
    [self.startBreadcrumbView addTarget:self action:@selector(tapStartButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return self.startBreadcrumbView;
}


- (UIButton *)itemButton:(SSBreadcrumbItem *)iItem {
    
    SSBreadCrumbSubPartView *theComponent = [[SSBreadCrumbSubPartView alloc] init];
    theComponent.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    theComponent.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    if (iItem.title.length >= 16) {
        
        iItem.title = [iItem.title substringToIndex:13];
        iItem.title = [iItem.title stringByAppendingString:kSSSpaceForTruncatedString];
    }
    
    CGRect theStringFrame = [iItem.title boundingRectWithSize:CGSizeMake(1000.0f, 10000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]} context:nil];
    [theComponent setTitle:iItem.title forState:UIControlStateNormal];
    
    /*------------------ Change the text color based on the color of the block if using it ------------------------------*/
    
    [theComponent setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    theComponent.frame = CGRectMake(4.0f, 0.0f, theStringFrame.size.width + 40.0f, kBreadcrumbHeight);
    theComponent.titleLabel.textAlignment = NSTextAlignmentRight;
    theComponent.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 5.0f);
    [theComponent addTarget:self action:@selector(tapItemButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return theComponent;
}


- (void)tapStartButton:(id)iSender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(breadcrumbViewDidTapStartButton:)]) {
        
        [self.delegate breadcrumbViewDidTapStartButton:iSender];
    }
    
    [self bringBreadCrumbToInitialStage];
}


- (void)bringBreadCrumbToInitialStage {
    
    if (self.itemViews && [self.itemViews count] != 0) {
        
        [self.itemsArray removeAllObjects];
        
        if (self.itemList && [self.itemList count] > 0) {
            
            [self.itemList removeAllObjects];
        }
        
        [self removeItems:nil animated:YES];
    }
}


- (SSBreadcrumbItem *)breadCrumbItem:(NSString *)iTitle {
    
    SSBreadcrumbItem *anItem = [[SSBreadcrumbItem alloc] init];
    anItem.title = iTitle;
    return anItem;
}


- (void)tapItemButton:(id)iSender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(breadcrumbView:didSelectItemAtIndex:)]) {
        
        [self.delegate breadcrumbView:iSender didSelectItemAtIndex:[self.itemViews indexOfObject:iSender]];
    }
    
    /*------------- To remove the nodes present ahead of the tapped one -------------------*/
    
    UIView *aView = [self.itemViews lastObject];
    
    if (aView != iSender) {
        
        int theIndexOfTheSelectedBreadCrumb = [self.itemViews indexOfObject:iSender] + 1;
        int theLastItemIndex = [self.itemViews count];
        int theRange = theLastItemIndex - theIndexOfTheSelectedBreadCrumb;
        
        NSArray *anArray = [self.itemViews subarrayWithRange:NSMakeRange(theIndexOfTheSelectedBreadCrumb, theRange)];
        
        if (self.itemList && [self.itemList count] > 0) {
            
            [self.itemList removeObjectsInRange:NSMakeRange(theIndexOfTheSelectedBreadCrumb, [self.itemList count] - theIndexOfTheSelectedBreadCrumb)];
        }
        
        [self removeItems:anArray animated:YES];
    }
}


#pragma mark Layout

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat theWidthOfTheStartButton = self.startButton.frame.size.width - 16.0f;
    
    for (UIView *aView in self.itemViews) {
        
        CGSize theViewSize = aView.bounds.size;
        aView.frame = CGRectMake(theWidthOfTheStartButton, 0.0f, theViewSize.width, theViewSize.height);
        theWidthOfTheStartButton += theViewSize.width - 18.0f;
    }
}


#pragma mark Public

- (void)setItems:(NSArray *)iBreadCrumbList animated:(BOOL)iAnimated {
    
    if (iAnimated) {
        
        SSBreadcrumbItem *anItem = iBreadCrumbList[0];
        [self.itemList addObject:anItem];
        UIView *aNewView = [self itemButton:anItem];
        CGSize theViewSize = aNewView.bounds.size;
        aNewView.frame = CGRectMake(self.bounds.size.width - theViewSize.width, 0.0f, theViewSize.width, theViewSize.height);
        [self.containerView insertSubview:aNewView atIndex:0];
        
        if (!self.itemViews) {
            
            self.itemViews = [NSMutableArray array];
        }
        
        [self.itemViews addObject:aNewView];
        
        __weak SSBreadCrumbView *aBlockSelf = self;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [aBlockSelf sizeToFit];
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [aBlockSelf sizeToFit];
                [aBlockSelf layoutSubviews];
            } completion:nil];
        }];
    }
}


- (void)removeItems:(NSArray *)iBreadCrumbList animated:(BOOL)iAnimated {
    
    [self sizeToFit];
    
    if (!iBreadCrumbList) {
        
        for (id anElement in self.itemViews) {
            
            UIButton *button = (UIButton *)anElement;
            [UIView transitionWithView:button
                              duration:0.5
                               options:UIViewAnimationOptionCurveLinear
                            animations:^ {
                                
                                [button setAlpha:0.0];
                            } completion:^(BOOL finished) {
                                
                                [button removeFromSuperview];
                            }];
        }
        
        [self.itemViews removeAllObjects];
    } else {
        
        if (iBreadCrumbList && self.itemViews && [iBreadCrumbList count] <= [self.itemViews count]) {
            
            for (id anElement in iBreadCrumbList){
                
                UIButton *button = (UIButton *)anElement;
                [UIView transitionWithView:button
                                  duration:0.5
                                   options:UIViewAnimationOptionCurveLinear
                                animations:^ {
                                    
                                    [button setAlpha:0.0];
                                } completion:^(BOOL finished) {
                                    
                                    [button removeFromSuperview];
                                }];
                
                [self.itemViews removeObject:anElement];
            }
        }
    }
    
    __weak SSBreadCrumbView *aBlockSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [aBlockSelf sizeToFit];
        [aBlockSelf layoutSubviews];
    } completion:nil];
}

@end
