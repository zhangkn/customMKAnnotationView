//
//  ViewController.m
//  customUserView（自定义大头针）
//
//  Created by devzkn on 06/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "HSAnnotation.h"
#import "HSAnnotationView.h"
#define IOS8 [[UIDevice currentDevice].systemVersion floatValue]>= 8.0
@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *customMapView;
@property (nonatomic,strong)  CLLocationManager *locationManager;
/** 地理编码对象*/
@property (nonatomic,strong)  CLGeocoder *geocoder;




@end

@implementation ViewController

- (CLGeocoder *)geocoder{
    if (nil == _geocoder) {
        CLGeocoder *tmpView = [[CLGeocoder alloc]init];
        _geocoder = tmpView;
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager{
    if (nil == _locationManager) {
        CLLocationManager *tmpView = [[CLLocationManager alloc]init];
        
        _locationManager = tmpView;
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //兼容iOS8
    if (IOS8) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.customMapView setMapType:MKMapTypeStandard];//设置地图类型
    self.customMapView.delegate = self;
    self.customMapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;//设置大头针
    [self.customMapView setRotateEnabled:NO];//设置不允许地图旋转
    
  
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //添加大头针模型
    HSAnnotation *annotation = [[HSAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(37.785834+arc4random_uniform(20), 116.858776+arc4random_uniform(20));
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark  = [placemarks firstObject];
        annotation.title =placeMark.name;
        annotation.subtitle = placeMark.locality;
    }];
    annotation.icon = [NSString stringWithFormat:@"category_%d",arc4random_uniform(4)+1];
    [self.customMapView addAnnotation:annotation];
    
}


- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    /** 设置大头针的一些基本信息*/
    //修改大头针视图模型
    
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark  = [placemarks firstObject];
        userLocation.title =placeMark.name;
        userLocation.subtitle = placeMark.locality;
    }];
    //兼容iOS7
    //让地图自动显示当前位置
    mapView.centerCoordinate = userLocation.location.coordinate;//设置地图的中心点
    MKCoordinateRegion region = MKCoordinateRegionMake(mapView.centerCoordinate, MKCoordinateSpanMake(0.038258, 0.038258));
    [mapView setRegion: region animated:YES];//显示的区域
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"latitudeDelta: %f , longitudeDelta:%f", self.customMapView.region.span.latitudeDelta,self.customMapView.region.span.longitudeDelta);
}

/** 定义 MKAnnotationView 的细节*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (![annotation isKindOfClass:[HSAnnotation class]]) {// 过滤掉MKUserLocation
        return nil;
    }
    HSAnnotationView  *annotationView = [HSAnnotationView annotationViewWithTableView:mapView annotation:annotation];
    return annotationView;
}


@end
