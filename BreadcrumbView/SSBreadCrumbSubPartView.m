//
//  SSBreadCrumbSubPartView.m
//  BreadcrumbView
//
//  Created by Sopan Shekhar Sharma on 31/12/13.
//  Copyright (c) 2013 Sopan. All rights reserved.
//


/*! @file HUBBreadCrumbSubPartView.m
    Method to draw subparts view for breadcrumb.
 */


#import "SSBreadCrumbSubPartView.h"

@implementation SSBreadCrumbSubPartView


- (id)initWithFrame:(CGRect)iFrame {
    
    self = [super initWithFrame:iFrame];
    
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)drawRect:(CGRect)iRect {
    // Drawing code to create a breadcrumb sub part item button
    
    /*----------- Use this code for plain view ----------------*/
    CGContextRef aContext =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(aContext, 2.0f);
    
    CGContextSetStrokeColorWithColor(aContext, [[UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] CGColor]);
    CGContextMoveToPoint(aContext, self.bounds.size.width - 10.0f, self.bounds.origin.y);
    CGContextAddLineToPoint(aContext, self.bounds.size.width - 1.0f, self.bounds.size.height / 2.0f);
    CGContextAddLineToPoint(aContext, self.bounds.size.width - 10.0f, self.bounds.size.height);
    CGContextStrokePath(aContext);

    
     /*----------- Use this code for creating block view ----------------*/
    
    /*
    CGContextRef aContext =  UIGraphicsGetCurrentContext();
    CGContextBeginPath(aContext);
    CGContextSetRGBFillColor(aContext, 102.0f/255.0f, 102.0f/255.0f, 102.0f/255.0f, 1.0f);
    CGContextMoveToPoint(aContext, self.bounds.origin.x, self.bounds.origin.y);
    CGContextAddLineToPoint(aContext, 14.0f, self.bounds.size.height / 2.0f);
    CGContextAddLineToPoint(aContext, self.bounds.origin.x, self.bounds.size.height);
    CGContextAddLineToPoint(aContext, 14.0f, self.bounds.size.height);
    CGContextAddLineToPoint(aContext, 14.0f, self.bounds.origin.y);
    CGContextAddLineToPoint(aContext, self.bounds.origin.x, self.bounds.origin.y);
    CGContextFillPath(aContext);
    CGContextClosePath(aContext);
    
    CGContextBeginPath(aContext);
    CGContextSetRGBFillColor(aContext, 102.0/255.0, 102.0/255.0, 102.0/255.0, 1.0);
    CGContextAddRect(aContext, CGRectMake(self.bounds.origin.x + 14.0f, self.bounds.origin.y, self.bounds.size.width - 28.0, self.bounds.size.height));
    CGContextFillPath(aContext);
    CGContextClosePath(aContext);
    
    CGContextBeginPath(aContext);
    CGContextSetRGBFillColor(aContext, 102.0/255.0, 102.0/255.0, 102.0/255.0, 1.0);
    CGContextMoveToPoint(aContext, self.bounds.size.width - 15.0, self.bounds.origin.y);
    CGContextAddLineToPoint(aContext, self.bounds.size.width , self.bounds.size.height / 2.0f);
    CGContextAddLineToPoint(aContext, self.bounds.size.width - 15.0, self.bounds.size.height);
    CGContextFillPath(aContext);
    CGContextClosePath(aContext);
    
    CGContextBeginPath(aContext);
    CGContextSetLineWidth(aContext, 2.0f);
    
    CGContextSetStrokeColorWithColor(aContext, [UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0].CGColor);
    CGContextMoveToPoint(aContext, self.bounds.size.width - 14.0, self.bounds.origin.y);
    CGContextAddLineToPoint(aContext, self.bounds.size.width - 1.0f, self.bounds.size.height / 2.0f);
    CGContextAddLineToPoint(aContext, self.bounds.size.width - 14.0, self.bounds.size.height);
    CGContextStrokePath(aContext);
    CGContextClosePath(aContext);
     */
}

@end
