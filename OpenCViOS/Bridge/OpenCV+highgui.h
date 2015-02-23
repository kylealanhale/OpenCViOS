//
//  OpenCV+highgui.h
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

#import "OpenCV.h"
#import "Mat.h"

typedef NS_ENUM(int, IMRead) {
    IMReadUnchanged  = -1, // 8bit, color or not
    IMReadGrayscale  = 0,  // 8bit, gray
    IMReadColor      = 1,  // ?, color
    IMReadAnydepth   = 2,  // any depth, ?
    IMReadAnycolor   = 4,  // ?, any color
    IMReadLoadGdal  = 8   // Use gdal driver
};

@interface OpenCV (highgui)
+ (Mat *)imread:(NSString *)filename flags:(IMRead)flags;
@end
