//
//  HSAnnotation.m
//  customUserView（自定义大头针）
//
//  Created by devzkn on 06/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HSAnnotation.h"

@implementation HSAnnotation
@synthesize iconImage = _iconImage;

- (UIImage *)iconImage{
    if (_iconImage == nil) {
        _iconImage = [UIImage imageNamed:self.icon];
    }
    return _iconImage;
}

@end
