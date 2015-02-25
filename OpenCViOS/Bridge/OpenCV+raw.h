//
//  OpenCV+raw.h
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/23/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV.h"
#import "Mat+raw.h"
#include <opencv2/core.hpp>

@interface OpenCV (raw)
+ (std::vector<std::vector<cv::Point>>)toContours:(NSArray *)wrappedContours;
+ (NSArray *)fromContours:(std::vector<std::vector<cv::Point>>)rawContours;

+ (std::vector<cv::Vec4i>)toHierarchy:(NSArray *)wrappedHierarchy;
+ (NSArray *)fromHierarchy:(std::vector<cv::Vec4i>)rawHierarchy;

+ (cv::Point)toPoint:(CGPoint)point;
+ (CGPoint)fromPoint:(cv::Point)point;

+ (std::vector<cv::Point>)toPointVector:(NSArray *)wrappedPointVector;
+ (NSArray *)fromPointVector:(std::vector<cv::Point>)rawPointVector;

+ (cv::Rect)toRect:(CGRect)rect;
+ (CGRect)fromRect:(cv::Rect)rect;

/** @param wrappedScalar 4 double values in an array */
+ (cv::Scalar)toScalar:(NSArray *)wrappedScalar;
/** @return 4 double values in an array */
+ (NSArray *)fromScalar:(cv::Scalar)rawScalar;

/** @param wrappedVector 4 double values in an array */
+ (cv::Vec4d)toVec4d:(NSArray *)wrappedVector;
/** @return 4 double values in an array */
+ (NSArray *)fromVec4d:(cv::Vec4d)rawVector;

/** @param wrappedVector 4 integer values in an array */
+ (cv::Vec4i)toVec4i:(NSArray *)wrappedVector;
/** @return 4 integer values in an array */
+ (NSArray *)fromVec4i:(cv::Vec4i)rawVector;

+ (cv::Size)toSize:(CGSize)size;
+ (CGSize)fromSize:(cv::Size)size;
@end
