//
//  Utils.h
//  
//
//  Created by 小O on 15/11/24.
//
//
//View圆角和加边框

#define ViewBorderRadius(View,Radius,Width,Color)\
\[View.layer setCornerRadius:(Radius)];\[View.layer setMasksToBounds:YES];\[View.layer setBorderWidth:(Width)];\[View.layer setBorderColor:[Color CGColor]]

// View圆角

#define ViewRadius(View,Radius)\
\[View.layer setCornerRadius:(Radius)];\
\[View.layer setMasksToBounds:YES]

//property属性快速声明

#define PropertyString(s) @property(nonatomic,copy)NSString * s

#define PropertyNSInteger(s) @property(nonatomic,assign)NSInteger s

#define PropertyFloat(s) @property(nonatomic,assign)float s

#define PropertyLongLong(s) @property(nonatomic,assign)long long s

#define PropertyNSDictionary(s) @property(nonatomic,strong)NSDictionary * s

#define PropertyNSArray(s) @property(nonatomic,strong)NSArray * s

#define PropertyNSMutableArray(s) @property(nonatomic,strong)NSMutableArray * s

///IOS版本判断
#define IOSAVAILABLEVERSION(version)([[UIDevice currentDevice]availableVersion:version]< 0)

//当前系统版本

#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//当前语言
#define CurrentLanguage ([NSLocale preferredLanguages]objectAtIndex:0])

#define kRandomColorKRGBColor (arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)//随机色生成

//获取一段时间间隔

#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();

#define kEndTimeNSLog (@"Time: %f",CFAbsoluteTimeGetCurrent()- start)

#import <Foundation/Foundation.h>



@interface Utils : NSObject

@end

@interface UIButton (Utils)
+ (UIButton *)buttonWithImage:(UIImage *)image frame:(CGRect)rect target:(id)target action:(SEL)action contentView:(UIView *)contentView;
@end

@interface UILabel (Utils)
+(UILabel *)labelWithFrame:(CGRect)rect align:(NSTextAlignment)align font:(UIFont *)font color:(UIColor *)color text:(NSString *)text autoText:(BOOL)autotext contentView:(UIView *)contentView;
- (void)setAutoText:(NSString *)text;
@end


@interface UIImageView (Utils)
+ (UIImageView *)imageViewWithFrame:(CGRect)rect image:(UIImage*)image contentView:(UIView *)contentView;
@end

@interface UIView (Utils)

//view
+ (UIView *)viewWithFrame:(CGRect)rect color:(UIColor *)color contentView:(UIView *)contentView;
+ (UIView *)borderViewWithFrame:(CGRect)rect color:(UIColor *)color cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor contentView:(UIView *)contentView;
- (void)makeBorderWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (void)makeBorderMaskWithWidth:(CGFloat)width;
- (void)makeMaskWithPath:(UIBezierPath *)path color:(UIColor *)color;
- (void)makeShadowWithColor:(UIColor *)color offSet:(CGSize)offSet opacity:(CGFloat)opacity;
+ (void)setCenterInWidth:(CGFloat)width space:(CGFloat)space withView:(UIView *)view1 andView:(UIView *)view2;
+ (void)setCenterBeginX1:(CGFloat)x1 width:(CGFloat)width space:(CGFloat)space withView:(UIView *)view1 andView:(UIView *)view2;

@end

@interface UIViewController (Utils)
#pragma 侧边栏动画（需要额外写一个View）
//是否显示侧边栏
- (BOOL)isShowSideBar;
//侧边栏动画
- (void)showSideBar;
- (void)hideSideBar;
//开启键盘的监听
-(void)setupForDismissKeyboard;
@end

@interface NSString (Utils)
//获得plist路径
+ (NSString *)getPathWithName:(NSString *)name;
- (NSString *)getShortYearTimeStamp;
//普通字符串转换为十六进制的字符串。
- (NSString *)tohexString;
//十六进制的字符串 转换成 String
- (NSString *)hexToString;
//编写一个NSData类型数据
- (NSData*)toData;
//把int 变成 16进制的字符串
+ (NSString *)hexFromInt:(unsigned int)number;
//unicode转字符串
+ (NSString *)stringFromUnicode:(NSString *)unicodeStr;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
@end

@interface UIColor (Utils)
+ (UIColor *)hex2RGB:(NSString *)inColorString;
@end

@interface UIImage (Utils)
- (UIImage *)imageToSize:(CGSize)size;
//圆形图片
+ (UIImage *)circleImage:(NSString *)name withParam:(CGFloat)inset;
//返回Size大小图片
+ (UIImage *)imageNamed:(NSString *)name scaleToSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;
@end





