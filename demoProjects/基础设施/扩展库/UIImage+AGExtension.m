//
//  UIImage+ImageUtil.m
//  AppGame
//
//  Created by 姚东海 on 1/8/14.
//  Copyright (c) 2014年 计 炜. All rights reserved.
//

#import "UIImage+AGExtension.h"
#import <Accelerate/Accelerate.h>
#import <NYXImagesKit/NYXImagesKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import <CoreImage/CoreImage.h>
#import "Utils.h"

@implementation UIImage (AGExtension)
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size scale:(CGFloat)scale {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  颜色  生成图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size radius:(CGFloat)radius scale:(CGFloat)scale {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIBezierPath *maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.f, -1.f);
    CGContextAddPath(context, maskShape.CGPath);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size radius:(CGFloat)radius {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIBezierPath *maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.f, -1.f);
    CGContextAddPath(context, maskShape.CGPath);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)horizontalGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    gradientLayer.colors = @[ (id)fromColor.CGColor, (id)toColor.CGColor ];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)verticalGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    gradientLayer.colors = @[ (id)fromColor.CGColor, (id)toColor.CGColor ];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)verticalGradientImageWithColors:(NSArray *)colors size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    NSMutableArray *cgcolors = [NSMutableArray array];
    for (UIColor *each in colors) {
        [cgcolors addObject:(id)each.CGColor];
    }
    gradientLayer.colors = cgcolors;
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)verticalGradientImageWithColors:(NSArray *)colors locations:(NSArray *)locations size:(CGSize)size{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    NSMutableArray *cgcolors = [NSMutableArray array];
    for (UIColor *each in colors) {
        [cgcolors addObject:(id)each.CGColor];
    }
    gradientLayer.colors = cgcolors;
    gradientLayer.locations = locations;
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)horizontalGradientImageWithColors:(NSArray *)colors size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    NSMutableArray *cgcolors = [NSMutableArray array];
    for (UIColor *each in colors) {
        [cgcolors addObject:(id)each.CGColor];
    }
    gradientLayer.colors = cgcolors;
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)coverWithImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(self.size, YES, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //四个参数为水印图片的位置
    [image drawInRect:CGRectMake((self.size.width - image.size.width) / 2, (self.size.height - image.size.height) / 2, image.size.width, image.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
- (UIImage *)coverWithDefautlColor {
    
    UIImage *coverImage = [UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4] andSize:self.size];
    return [self coverWithImage:coverImage];
}
+ (UIImage *)wireframeWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    return [self wireframeWithColor:color size:size lineWith:1 cornerRadius:cornerRadius];
}
+ (UIImage *)wireframeWithColor:(UIColor *)color size:(CGSize)size lineWith:(CGFloat)lineWith cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextSetLineWidth(ctx, lineWith);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [color setStroke];
    [path stroke];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
- (UIImage *)imageWithRoundedSize:(CGSize)size borderWidth:(CGFloat)borderWidth {
    UIImage *aImage = self;
    if (aImage.size.width < size.width) {
        aImage = [aImage scaleByFactor:size.width / aImage.size.width];
    }
    if (aImage.size.height < size.height) {
        aImage = [aImage scaleByFactor:size.height / aImage.size.height];
    }
    aImage = [self scaleToFillSize:size];
    aImage = [aImage imageWithRoundedWithBorderWidth:borderWidth];
    return aImage;
}
- (UIImage *)imageWithRoundedSize:(CGSize)size {
    return [self imageWithRoundedSize:size borderWidth:0];
}

- (UIImage *)imageWithRounded {
    return [self imageWithRoundedWithBorderWidth:0];
}

- (UIImage *)imageWithRadius:(CGFloat)cornerRadius withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat inset = 1;
    cornerRadius = cornerRadius - inset;
    UIBezierPath *maskShape;

    maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:cornerRadius];

    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, maskShape.CGPath);
    CGContextClip(ctx);

    CGContextTranslateCTM(ctx, 0, height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), self.CGImage);
    CGContextRestoreGState(ctx);

    if (borderWidth > 0) {
        [borderColor setStroke];
        CGFloat halfWidth = borderWidth * 0.5;
        UIBezierPath *border = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(halfWidth, halfWidth, self.size.width - borderWidth, self.size.height - borderWidth) cornerRadius:cornerRadius - halfWidth];
        CGContextSetShouldAntialias(ctx, YES);
        CGContextSetAllowsAntialiasing(ctx, YES);
        CGContextSetLineWidth(ctx, borderWidth);
        CGContextAddPath(ctx, border.CGPath);
        CGContextStrokePath(ctx);
    }

    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


