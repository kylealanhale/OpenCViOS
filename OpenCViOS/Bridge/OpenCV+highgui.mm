//
//  OpenCV+highgui.mm
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV+highgui.h"
#import "Mat+raw.h"

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

@implementation OpenCV (highgui)
+ (Mat *)imread:(NSString *)filename flags:(IMRead)flags
{
    cv::Mat rawMat = cv::imread([filename UTF8String], flags);
    return [[Mat alloc] initWithRawMat:&rawMat];
}
@end
