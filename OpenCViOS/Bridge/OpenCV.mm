//
//  OpenCV.mm
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV+raw.h"

@implementation OpenCV
+ (cv::Point)toRawPoint:(CGPoint)point
{
    return cv::Point(point.x, point.y);
}
+ (CGPoint)fromRawPoint:(cv::Point)point
{
    return CGPointMake(point.x, point.y);
}
+ (cv::Rect)toRawRect:(CGRect)rect
{
    return cv::Rect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}
+ (CGRect)fromRawRect:(cv::Rect)rect
{
    return CGRectMake(rect.x, rect.y, rect.width, rect.height);
}
+ (cv::Size)toRawSize:(CGSize)size
{
    return cv::Size(size.width, size.height);
}
+ (CGSize)fromRawSize:(cv::Size)size
{
    return CGSizeMake(size.width, size.height);
}
@end
