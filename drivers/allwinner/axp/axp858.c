/*
 * Copyright (c) 2019, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <drivers/allwinner/axp.h>

const uint8_t axp_chip_id = AXP858_CHIP_ID;
const char *const axp_compatible = "x-powers,axp858";

#if SUNXI_SETUP_REGULATORS == 1
const struct axp_regulator axp_regulators[] = {
	{"dcdc1",   1500, 3400, 100, NA, 0x13, 0x10, 0},
	{"dcdc2",    500, 1540,  10, 70, 0x14, 0x10, 1},
	{"dcdc3",    500, 1540,  10, 70, 0x15, 0x10, 2},
	{"dcdc4",    500, 1540,  10, 70, 0x16, 0x10, 3},
	{"dcdc5",    800, 1840,  10, 32, 0x17, 0x10, 4},
	{"dcdc6",   1500, 3400, 100, NA, 0x18, 0x10, 5},
	{"aldo1",    700, 3300, 100, NA, 0x19, 0x11, 0},
	{"aldo2",    700, 3300, 100, NA, 0x20, 0x11, 1},
	{"aldo3",    700, 3300, 100, NA, 0x21, 0x11, 2},
	{"aldo4",    700, 3300, 100, NA, 0x22, 0x11, 3},
	{"aldo5",    700, 3300, 100, NA, 0x23, 0x11, 4},
	{"bldo1",    700, 3300, 100, NA, 0x24, 0x11, 5},
	{"bldo2",    700, 3300, 100, NA, 0x25, 0x11, 6},
	{"bldo3",    700, 3300, 100, NA, 0x26, 0x11, 7},
	{"bldo4",    700, 3300, 100, NA, 0x27, 0x12, 0},
	{"bldo5",    700, 3300, 100, NA, 0x28, 0x12, 1},
	{"cldo1",    700, 3300, 100, NA, 0x29, 0x12, 2},
	{"cldo2",    700, 3300, 100, NA, 0x2a, 0x12, 3},
	{"cldo3",    700, 3300, 100, NA, 0x2b, 0x12, 4},
	{"cldo4",    700, 4200, 100, NA, 0x2d, 0x12, 5},
	{"cpusldo",  700, 1400,  50, NA, 0x2e, 0x12, 6},
	{"sw",        NA,   NA,  NA, NA,   NA, 0x12, 7},
	{}
};
#endif
