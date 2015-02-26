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
+ (CGRect)boundingRectForPointsInMat:(OpenCVMat *)points;

+ (NSInteger)countNonZeroForImage:(OpenCVMat *)src;

+ (void)cvtColorWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst code:(NSInteger)code dstCn:(NSInteger)dstCn;

+ (void)drawContours:(OpenCVMat *)image contours:(NSArray *)contours contourIdx:(NSInteger)contourIdx color:(NSArray *)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType hierarchy:(NSArray *)hierarchy maxLevel:(NSInteger)maxLevel offset:(CGPoint)offset;

+ (void)findContoursWithImage:(OpenCVMat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method offset:(CGPoint)offset;

+ (OpenCVMat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize anchor:(CGPoint)anchor;

+ (void)morphologyExWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst op:(NSInteger)op kernel:(OpenCVMat *)kernel anchor:(CGPoint)anchor iterations:(NSInteger)iterations borderType:(NSInteger)borderType borderValue:(NSArray *)borderValue;

+ (void)pyrDownWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst dstsize:(CGSize)size borderType:(NSInteger)borderType;

+ (void)rectangleInImage:(OpenCVMat *)img rec:(CGRect)rec color:(NSArray *)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType shift:(NSInteger)shift;

+ (CGFloat)thresholdWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst thresh:(CGFloat)thresh maxval:(CGFloat)maxval type:(NSInteger)type;
@end
