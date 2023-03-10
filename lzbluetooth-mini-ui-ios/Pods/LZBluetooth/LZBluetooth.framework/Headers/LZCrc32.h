//
//  LZCrc32.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/9.
//

#ifndef LZCrc32_h
#define LZCrc32_h

#include <stdio.h>

uint32_t lz_crc32_calculate(uint8_t *buf, uint32_t len);
uint32_t lz_crc32_calculate_with_previous_value(uint32_t crc, uint8_t* buf, uint32_t len);
uint32_t *lz_crc32_get_table(void);



#endif /* LZCrc32_h */