- (UIImage *)imageWithRoundedWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat inset = 1;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat cornerRadius;
    UIBezierPath *maskShape;
    if (width > height) {
        cornerRadius = height / 2.0 - inset;
        maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((width - height) / 2.0 + inset, 0 + inset, height - 2 * inset, height - 2 * inset) cornerRadius:cornerRadius];
    }
    else {
        cornerRadius = width / 2.0 - inset;
        maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0 + inset, (height - width) / 2.0 + inset, width - 2 * inset, width - 2 * inset) cornerRadius:cornerRadius];
    }

    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, maskShape.CGPath);
    CGContextClip(ctx);

    CGContextTranslateCTM(ctx, 0, height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), self.CGImage);
    CGContextRestoreGState(ctx);

    if (borderWidth > 0) {
        [borderColor setStroke];
        CGFloat halfWidth = borderWidth / 2.0;
        UIBezierPath *border = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(halfWidth, halfWidth, self.size.width - borderWidth, self.size.width - borderWidth)];
        CGContextSetShouldAntialias(ctx, YES);
        CGContextSetAllowsAntialiasing(ctx, YES);
        CGContextSetLineWidth(ctx, borderWidth);
        CGContextAddPath(ctx, border.CGPath);
        CGContextStrokePath(ctx);
    }

    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage *)imageWithRoundedWithBorderWidth:(CGFloat)borderWidth {
    return [self imageWithRoundedWithBorderWidth:borderWidth borderColor:[UIColor whiteColor]];
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGFloat width = self.size.width * self.scale;
    CGFloat height = self.size.height * self.scale;
    UIBezierPath *maskShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:radius];
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, height);
    CGContextScaleCTM(ctx, 1.f, -1.f);
    CGContextAddPath(ctx, maskShape.CGPath);
    CGContextClip(ctx);
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType
{
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) byRoundingCorners:rectCornerType cornerRadii:cornerRadii] addClip];
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithRadius:(CGFloat )radius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImage *)imageWithCropRect:(CGRect)cropRect {
    CGImageRef result = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *image = [UIImage imageWithCGImage:result scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(result);
    return image;
}
- (UIImage *)imageToOrientationUp;
{
    // No-op if the orientation is already correct
    UIImage *aImage = self;
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+ (UIImage *)imageFromCahcheWithURL:(NSURL *)URL size:(CGSize)size {
    return [self imageFromCahcheWithURL:URL size:size borderWidth:0];
}

+ (UIImage *)imageFromCahcheWithURL:(NSURL *)URL size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    return [[PINMemoryCache sharedCache] objectForKey:[self cachedImageKeyWithURL:URL size:size borderWidth:borderWidth]];
}
+ (void)cacheImage:(UIImage *)image URL:(NSURL *)URL size:(CGSize)size {
    return [self cacheImage:image URL:URL size:size borderWidth:0];
}
+ (void)cacheImage:(UIImage *)image URL:(NSURL *)URL size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    [[PINMemoryCache sharedCache] setObject:image forKey:[self cachedImageKeyWithURL:URL size:size borderWidth:borderWidth]];
}
+ (NSString *)cachedImageKeyWithURL:(NSURL *)URL size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    if (borderWidth > 0) {
        return [NSString stringWithFormat:@"%@%@%@", URL, NSStringFromCGSize(size), @(borderWidth)];
    }
    return [NSString stringWithFormat:@"%@%@", URL, NSStringFromCGSize(size)];
}
- (UIImage *)imageWithOriginalRenderingMode {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (UIImage *)imageWithTemplateRenderingMode {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)stretchableImageWithImageName:(NSString *)imageName LeftCapWidth:(float)w topCapHeight:(float)h {
    UIImage *stretchedImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:w topCapHeight:h];

    return stretchedImage;
}

