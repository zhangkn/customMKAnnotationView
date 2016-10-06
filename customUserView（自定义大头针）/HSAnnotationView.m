//
//  HSAnnotationView.m
//  customUserView（自定义大头针）
//
//  Created by devzkn on 06/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HSAnnotationView.h"
#import "HSAnnotation.h"
@implementation HSAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置自己的属性
        //添加自己的控件
    }
    return self;
}

+ (instancetype)annotationViewWithTableView:(MKMapView *)mapView{
    static NSString *identifier = @"HSAnnotationView";
    HSAnnotationView *tmp = (HSAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (tmp == nil) {
        tmp = [[HSAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:identifier];
    }
    return tmp;
}

+(instancetype)annotationViewWithTableView:(MKMapView *)mapView annotation:(HSAnnotation *)annotation{
    HSAnnotationView *tmp = [self annotationViewWithTableView:mapView];
    tmp.annotation = annotation;
    return tmp;
}

- (void)setAnnotation:(HSAnnotation*)annotation{
    [super setAnnotation:annotation];
    // 处理自己的特性
    self.image = annotation.iconImage;
}

@end
