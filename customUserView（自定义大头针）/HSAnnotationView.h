//
//  HSAnnotationView.h
//  customUserView（自定义大头针）
//
//  Created by devzkn on 06/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <MapKit/MapKit.h>
@class HSAnnotation;
@interface HSAnnotationView : MKAnnotationView

//自定义视图的现实的数据来源于模型，即使用模型装配自定义视图的显示内容
//@property (nonatomic,strong) <#ModelClass#> *<#ModelName#>;//视图对应的模型，是视图提供给外界的接口

+ (instancetype)annotationViewWithTableView:(MKMapView *) mapView;//使用类方法加载xib

/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype)annotationViewWithTableView:(MKMapView *) mapView  annotation:(HSAnnotation*)annotation;//使用类方法加载xib


@end
