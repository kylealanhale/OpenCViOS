//
//  OpenCV+imgproc.mm
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV+imgproc.h"
#import "OpenCV+raw.h"

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>

@implementation OpenCV (imgproc)
+ (CGRect)boundingRectForPoints:(NSArray *)points
{
    std::vector<cv::Point> rawPoints = [OpenCV toPointVector:points];
    
    return [OpenCV fromRect:cv::boundingRect(rawPoints)];
}
+ (CGRect)boundingRectForPointsInMat:(OpenCVMat *)points
{
    return [OpenCV fromRect:cv::boundingRect(points.rawMat)];
}

+ (NSInteger)countNonZeroForImage:(OpenCVMat *)src
{
    return cv::countNonZero(src.rawMat);
}

+ (void)cvtColorWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst code:(NSInteger)code dstCn:(NSInteger)dstCn
{
    cv::Mat rawDst;
    
    cv::cvtColor(src.rawMat, rawDst, (int)code, (int)dstCn);
    
    *dst = [[OpenCVMat alloc] initWithRawMat:rawDst];
}

+ (void)drawContours:(OpenCVMat *)image contours:(NSArray *)contours contourIdx:(NSInteger)contourIdx color:(NSArray *)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType hierarchy:(NSArray *)hierarchy maxLevel:(NSInteger)maxLevel offset:(CGPoint)offset
{
    cv::InputArray rawHierarchy = hierarchy ? [OpenCV toHierarchy:hierarchy] : cv::noArray();

    cv::drawContours(image.rawMat, [OpenCV toContours:contours], (int)contourIdx, [OpenCV toScalar:color], (int)thickness, (int)lineType, rawHierarchy, (int)maxLevel, [OpenCV toPoint:offset]);
}

+ (void)findContoursWithImage:(OpenCVMat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method offset:(CGPoint)offset
{
    std::vector<std::vector<cv::Point>> rawContours;
    std::vector<cv::Vec4i> rawHierarchy;
    
    cv::findContours(image.rawMat, rawContours, rawHierarchy, (int)mode, (int)method, [OpenCV toPoint:offset]);
    
    *contours = [OpenCV fromContours:rawContours];
    *hierarchy = [OpenCV fromHierarchy:rawHierarchy];
}

+ (OpenCVMat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize anchor:(CGPoint)anchor
{
    cv::Mat rawMat = cv::getStructuringElement((int)shape, [OpenCV toSize:ksize], [OpenCV toPoint:anchor]);
    
    return [[OpenCVMat alloc] initWithRawMat:rawMat];
}

+ (void)morphologyExWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst op:(NSInteger)op kernel:(OpenCVMat *)kernel anchor:(CGPoint)anchor iterations:(NSInteger)iterations borderType:(NSInteger)borderType borderValue:(NSArray *)borderValue
{
    cv::Scalar rawBorderValue = borderValue ? [OpenCV toScalar:borderValue] : cv::morphologyDefaultBorderValue();
    cv::Mat rawDst;
    
    cv::morphologyEx(src.rawMat, rawDst, (int)op, kernel.rawMat, [OpenCV toPoint:anchor], (int)iterations, (int)borderType, rawBorderValue);
    
    *dst = [[OpenCVMat alloc] initWithRawMat:rawDst];
}

+ (void)pyrDownWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst dstsize:(CGSize)size borderType:(NSInteger)borderType
{
    cv::Mat rawDst;
    
    cv::pyrDown(src.rawMat, rawDst, [OpenCV toSize:size], (int)borderType);
    
    *dst = [[OpenCVMat alloc] initWithRawMat:rawDst];
}

+ (void)rectangleInImage:(OpenCVMat *)img rec:(CGRect)rec color:(NSArray *)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType shift:(NSInteger)shift
{
    cv::Mat rawImg = img.rawMat;
    
    cv::rectangle(rawImg, [OpenCV toRect:rec], [OpenCV toScalar:color], (int)thickness, (int)lineType, (int)shift);
}

+ (CGFloat)thresholdWithSrc:(OpenCVMat *)src dst:(OpenCVMat **)dst thresh:(CGFloat)thresh maxval:(CGFloat)maxval type:(NSInteger)type
{
    cv::Mat rawDst;
    
    CGFloat threshold = cv::threshold(src.rawMat, rawDst, thresh, maxval, (int)type);
    
    *dst = [[OpenCVMat alloc] initWithRawMat:rawDst];
    return threshold;
}
@end
