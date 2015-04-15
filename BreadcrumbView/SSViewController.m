//
//  SSViewController.m
//  BreadcrumbView
//
//  Created by Sopan Shekhar Sharma on 31/12/13.
//  Copyright (c) 2013 Sopan. All rights reserved.
//

#import "SSViewController.h"


#define kSSAddButtonTitle @"Add Nodes"
#define kSSBreadcrumbTitleText @"Level"


@interface SSViewController ()

/*! @property HUBBreadcrumbView *breadcrumb
    @brief an object of HUBBreadcrumbView
 */
@property (nonatomic, strong) SSBreadCrumbView *breadcrumbView;

/*! @property UIButton *addButton
    @brief a button to add branches
 */
@property (nonatomic, strong) UIButton *addButton;

/*! @fn - (void)addBreadCrumbToTheView;
    @brief to add breadcrumb to the present view.
    @param iItem instance of SSBreadcrumbItem
 */
- (void)addBreadCrumbToTheView;

/*! @fn - (void)addNodes:(id)iSender;
    @brief to add nodes i.e to go a level deeper.
    @param iSender
 */
- (void)addNodes:(id)iSender;

/*! @fn - (void)setConstraintsForAddButton;
    @brief to set the add button's frame by using constraints.
 */
- (void)setConstraintsForAddButton;

@end


@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:225.0f/255.0f green:225.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
    [self addBreadCrumbToTheView];
    [self.view addSubview:self.breadcrumbView];
    
    self.addButton = [[UIButton alloc] init];
    [self.addButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.addButton setTitle:kSSAddButtonTitle forState:UIControlStateNormal];
    [self.addButton setBackgroundColor:[UIColor clearColor]];
    [self.addButton setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:91.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addNodes:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.addButton];
    
    [self setConstraintsForAddButton];
}

#pragma mark - User defined Methods

- (void)addBreadCrumbToTheView {
    
     __weak SSViewController *aBlockSelf = self;
    self.breadcrumbView = [[SSBreadCrumbView alloc] initWithFrame:CGRectMake(10.0f, 55.0f, 0.0f, 0.0f)];
    
    self.breadcrumbView.delegate = self;
    [self.breadcrumbView setAlpha:0.0f];
    [self.breadcrumbView sizeToFit];
    
    [UIView animateWithDuration:0.6f animations:^{
        
        [aBlockSelf.breadcrumbView setAlpha:1.0f];
    }];
}


- (void)addNodes:(id)iSender {
    
    if (self.breadcrumbView && [self.breadcrumbView.itemViews count] <= 2) {
        
        SSBreadcrumbItem *anItem = [self.breadcrumbView breadCrumbItem:[NSString stringWithFormat:@"%@ %d", kSSBreadcrumbTitleText, [self.breadcrumbView.itemViews count] + 1]];
        [self.breadcrumbView setItems:@[anItem] animated:YES];
    }
}


- (void)setConstraintsForAddButton {
    
    NSLayoutConstraint *theVerticalConstraintForAddButton = [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual                          toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    NSLayoutConstraint *theHorizontalConstraintForAddButton =[NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
        toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [self.view addConstraint:theVerticalConstraintForAddButton];
    [self.view addConstraint:theHorizontalConstraintForAddButton];
    [self.view layoutSubviews];
}


#pragma mark - Breadcrumb View Delegate Methods

- (void)breadcrumbViewDidTapStartButton:(SSBreadCrumbView *)iView {
    
    NSLog(@"The view is :- %@", iView);
}


- (void)breadcrumbView:(SSBreadCrumbView *)iView didSelectItemAtIndex:(NSUInteger)iIndex {
    
    NSLog(@"The view is :- %@ \n Index:- %d", iView, iIndex);
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
