//
//  ViewController+Swizzle2.m
//  MultiSwizzle
//
//  Created by MarcusWoo on 06/12/2017.
//  Copyright © 2017 MarcusWoo. All rights reserved.
//

#import "ViewController+Swizzle2.h"
#import <objc/runtime.h>

@implementation ViewController (Swizzle2)

+ (void)load {
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class classname = [self class];
        
        SEL originSelector = @selector(viewDidLoad);
        SEL swizzleSelector = @selector(qz_viewDidLoad2);
        
        Method originMethod = class_getInstanceMethod(classname, originSelector);
        Method swizzleMethod = class_getInstanceMethod(classname, swizzleSelector);
        
        BOOL didAddMethod = class_addMethod(classname, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if (didAddMethod) {
            class_replaceMethod(classname, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzleMethod);
        }
    });
}

- (void)qz_viewDidLoad2 {
    NSLog(@"swizzle 2");
    [self qz_viewDidLoad2];
}

@end