//虚线
+ (UIImage *)drawImaginaryLineViewWithImageview:(UIImageView *)imageview {
    float width = imageview.frame.size.width;
    float height = imageview.frame.size.height;
    UIGraphicsBeginImageContext(imageview.frame.size); //开始画线
    [imageview.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound); //设置线条终点形状

    CGFloat lengths[] = {5, 3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor hex2RGB:@"0x585858"].CGColor);

    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextSetLineWidth(line, 0.5);

    CGContextMoveToPoint(line, 0.0, 0); //开始画线
    CGContextAddLineToPoint(line, width, 0);
    CGContextStrokePath(line);


    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

+ (UIImage *)imageWithSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    if (!sampleBuffer) {
        return nil;
    }
    CVImageBufferRef buffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if (!buffer) {
        return nil;
    }
    CVPixelBufferLockBaseAddress(buffer, 0);

    uint8_t *base;
    size_t width, height, bytesPerRow;
    base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);

    CGColorSpaceRef colorSpace;
    CGContextRef cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);

    CGImageRef cgImage;
    UIImage *image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);

    CVPixelBufferUnlockBaseAddress(buffer, 0);
    return image;
}

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor {
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f)
        return self;

    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0)
        boxSize++;

    //create image buffers
    CGImageRef imageRef = self.CGImage;

    //convert to ARGB if it isn't
    if (CGImageGetBitsPerPixel(imageRef) != 32 ||
        CGImageGetBitsPerComponent(imageRef) != 8 ||
        !((CGImageGetBitmapInfo(imageRef) & kCGBitmapAlphaInfoMask))) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        [self drawAtPoint:CGPointZero];
        imageRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
    }

    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);

    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));

    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);

    for (NSUInteger i = 0; i < iterations; i++) {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }

    //free buffers
    free(buffer2.data);
    free(tempBuffer);

    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));

    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f) {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }

    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return image;
}
- (NSString *)ag_toJPEGBase64 {
    NSData *pngData = UIImageJPEGRepresentation(self, 0.8); //UIImagePNGRepresentation(self);

    NSString *base64String = [pngData base64EncodedStringWithOptions:0];
    return base64String;
}

+ (UIImage *)joinImages:(NSArray *)images {
    CGFloat totalWidth = 0;
    CGFloat maxHeight = 0;
    for (UIImage *img in images) {
        NSAssert([img isKindOfClass:[UIImage class]], @"必须是 UIImage");
        if (img.size.height > maxHeight) {
            maxHeight = img.size.height;
        }
        totalWidth += img.size.width;
    }

    CGSize size = CGSizeMake(totalWidth, maxHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);

    CGPoint pre = CGPointZero;
    for (int i = 0; i < images.count; i++) {
        UIImage *img = images[i];
        //        [img drawAtPoint:pre];
        [img drawInRect:CGRectMake(pre.x, pre.y, img.size.width, img.size.height)];
        pre.x += img.size.width;
    }

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return finalImage;
}

