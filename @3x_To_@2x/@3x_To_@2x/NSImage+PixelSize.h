//
//  NSImage+PixelSize.h
//  @3x_To_@2x
//
//  Created by hyj on 16/3/18.
//  Copyright © 2016年 hyj. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (PixelSize)

- (NSInteger) pixelsWide;
- (NSInteger) pixelsHigh;
- (NSSize) pixelSize;

@end
