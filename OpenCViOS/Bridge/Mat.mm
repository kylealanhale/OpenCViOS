//
//  Mat.mm
//  
//
//  Created by Kyle Alan Hale on 2/22/15.
//
//

#import "Mat.h"
#include <opencv2/core.hpp>

@interface Mat() {
    @private
        cv::Mat *rawMat;
}
@end

@implementation Mat
#pragma mark - Life cycle
- (instancetype)init
{
    cv::Mat *mat = new cv::Mat();
    self = [self initWithRawMat:mat];
    return self;
}
- (instancetype)initWithRawMat:(cv::Mat *)mat
{
    if (self = [super init]) {
        rawMat = mat;
    }
    return self;
}
- (instancetype)initWithRows:(NSInteger)rows cols:(NSInteger)cols type:(NSInteger)type data:(void *)data step:(NSInteger)step
{
    cv::Mat *mat = new cv::Mat((int)rows, (int)cols, (int)type, data, step);
    self = [self initWithRawMat:mat];
    return self;
}
- (void)dealloc
{
    rawMat->release();
    delete rawMat;
}

#pragma mark - Methods
- (NSInteger)elemSize
{
    return rawMat->elemSize();
}

#pragma mark - Properties
- (cv::Mat *)rawMat
{
    return rawMat;
}
- (NSInteger)rows
{
    return rawMat->rows;
}

- (NSInteger)cols
{
    return rawMat->cols;
}
- (unsigned char *)data
{
    return rawMat->data;
}
- (NSInteger)total
{
    return rawMat->total();
}
- (NSInteger)stepAtIndex:(NSInteger)index
{
    return rawMat->step[(int)index];
}

@end
