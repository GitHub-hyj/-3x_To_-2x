//
//  NSImage+PixelSize.m
//  @3x_To_@2x
//
//  Created by hyj on 16/3/18.
//  Copyright © 2016年 hyj. All rights reserved.
//

#import "NSImage+PixelSize.h"

@implementation NSImage (PixelSize)

- (NSInteger) pixelsWide
{
    NSInteger result = 0;
    NSInteger bitmapResult = 0;
    
    for (NSImageRep* imageRep in [self representations]) {
        if ([imageRep isKindOfClass:[NSBitmapImageRep class]]) {
            if (imageRep.pixelsWide > bitmapResult)
                bitmapResult = imageRep.pixelsWide;
        } else {
            if (imageRep.pixelsWide > result)
                result = imageRep.pixelsWide;
        }
    }
    if (bitmapResult) result = bitmapResult;
    return result;
    
}

- (NSInteger) pixelsHigh
{

    NSInteger result = 0;
    NSInteger bitmapResult = 0;
    
    for (NSImageRep* imageRep in [self representations]) {
        if ([imageRep isKindOfClass:[NSBitmapImageRep class]]) {
            if (imageRep.pixelsHigh > bitmapResult)
                bitmapResult = imageRep.pixelsHigh;
        } else {
            if (imageRep.pixelsHigh > result)
                result = imageRep.pixelsHigh;
        }
    }
    if (bitmapResult) result = bitmapResult;
    return result;
}

- (NSSize) pixelSize
{
    return NSMakeSize(self.pixelsWide,self.pixelsHigh);
}


@end
