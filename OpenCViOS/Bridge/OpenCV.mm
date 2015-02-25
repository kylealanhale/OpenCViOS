//
//  OpenCV.mm
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV+raw.h"

@implementation OpenCV
+ (std::vector<std::vector<cv::Point>>)toContours:(NSArray *)wrappedContours
{
    std::vector<std::vector<cv::Point>> rawContours = std::vector<std::vector<cv::Point>>();
    
    for (NSArray *contour in wrappedContours) {
        rawContours.push_back([self toPointVector:contour]);
    }
    
    return rawContours;
}
+ (NSArray *)fromContours:(std::vector<std::vector<cv::Point>>)rawContours
{
    NSMutableArray *wrappedContours = [NSMutableArray array];
    for (std::vector<cv::Point> contour : rawContours) {
        [wrappedContours addObject:[self fromPointVector:contour]];
    }
    return wrappedContours;
}

+ (std::vector<cv::Vec4i>)toHierarchy:(NSArray *)wrappedHierarchy
{
    std::vector<cv::Vec4i> rawHierarchy = std::vector<cv::Vec4i>();
    
    for (NSArray *wrappedVector in wrappedHierarchy) {
        rawHierarchy.push_back([self toVec4i:wrappedVector]);
    }
    
    return rawHierarchy;
}
+ (NSArray *)fromHierarchy:(std::vector<cv::Vec4i>)rawHierarchy
{
    NSMutableArray *wrappedHierarchy = [NSMutableArray array];
    for (cv::Vec4i rawHierarchyInstructions : rawHierarchy) {
        [wrappedHierarchy addObject:[self fromVec4i:rawHierarchyInstructions]];
    }
    return wrappedHierarchy;
}

+ (cv::Point)toPoint:(CGPoint)point
{
    return cv::Point(point.x, point.y);
}
+ (CGPoint)fromPoint:(cv::Point)point
{
    return CGPointMake(point.x, point.y);
}

+ (std::vector<cv::Point>)toPointVector:(NSArray *)wrappedPointVector
{
    std::vector<cv::Point> rawPointVector = std::vector<cv::Point>();
    for (NSValue *wrappedPoint in wrappedPointVector) {
        rawPointVector.push_back([self toPoint:[wrappedPoint CGPointValue]]);
    }
    return rawPointVector;
}
+ (NSArray *)fromPointVector:(std::vector<cv::Point>)rawPointVector
{
    NSMutableArray *wrappedPointVector = [NSMutableArray array];
    for (cv::Point point : rawPointVector) {
        [wrappedPointVector addObject:[NSValue valueWithCGPoint:[self fromPoint:point]]];
    }
    return wrappedPointVector;
}

+ (cv::Rect)toRect:(CGRect)rect
{
    return cv::Rect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}
+ (CGRect)fromRect:(cv::Rect)rect
{
    return CGRectMake(rect.x, rect.y, rect.width, rect.height);
}

+ (cv::Scalar)toScalar:(NSArray *)wrappedScalar
{
    return [self toVec4d:wrappedScalar];
}
+ (NSArray *)fromScalar:(cv::Scalar)rawScalar
{
    return [self fromVec4d:rawScalar];
}

+ (cv::Vec4d)toVec4d:(NSArray *)wrappedVector
{
    cv::Vec4d rawVector = cv::Vec4d();
    for (int index = 0; index < 4; index++) {
        rawVector[index] = [wrappedVector[index] doubleValue];
    }
    return rawVector;
}
+ (NSArray *)fromVec4d:(cv::Vec4d)rawVector
{
    NSMutableArray *wrappedVector = [NSMutableArray array];
    for (int index = 0; index < 4; index++) {
        [wrappedVector addObject:[NSNumber numberWithDouble:rawVector[index]]];
    }
    return wrappedVector;
}

+ (cv::Vec4i)toVec4i:(NSArray *)wrappedVector
{
    cv::Vec4i rawVector = cv::Vec4i();
    for (int index = 0; index < 4; index++) {
        rawVector[index] = [wrappedVector[index] intValue];
    }
    return rawVector;
}
+ (NSArray *)fromVec4i:(cv::Vec4i)rawVector
{
    NSMutableArray *wrappedVector = [NSMutableArray array];
    for (int index = 0; index < 4; index++) {
        [wrappedVector addObject:[NSNumber numberWithInt:rawVector[index]]];
    }
    return wrappedVector;
}

+ (cv::Size)toSize:(CGSize)size
{
    return cv::Size(size.width, size.height);
}
+ (CGSize)fromSize:(cv::Size)size
{
    return CGSizeMake(size.width, size.height);
}
@end