- (UIImage *)imageRotateInRadians:(CGFloat)radians scale:(CGFloat)scale {
    /// Create an ARGB bitmap context
    const size_t width = (size_t)CGImageGetWidth(self.CGImage) * scale;
    const size_t height = (size_t)CGImageGetHeight(self.CGImage) * scale;

    CGRect rotatedRect = CGRectApplyAffineTransform(CGRectMake(0., 0., width, height), CGAffineTransformMakeRotation(radians));

    CGContextRef bmContext = NYXCreateARGBBitmapContext((size_t)rotatedRect.size.width, (size_t)rotatedRect.size.height, (size_t)rotatedRect.size.width * kNyxNumberOfComponentsPerARBGPixel, YES);
    if (!bmContext)
        return nil;

    /// Image quality
    CGContextSetShouldAntialias(bmContext, true);
    CGContextSetAllowsAntialiasing(bmContext, true);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);

    /// Rotation happen here (around the center)
    CGContextTranslateCTM(bmContext, +(rotatedRect.size.width / 2.0f), +(rotatedRect.size.height / 2.0f));
    CGContextRotateCTM(bmContext, radians);

    // Do flips
    CGContextTranslateCTM(bmContext, 0.0f, 0.0f);
    CGContextScaleCTM(bmContext, 1.0f, 1.0f);

    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, CGRectMake(-(width / 2.0f), -(height / 2.0f), width, height), self.CGImage);

    /// Create an image object from the context
    CGImageRef resultImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *resultImage = [UIImage imageWithCGImage:resultImageRef scale:self.scale orientation:self.imageOrientation];

    /// Cleanup
    CGImageRelease(resultImageRef);
    CGContextRelease(bmContext);

    return resultImage;
}

+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    if (!data) {
        return nil;
    }
    CGFloat maxPixelSize = MAX(size.width, size.height);
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways : (__bridge id)kCFBooleanTrue ,
                              (__bridge id)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithFloat:maxPixelSize]};
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    return resultImage;
}

- (UIColor *)colorAtPoint:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }

    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);

    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)transformtoSize:(CGSize)Newsize {
    //创建一个bitmap的context
    UIGraphicsBeginImageContext(Newsize);
    //绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
    //从当前context中创建一个改变大小后的图片
    UIImage *TransformedImg = UIGraphicsGetImageFromCurrentImageContext();
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return TransformedImg;
}

