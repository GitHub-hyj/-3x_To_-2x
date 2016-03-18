//
//  ViewController.m
//  @3x_To_@2x
//
//  Created by hyj on 16/3/18.
//  Copyright © 2016年 hyj. All rights reserved.
//

#import "ViewController.h"
#import "NSImage+PixelSize.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)Click:(NSButton *)sender {
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.accessoryViewDisclosed = YES;
    panel.canChooseDirectories = YES;
    [panel setAllowsMultipleSelection:YES];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        if (result == 1) {
            
            
            NSArray * urlArr = panel.URLs;
            
            
            [urlArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSImage *resImage = [[NSImage alloc] initWithContentsOfURL:urlArr[idx]];
                
                
                CGFloat scale = [NSScreen mainScreen].backingScaleFactor;
                NSLog(@"scale: %f", scale);
                CGFloat scaleFactor = 1.0 / scale;
                
                NSSize newSize = NSMakeSize(resImage.pixelsWide * scaleFactor * 2.0 / 3.0, resImage.pixelsHigh * scaleFactor * 2.0 / 3.0);
                
                NSImage *newImage = [self resizeImage:resImage size:newSize];
                
                NSData *outputData= [newImage TIFFRepresentation];
                NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:outputData];
                NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.9] forKey:NSImageCompressionFactor];
                NSData *data = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
                
                NSURL *url = urlArr[idx];
                
                NSMutableString *Mstring = [[NSMutableString alloc] initWithString:url.path];
                
                NSLog(@"%@",Mstring);
                
                
                if ([Mstring rangeOfString:@"@3x"].location != NSNotFound) {
                    
                    NSString * newStr = [Mstring stringByReplacingOccurrencesOfString:@"@3x" withString:@"@2x"];
                    
                    
                    BOOL ok = [data writeToFile:newStr atomically:YES];
                    NSLog(@"save %@ ok:%@", newStr, ok ? @"YES" : @"NO");
                }else{
                    
                    NSAlert *alert=[NSAlert alertWithMessageText:@"警告" defaultButton:@"我知道了" alternateButton:nil otherButton:nil informativeTextWithFormat:@"图片名为@3x"];
                    //下面这个方法就是为了能够传递参数给alertEnded:code:context:方法从而进行判断当前所点击的按钮
                    
                    
                    NSWindow * window = [NSApp mainWindow];
                    
                    [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:nil contextInfo:nil];
                }
                
                
            }];
            
        }
        
    }];
    

}


- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size
{
    
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage* targetImage = nil;
    NSImageRep *sourceImageRep =
    [sourceImage bestRepresentationForRect:targetFrame
                                   context:nil
                                     hints:nil];
    
    targetImage = [[NSImage alloc] initWithSize:size];
    
    [targetImage lockFocus];
    [sourceImageRep drawInRect: targetFrame];
    [targetImage unlockFocus];
    
    return targetImage;
}

@end
