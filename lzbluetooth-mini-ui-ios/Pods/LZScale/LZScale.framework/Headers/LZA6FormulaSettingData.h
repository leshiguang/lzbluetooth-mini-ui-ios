//
//  LZA6FormulaSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>


#import <LZScale/LZA6Data.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA6Formula) {
    /// 内销公式
    LZA6FormulaNormal,
    /// FDA外销公式
    LZA6FormulaFDA,
};

@interface LZA6FormulaSettingData : LZA6Data

@property (nonatomic, assign) LZA6Formula formula;

@end

NS_ASSUME_NONNULL_END
