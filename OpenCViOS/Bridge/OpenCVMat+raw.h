//
//  Mat+raw.h
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCVMat.h"
#include <opencv2/core.hpp>

@interface OpenCVMat (raw)
@property (nonatomic, readonly) cv::Mat rawMat;
- (instancetype)initWithRawMat:(cv::Mat)rawMat;
@end
