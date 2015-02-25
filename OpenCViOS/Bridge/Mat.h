//
//  Mat.h
//  
//
//  Created by Kyle Alan Hale on 2/22/15.
//
//

#import <UIKit/UIKit.h>

@interface Mat : NSObject
@property (nonatomic, readonly) NSInteger rows;
@property (nonatomic, readonly) NSInteger cols;
@property (nonatomic, readonly) unsigned char *data;

- (instancetype)init;
- (instancetype)initWithRows:(NSInteger)rows cols:(NSInteger)cols type:(NSInteger)type data:(void *)data step:(NSInteger)step;

+ (instancetype)zeroesWithSize:(CGSize)size type:(NSInteger)type;

- (NSInteger)elemSize;
- (NSInteger)total;
- (NSInteger)stepAtIndex:(NSInteger)index;
@end
