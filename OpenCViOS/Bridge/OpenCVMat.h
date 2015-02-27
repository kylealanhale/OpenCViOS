//
//  Mat.h
//  
//
//  Created by Kyle Alan Hale on 2/22/15.
//
//

#import <UIKit/UIKit.h>

@interface OpenCVMat : NSObject
@property (nonatomic, readonly) NSInteger rows;
@property (nonatomic, readonly) NSInteger cols;
@property (nonatomic, readonly) unsigned char *data;

- (instancetype)init;
- (instancetype)initWithRows:(NSInteger)rows cols:(NSInteger)cols type:(NSInteger)type data:(void *)data step:(NSInteger)step;
- (instancetype)initWithMat:(OpenCVMat *)m roi:(CGRect)roi;

+ (instancetype)zeroesWithSize:(CGSize)size type:(NSInteger)type;

- (NSInteger)elemSize;
- (NSInteger)total;
- (CGSize)size;
- (NSInteger)stepAtIndex:(NSInteger)index;
- (instancetype)setToValue:(NSArray *)value mask:(NSArray *)mask;
@end