// 图片颜色转换
- (UIImage *)imageConvertColorWithColor:(UIColor*)color{
    if (color == nil) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)screenshotWithView:(UIView *)screenshotView {
    UIGraphicsBeginImageContextWithOptions(screenshotView.bounds.size, NO, 0);
    [screenshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)screenshotHierarchyWithView:(UIView *)screenshotView {
    UIImage *image = nil;
    UIGraphicsBeginImageContext(screenshotView.frame.size);
    [screenshotView drawViewHierarchyInRect:screenshotView.frame afterScreenUpdates:YES];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)captureImgWhenViewIsGPUImageView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextConcatCTM(ctx, [view.layer affineTransform]);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {//iOS 7+
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    } else {//iOS 6
        [view.layer renderInContext:ctx];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(ctx);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size {
  
    UIImage *codeImage = nil;
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return codeImage;
}


+ (UIImage *)tvb_PlaceholderImage{
    UIImage *image = [UIImage imageNamed:@"home_default_loading_bg"];
    image.accessibilityLabel = @"home_default_loading_bg";
    return image;
//    return [UIImage imageNamed:@"no-photo"];
}

// 缺省加载图
+ (UIImage *)tvb_PlaceholderLoadingImage{
    UIImage *image = [UIImage imageNamed:@"home_default_loading_bg"];
    image.accessibilityLabel = @"home_default_loading_bg";
    return image;
}

+ (UIImage *)tvb_YellowAvatarholderImage{
    return [UIImage imageNamed:@"not_login_icon"];
}

//素素/阿福要求都改成黄色
+ (UIImage *)tvb_AvatarholderImage{
//    return [UIImage imageNamed:@"figure_head_portrait"];
    return [UIImage imageNamed:@"not_login_icon"];
}

+ (UIImage *)tvb_nobilityholderImage{
    return [UIImage imageNamed:@"default_nobility_icon"];
}


+ (NSData *)imageToData:(UIImage *)image {
    CGImageRef imageRef = image.CGImage;
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    CFDataRef bitmapData = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    NSData *imageData = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    return imageData;
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
            
    }
    return nil;
}

/**
 *  自适应居中裁剪
 *
 *  @param size          容器大小
 *
 *  @return 修改后的图
 */
- (UIImage *)clipCenterWithSize:(CGSize)size {
    
    CGSize originalsize = self.size;
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat scale = originalsize.width/originalsize.height;
    if (originalsize.width >= originalsize.height) {
        if ((size.width/scale) < size.height) {
            width = size.height*scale;
            height = size.height;
            x = (width - size.width)/2;
            y = 0;
        } else {
            width = size.width;
            height = size.width/scale;
            x = 0;
            y = (height - size.height)/2;
        }
    } else {
        if ((size.height*scale) < size.width) {
            width = size.width;
            height = size.width/scale;
            x = 0;
            y = (height - size.height)/2;
            
        } else {
            width = size.height*scale;
            height = size.height;
            x = (width - size.width)/2;
            y = 0;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(-x, -y, width, height)];
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageNew;
}

/**
 *  自适应底部裁剪
 *
 *  @param size          容器大小
 *
 *  @return 修改后的图
 */
- (UIImage *)clipBottomWithSize:(CGSize)size topScale:(CGFloat)topScale {
    
    CGSize originalsize = self.size;
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat scale = originalsize.width/originalsize.height;
    if (originalsize.width >= originalsize.height) {
        if ((size.width/scale) < size.height) {
            width = size.height*scale;
            height = size.height;
            x = (width - size.width)/2;
            y = 0;
        } else {
            width = size.width;
            height = size.width/scale;
            x = 0;
            y = (height - size.height)/2 * topScale;
        }
    } else {
        if ((size.height*scale) < size.width) {
            width = size.width;
            height = size.width/scale;
            x = 0;
            y = (height - size.height)/2 * topScale;
        } else {
            width = size.height*scale;
            height = size.height;
            x = (width - size.width)/2;
            y = 0;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(-x, -y, width, height)];
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageNew;
}




- (UIImage*)addTopImage:(UIImage*)topImage bottomImage:(UIImage*)bottomImage

{
  
    //将底部的一张的大小作为所截取的合成图的尺寸
    
    CGSize size = bottomImage.size;

     UIGraphicsBeginImageContext(size);

    // Draw image2，底下的

    [bottomImage drawInRect:CGRectMake(0, 0, bottomImage.size.width, bottomImage.size.height)];

    [topImage drawInRect:CGRectMake(2.0,(size.height - topImage.size.height)*0.5, topImage.size.width, topImage.size.height)];

    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return resultingImage;

}

- (UIImage*)mergeImage:(UIImage*)topImage bottomImage:(UIImage*)bottomImage{
      
     
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);

        [bottomImage drawInRect:CGRectMake(0.0,0.0, bottomImage.size.width, bottomImage.size.height)];

        [topImage drawInRect:CGRectMake(2.0,(self.size.height - topImage.size.height)*0.5, topImage.size.width, topImage.size.height)];

        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        return resultingImage;
}

// 设置黑白色
+ (UIImage *)grayImage:(UIImage *)image
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize resultSize = CGSizeMake(image.size.width*scale, image.size.height*scale);
    CGRect imageRect = CGRectMake(0, 0, resultSize.width, resultSize.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, resultSize.width, resultSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);//使用kCGImageAlphaPremultipliedLast保留Alpha通道，避免透明区域变成黑色。
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return newImage;
}

// 切圆
+ (UIImage *)clipCircleImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage *image = [filter outputImage];
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}

//二维码清晰
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



+ (UIImage *)screenshotViewWithView:(UIView *)view{

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
       [view.layer renderInContext:UIGraphicsGetCurrentContext()];
       UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       return image;
    
}

+ (UIImage *)tvb_imageWithContentsOfFileWithImageName:(NSString *)imageName
{
    UIImage *image = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    if (path.length) {
        image = [UIImage imageWithContentsOfFile:path];
    }
    if (!image) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}

@end