////打一群水印
//- (UIImage *)addAttributed:(NSArray *)array toImage:(UIImage *)image
//{
//    if ([array count]<1) {
//        return image;
//    }
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1);
//    //底图
//    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    
//    float scale= imageView.image.size.width/WIDE;
//    
//    for (int i=0; i<[array count]; i++) {
//        AddSpecialView *special=(AddSpecialView *)[array objectAtIndex:i];
//        UIImage *image=[self buildImage:special.addSpecialImage.image andJD:special.rotation];
//        [image drawInRect:CGRectMake((special.frame.origin.x+22.5)*scale, (special.frame.origin.y+22.5)*scale, (special.frame.size.width-45)*scale, (special.frame.size.height-45)*scale)];
//        image=nil;
//    }
//    
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return resultImage;
//}
////旋转角度
//-(UIImage*)buildImage:(UIImage*)image andJD:(float)jd
//{
//    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
//    CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform" keysAndValues:kCIInputImageKey, ciImage, nil];
//    
//    [filter setDefaults];
//    CGAffineTransform transform = CATransform3DGetAffineTransform([self rotateTransform:CATransform3DIdentity clockwise:NO andJD:jd]);
//    [filter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *outputImage = [filter outputImage];
//    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    
//    UIImage *result = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    
//    return result;
//}
////打水印
//-(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 subRect:(CGRect)rect
//{
//    UIGraphicsBeginImageContext(image2.size);
//    
//    //Draw image2
//    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
//    
//    //Draw image1
//    [image1 drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
//
//        [image drawInRect:CGRectMake((special.frame.origin.x+22.5)*scale, (special.frame.origin.y+22.5)*scale, (special.frame.size.width-45)*scale, (special.frame.size.height-45)*scale) blendMode:kCGBlendModePlusLighter alpha:1];
//        kCGBlendModeNormal,
//        kCGBlendModeMultiply,
//        kCGBlendModeScreen,
//        kCGBlendModeOverlay, //覆盖物
//        kCGBlendModeDarken,  //变暗，随背景
//        kCGBlendModeLighten,  //亮，轻松
//        kCGBlendModeColorDodge, //颜色闪避，类似粉红色淡化
//        kCGBlendModeColorBurn,  //颜色灼烧，白色不见
//        kCGBlendModeSoftLight,    //柔性亮光，相当于反光
//        kCGBlendModeHardLight,    //强光
//        kCGBlendModeDifference,   //差异
//        kCGBlendModeExclusion,    //排斥
//        kCGBlendModeHue,      //色相，色调
//        kCGBlendModeSaturation, //饱和度
//        kCGBlendModeColor,
//        kCGBlendModeLuminosity,    //白色外的颜色变白
//
//        kCGBlendModeClear,			/* R = 0 */     //整块变白...
//        kCGBlendModeCopy,			/* R = S */     //背景变白...
//        kCGBlendModeSourceIn,		/* R = S*Da */      //还是整块背景变白
//        kCGBlendModeSourceOut,		/* R = S*(1 - Da) */    //整块变白...
//        kCGBlendModeSourceAtop,		/* R = S*Da + D*(1 - Sa) */
//        kCGBlendModeDestinationOver,	/* R = S*(1 - Da) + D */    //完全消失了...
//        kCGBlendModeDestinationIn,		/* R = D*Sa */          //背景变白.内容变透明
//        kCGBlendModeDestinationOut,		/* R = D*(1 - Sa) */    //内容变白，背景透明
//        kCGBlendModeDestinationAtop,	/* R = S*(1 - Da) + D*Sa */ //背景变白.内容变透明
//        kCGBlendModeXOR,			/* R = S*(1 - Da) + D*(1 - Sa) */   //别的颜色变白
//        kCGBlendModePlusDarker,		/* R = MAX(0, (1 - D) + (1 - S)) */     //半透明水印
//        kCGBlendModePlusLighter

//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return resultImage;
//}
//

////返回旋转角度
//-(CATransform3D)rotateTransform:(CATransform3D)initialTransform clockwise:(BOOL)clockwise  andJD:(float)jd
//{
//    CGFloat arg = jd;
//    if(!clockwise){
//        arg *= -1;
//    }
//    
//    CATransform3D transform = initialTransform;
//    transform = CATransform3DRotate(transform, arg, 0, 0, 1);
//    transform = CATransform3DRotate(transform, 0*M_PI, 0, 1, 0);
//    transform = CATransform3DRotate(transform, 0*M_PI, 1, 0, 0);
//    
//    return transform;
//}

//- (CGFloat)getSize:(UIImage *)image{
//    NSData * imageData = UIImageJPEGRepresentation(image,1);
//    return [imageData length]/1024;
//}
//- (UIImage *)captureImageView:(UIImageView *)imageView{
//    UIImage* image = nil;
//    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 5.0);
//    {
//        [imageView.layer renderInContext: UIGraphicsGetCurrentContext()];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//    }
//    UIGraphicsEndImageContext();
//    if (image != nil) {
//        return image;
//    }
//    return nil;
//}

