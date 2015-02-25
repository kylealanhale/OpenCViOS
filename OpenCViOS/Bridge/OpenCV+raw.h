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
+ (cv::Point)toRawPoint:(CGPoint)point;
+ (CGPoint)fromRawPoint:(cv::Point)point;
+ (cv::Rect)toRawRect:(CGRect)rect;
+ (CGRect)fromRawRect:(cv::Rect)rect;
+ (cv::Size)toRawSize:(CGSize)size;
+ (CGSize)fromRawSize:(cv::Size)size;
@end
