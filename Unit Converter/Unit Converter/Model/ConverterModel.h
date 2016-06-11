//
//  ConverterModel.h
//  Unit Converter
//
//  Created by Rahul Kumar Thai Valappil on 25/05/2016.
//  Copyright © 2016 Rahul Kumar Thai Valappil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ConverterType){
    ConverterTypeArea,
    ConverterTypeLength,
    ConverterTypeTemperature,
    ConverterTypeSpeed
};

@interface ConverterModel : NSObject
@property (nonatomic) ConverterType selectedConverterType;
@property (nonatomic) NSArray *convertionTypesArray;
@property (nonatomic) NSDictionary *convertionUnitsDictionary;

-(NSString *)convertTheValue:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit ofConverterType:(ConverterType)converterType;
- (BOOL)isNumeric:(NSString *)inputString;
@end
