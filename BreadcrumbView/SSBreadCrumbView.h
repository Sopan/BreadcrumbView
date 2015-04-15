//
//  SSBreadCrumbView.h
//  BreadcrumbView
//
//  Created by Sopan Shekhar Sharma on 31/12/13.
//  Copyright (c) 2013 Sopan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSBreadCrumbStartView.h"

@class SSBreadCrumbView;

@protocol SSBreadcrumbViewDelegate <NSObject>

@optional

/*! @fn - (void)breadcrumbViewDidTapStartButton:(HUBBreadcrumbView *)iView;
    @brief called when the start button is pressed.
    @param iView an object of HUBBreadcrumbView
 */
- (void)breadcrumbViewDidTapStartButton:(SSBreadCrumbView *)iView;

/*! @fn - (void)breadcrumbView:(HUBBreadcrumbView *)view didTapItemAtIndex:(NSUInteger)iIndex;
    @brief  called when a button at any index is pressed.
    @param iIndex index of the button pressed.
 */
- (void)breadcrumbView:(SSBreadCrumbView *)iView didSelectItemAtIndex:(NSUInteger)iIndex;

@end


/*! @class SSBreadcrumbItem
    @brief a customized item to be used in the bread crumb.
 */


@interface SSBreadcrumbItem : NSObject

/*! @property NSString *title
    @brief title for the string.
 */
@property (nonatomic, strong) NSString *title;

@end


/*! @class SSBreadCrumbView
    @brief Implements methods for displaying breadcrumb
 */


@interface SSBreadCrumbView : UIView

/*! @property id<HUBBreadcrumbViewDelegate> delegate
 @brief instance of the delegate.
 */
@property (nonatomic, assign) id<SSBreadcrumbViewDelegate> delegate;

/*! @property NSMutableArray *itemsArray
 @brief items array.
 */
@property (nonatomic, strong) NSMutableArray *itemsArray;

/*! @property NSMutableArray *itemList
 @brief array containing HUBBreadcrumbItem to be shown.
 */
@property (nonatomic) NSMutableArray *itemList;

/*! @property NSMutableArray *itemViews
 @brief array containing the item views.
 */
@property (nonatomic, strong) NSMutableArray *itemViews;

/*! @property HUBBreadCrumbStartingView *startBreadcrumbView
    @brief an object of HUBBreadCrumbStartingView
 */
@property (nonatomic, strong) SSBreadCrumbStartView *startBreadcrumbView;

/*! @fn - (void)setItems:(NSArray *)iItems animated:(BOOL)iAnimated;
    @brief  add breadCrumbItems to the array.
    @param iItems list of the items to be added.
    @param iAnimated bool stating whether to animate or not.
 */
- (void)setItems:(NSArray *)iItems animated:(BOOL)iAnimated;

/*! @fn - (void)removeItems:(NSArray *)iBreadCrumbList animated:(BOOL)iAnimated;
    @brief  remove breadCrumbItems to the array.
    @param iItems list of the items to be added.
    @param iAnimated bool stating whether to animate or not.
 */
- (void)removeItems:(NSArray *)iBreadCrumbList animated:(BOOL)iAnimated;

/*! @fn - (HUBBreadcrumbItem *)breadCrumbItem:(NSString *)iTitle;
    @brief  create breadcrumb item for a particular title.
    @param iTitle title for which the item to be added.
    @return instance of breadCrumb type
 */
- (SSBreadcrumbItem *)breadCrumbItem:(NSString *)iTitle;

/*! @fn - (void)bringBreadCrumbToInitialStage;
    @brief  to bring breadcrumb to the initial stages.
 */
- (void)bringBreadCrumbToInitialStage;

@end
