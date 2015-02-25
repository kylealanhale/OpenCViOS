//
//  OpenCV+imgproc.mm
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV+raw.h"
#import "OpenCV+imgproc.h"

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>

@implementation OpenCV (imgproc)
+ (CGRect)boundingRectForPoints:(NSArray *)points
{
    std::vector<cv::Point> rawPoints = [OpenCV toPointVector:points];
    
    return [OpenCV fromRect:cv::boundingRect(rawPoints)];
}
+ (CGRect)boundingRectForPointsInMat:(Mat *)points
{
    return [OpenCV fromRect:cv::boundingRect(points.rawMat)];
}

+ (void)cvtColorWithSrc:(Mat *)src dst:(Mat **)dst code:(NSInteger)code dstCn:(NSInteger)dstCn
{
    cv::Mat rawDst;
    
    cv::cvtColor(src.rawMat, rawDst, (int)code, (int)dstCn);
    
    *dst = [[Mat alloc] initWithRawMat:rawDst];
}

+ (void)findContoursWithImage:(Mat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method offset:(CGPoint)offset
{
    std::vector<std::vector<cv::Point>> rawContours;
    std::vector<cv::Vec4i> rawHierarchy;
    
    cv::findContours(image.rawMat, rawContours, rawHierarchy, (int)mode, (int)method, [OpenCV toPoint:offset]);
    
    *contours = [OpenCV fromContours:rawContours];
    *hierarchy = [OpenCV fromHierarchy:rawHierarchy];
}

+ (Mat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize anchor:(CGPoint)anchor
{
    cv::Mat rawMat = cv::getStructuringElement((int)shape, [OpenCV toSize:ksize], [OpenCV toPoint:anchor]);
    
    return [[Mat alloc] initWithRawMat:rawMat];
}

+ (void)morphologyExWithSrc:(Mat *)src dst:(Mat **)dst op:(NSInteger)op kernel:(Mat *)kernel anchor:(CGPoint)anchor iterations:(NSInteger)iterations borderType:(NSInteger)borderType borderValue:(NSArray *)borderValue
{
    cv::Scalar rawBorderValue = borderValue ? [OpenCV toScalar:borderValue] : cv::morphologyDefaultBorderValue();
    cv::Mat rawDst;
    
    cv::morphologyEx(src.rawMat, rawDst, (int)op, kernel.rawMat, [OpenCV toPoint:anchor], (int)iterations, (int)borderType, rawBorderValue);
    
    *dst = [[Mat alloc] initWithRawMat:rawDst];
}

+ (void)pyrDownWithSrc:(Mat *)src dst:(Mat **)dst dstsize:(CGSize)size borderType:(NSInteger)borderType
{
    cv::Mat rawDst;
    
    cv::pyrDown(src.rawMat, rawDst, [OpenCV toSize:size], (int)borderType);
    
    *dst = [[Mat alloc] initWithRawMat:rawDst];
}

+ (CGFloat)thresholdWithSrc:(Mat *)src dst:(Mat **)dst thresh:(CGFloat)thresh maxval:(CGFloat)maxval type:(NSInteger)type
{
    cv::Mat rawDst;
    
    CGFloat threshold = cv::threshold(src.rawMat, rawDst, thresh, maxval, (int)type);
    
    *dst = [[Mat alloc] initWithRawMat:rawDst];
    return threshold;
}
@end
