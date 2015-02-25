//
//  OpenCV+imgproc.h
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV.h"

@interface OpenCV (imgproc)
+ (CGRect)boundingRectForPoints:(NSArray *)points;
+ (CGRect)boundingRectForPointsInMat:(Mat *)points;

+ (void)cvtColorWithSrc:(Mat *)src dst:(Mat **)dst code:(NSInteger)code;
+ (void)cvtColorWithSrc:(Mat *)src dst:(Mat **)dst code:(NSInteger)code dstCn:(NSInteger)dstCn;

+ (void)findContoursWithImage:(Mat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method;
+ (void)findContoursWithImage:(Mat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method offset:(CGPoint)offset;

+ (Mat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize;
+ (Mat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize anchor:(CGPoint)anchor;

+ (void)morphologyExWithSrc:(Mat *)src dst:(Mat **)dst op:(NSInteger)op kernel:(Mat *)kernel;
+ (void)morphologyExWithSrc:(Mat *)src dst:(Mat **)dst op:(NSInteger)op kernel:(Mat *)kernel anchor:(CGPoint)anchor iterations:(NSInteger)iterations borderType:(NSInteger)borderType borderValue:(NSArray *)borderValue;

+ (void)pyrDownWithSrc:(Mat *)src dst:(Mat **)dst;
+ (void)pyrDownWithSrc:(Mat *)src dst:(Mat **)dst dstsize:(CGSize)size borderType:(NSInteger)borderType;

+ (CGFloat)thresholdWithSrc:(Mat *)src dst:(Mat **)dst thresh:(CGFloat)thresh maxval:(CGFloat)maxval type:(NSInteger)type;
@end
