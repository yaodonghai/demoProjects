//
//  MEUtils.m
//  
//
//  Created by 小O on 15/11/24.
//
//

#import "Utils.h"


@implementation Utils

@end

@implementation UIButton (Utils)
+ (UIButton *)buttonWithImage:(UIImage *)image frame:(CGRect)rect target:(id)target action:(SEL)action contentView:(UIView *)contentView{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    return button;
    
}
@end

@implementation UILabel (Utils)
+(UILabel *)labelWithFrame:(CGRect)rect align:(NSTextAlignment)align font:(UIFont *)font color:(UIColor *)color text:(NSString *)text autoText:(BOOL)autotext contentView:(UIView *)contentView{
    UILabel *label=[[UILabel alloc]initWithFrame:rect];
    label.textAlignment=align;
    label.font=font;
    label.textColor=color;
    label.numberOfLines=0;
    autotext?[label setAutoText:text]:[label setText:text];
    [contentView addSubview:label];
    return label;
}
- (void)setAutoText:(NSString *)text{
    CGSize size=[text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    CGRect rect=CGRectMake(self.frame.origin.x-(size.width-self.frame.size.width)/2.0, self.frame.origin.y, size.width, size.height);
    [self setText:text];
    [self setFrame:rect];
}

@end

@implementation UIImageView (Utils)
+(UIImageView *)imageViewWithFrame:(CGRect)rect image:(UIImage *)image contentView:(UIView *)contentView{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:rect];
    [imageView setImage:image];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [contentView addSubview:imageView];
    return imageView;
}
@end

@implementation UIView (Utils)
//View
+ (UIView *)viewWithFrame:(CGRect)rect color:(UIColor *)color contentView:(UIView *)contentView{
    UIView *view=[[UIView alloc]initWithFrame:rect];
    [view setBackgroundColor:color];
    [contentView addSubview:view];
    return view;
}
+ (UIView *)borderViewWithFrame:(CGRect)rect color:(UIColor *)color cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor contentView:(UIView *)contentView{
    UIView *view=[[UIView alloc]initWithFrame:rect];
    [view setBackgroundColor:color];
    [view makeBorderWithCornerRadius:radius borderWidth:width borderColor:borderColor];
    [contentView addSubview:view];
    return view;
}
- (void)makeBorderMaskWithWidth:(CGFloat)width{
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:width];
    CAShapeLayer *maskLayer= [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    maskLayer.path = [path CGPath];
    self.layer.mask = maskLayer;
//    [self.layer addSublayer:maskLayer];
    
}
- (void)makeMaskWithPath:(UIBezierPath *)path color:(UIColor *)color{
    CAShapeLayer *maskLayer= [CAShapeLayer layer];
    maskLayer.frame = self.layer.frame;
    maskLayer.path = [path CGPath];
    maskLayer.fillColor = [color CGColor];
    self.layer.mask = maskLayer;
}
- (void)makeBorderWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
//    self.layer.shouldRasterize=YES;
    self.layer.rasterizationScale=[UIScreen mainScreen].scale;
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
    
}
- (void)makeShadowWithColor:(UIColor *)color offSet:(CGSize)offSet opacity:(CGFloat)opacity{
    [self.layer setShadowOpacity:opacity];//设置阴影的透明度
    [self.layer setShadowColor:color.CGColor];
//    [self.layer setOpacity:0.5f];//设置View的透明度
    [self.layer setShadowOffset:offSet];//设置View Shadow的偏移量
    self.layer.shadowRadius = 4;//阴影半径，默认3
    self.clipsToBounds = NO;//超出边界剪辑容易跟border冲突
    
}

//设置两个视图在哪一片长度上居中,默认0点到width
+ (void)setCenterInWidth:(CGFloat)width space:(CGFloat)space withView:(UIView *)view1 andView:(UIView *)view2{
}
+ (void)setCenterBeginX1:(CGFloat)x1 width:(CGFloat)width space:(CGFloat)space withView:(UIView *)view1 andView:(UIView *)view2{
    CGFloat x=(width-view1.frame.size.width-view2.frame.size.width-space)/2.0;
    if(view1.frame.origin.x>width||view2.frame.origin.x>width){
        x+=([UIScreen mainScreen].bounds.size.width-width);
    }
    x+=x1;
    if (view1.frame.origin.x>view2.frame.origin.x) {
        [view2 setFrame:CGRectMake(x, view2.frame.origin.y, view2.frame.size.width, view2.frame.size.height)];
        [view1 setFrame:CGRectMake(view2.frame.size.width+view2.frame.origin.x+space, view1.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
    }
    else{
        [view1 setFrame:CGRectMake(x, view1.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
        [view2 setFrame:CGRectMake(view1.frame.size.width+view1.frame.origin.x+space, view2.frame.origin.y, view2.frame.size.width, view2.frame.size.height)];
    }

}
@end

@implementation UIViewController (Utils)
- (BOOL)isShowSideBar{
    return self.view.transform.tx==CGAffineTransformIdentity.tx;
}
//往右偏移的数值
- (void)showSideBar{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(200, 0);
        self.view.transform = CGAffineTransformMakeTranslation(200, 0);
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(200, 0);
    }];
}
- (void)hideSideBar{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformIdentity;
        self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
    }];

}
- (void)setupForDismissKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

@end


@implementation NSString (Utils)
+ (NSString *)getPathWithName:(NSString *)name
{
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:name];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
        
    {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        [fileManager createFileAtPath:path contents:nil attributes:nil];

        //设置root为数组
//        NSMutableArray *photoPathArray = [NSMutableArray array];
//        [photoPathArray writeToFile:path atomically:YES];
    }
    return path;
    
}
- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringFromUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString * returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
- (NSString *)getShortYearTimeStamp{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *result = [[dateFormatter stringFromDate:date] substringFromIndex:2];
    return result;
}
//普通字符串转换为十六进制的。
- (NSString *)tohexString{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }   
    return hexStr;   
}
//十六进制的字符串 转换成 String
- (NSString *)hexToString{
    char *myBuffer = (char *)malloc((int)[self length] / 2 + 1);
    bzero(myBuffer, [self length] / 2 + 1);
    for (int i = 0; i < [self length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;

}
//字符串转NSData类型数据
-(NSData*)toData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
//把int 变成 16进制的字符串
+(NSString *)hexFromInt:(unsigned int)number
{
    NSString * result = [NSString stringWithFormat:@"%x",number];
    if (result.length<2) {
        result = [NSString stringWithFormat:@"0%x",number];
    }
    return [result uppercaseString];
}



@end

@implementation UIColor (Utils)

+ (UIColor *) hex2RGB:(NSString *)inColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode];	// ignore error
    }
    redByte		= (unsigned char) (colorCode >> 16);
    greenByte	= (unsigned char) (colorCode >> 8);
    blueByte	= (unsigned char) (colorCode);	// masks off high bits
    result = [UIColor
              colorWithRed:	(float)redByte	/ 0xff
              green:	(float)greenByte/ 0xff
              blue:	(float)blueByte	/ 0xff
              alpha:1.0];
    return result;

}

@end

@implementation UIImage (Utils)
+ (UIImage *)circleImage:(NSString *)name withParam:(CGFloat)inset{
    UIImage *image=[UIImage imageNamed:name];
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2);
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
- (UIImage *)imageToSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 3);
    //    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已
}
+ (UIImage *)imageNamed:(NSString *)name scaleToSize:(CGSize)size
{
    UIImage *image=[UIImage imageNamed:name];
    
    //高像素
    UIGraphicsBeginImageContextWithOptions(size, NO, 3);
//    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    if (!color) {
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
@end


