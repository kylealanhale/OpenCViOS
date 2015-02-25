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
    std::vector<cv::Point> rawPoints = std::vector<cv::Point>();
    for (NSValue *boxedPoint in points) {
        rawPoints.push_back([OpenCV toRawPoint:[boxedPoint CGPointValue]]);
    }
    
    return [OpenCV fromRawRect:cv::boundingRect(rawPoints)];
}
+ (CGRect)boundingRectForPointsInMat:(Mat *)points
{
    return [OpenCV fromRawRect:cv::boundingRect(points.rawMat)];
}

+ (void)cvtColorWithSrc:(Mat *)src dst:(Mat **)dst code:(NSInteger)code
{
    [self cvtColorWithSrc:src dst:dst code:code dstCn:0];
}
+ (void)cvtColorWithSrc:(Mat *)src dst:(Mat **)dst code:(NSInteger)code dstCn:(NSInteger)dstCn
{
    cv::Mat rawDst;
    cv::cvtColor(src.rawMat, rawDst, (int)code, (int)dstCn);
    *dst = [[Mat alloc] initWithRawMat:rawDst];
}

+ (void)findContoursWithImage:(Mat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method
{
    [self findContoursWithImage:image contours:contours hierarchy:hierarchy mode:mode method:method offset:CGPointZero];
}
+ (void)findContoursWithImage:(Mat *)image contours:(NSArray **)contours hierarchy:(NSArray **)hierarchy mode:(NSInteger)mode method:(NSInteger)method offset:(CGPoint)offset
{
    std::vector<std::vector<cv::Point>> rawContours;
    std::vector<cv::Vec4i> rawHierarchy;
    
    cv::findContours(image.rawMat, rawContours, rawHierarchy, (int)mode, (int)method, [OpenCV toRawPoint:offset]);
    
    NSMutableArray *newContours = [NSMutableArray array];
    for (std::vector<cv::Point> rawPoints : rawContours) {
        NSMutableArray *points = [NSMutableArray array];
        for (cv::Point point : rawPoints) {
            [points addObject:[NSValue valueWithCGPoint:[OpenCV fromRawPoint:point]]];
        }
        [newContours addObject:points];
    }
    *contours = newContours;
    
    NSMutableArray *newHierarchy = [NSMutableArray array];
    for (cv::Vec4i rawHierarchyInstructions : rawHierarchy) {
        NSMutableArray *hierarchyInstructions = [NSMutableArray array];
        for (int index = 0; index < 4; index++) {
            [hierarchyInstructions addObject:hierarchy[index]];
        }
        [newHierarchy addObject:hierarchyInstructions];
    }
    *hierarchy = newHierarchy;
}

+ (Mat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize
{
    return [self getStructuringElementWithShape:shape ksize:ksize anchor:CGPointMake(-1, -1)];
}
+ (Mat *)getStructuringElementWithShape:(NSInteger)shape ksize:(CGSize)ksize anchor:(CGPoint)anchor
{
    cv::Mat rawMat = cv::getStructuringElement((int)shape, [OpenCV toRawSize:ksize], [OpenCV toRawPoint:anchor]);
    return [[Mat alloc] initWithRawMat:rawMat];
}

+ (void)morphologyExWithSrc:(Mat *)src dst:(Mat **)dst op:(NSInteger)op kernel:(Mat *)kernel
{
    cv::Scalar rawBorderValue = cv::morphologyDefaultBorderValue();
    NSArray *borderValue = @[@(rawBorderValue[0]), @(rawBorderValue[1]), @(rawBorderValue[2]), @(rawBorderValue[3])];
    [self morphologyExWithSrc:src dst:dst op:op kernel:kernel anchor:CGPointMake(-1, -1) iterations:1 borderType:cv::BORDER_CONSTANT borderValue:borderValue];
}
+ (void)morphologyExWithSrc:(Mat *)src dst:(Mat **)dst op:(NSInteger)op kernel:(Mat *)kernel anchor:(CGPoint)anchor iterations:(NSInteger)iterations borderType:(NSInteger)borderType borderValue:(NSArray *)borderValue
{
    cv::Scalar rawBorderValue;
    if (borderValue) {
        rawBorderValue = cv::Scalar();
        for (int index = 0; index < borderValue.count; index++) {
            rawBorderValue[index] = [borderValue[index] doubleValue];
        }
    }
    else {
        rawBorderValue = cv::morphologyDefaultBorderValue();
    }
    
    cv::Mat rawDst;
    cv::morphologyEx(src.rawMat, rawDst, (int)op, kernel.rawMat, [OpenCV toRawPoint:anchor], (int)iterations, (int)borderType, rawBorderValue);
    *dst = [[Mat alloc] initWithRawMat:rawDst];
}

+ (void)pyrDownWithSrc:(Mat *)src dst:(Mat **)dst
{
    [self pyrDownWithSrc:src dst:dst dstsize:CGSizeZero borderType:cv::BORDER_DEFAULT];
}
+ (void)pyrDownWithSrc:(Mat *)src dst:(Mat **)dst dstsize:(CGSize)size borderType:(NSInteger)borderType
{
    cv::Mat rawDst;
    cv::pyrDown(src.rawMat, rawDst, [OpenCV toRawSize:size], (int)borderType);
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
