//
//  HSAnnotation.h
//  customUserView（自定义大头针）
//
//  Created by devzkn on 06/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface HSAnnotation : NSObject <MKAnnotation>

// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong,readonly) UIImage *iconImage;



@end
