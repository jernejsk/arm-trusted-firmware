#
# Copyright 2024 NXP
#
# SPDX-License-Identifier: BSD-3-Clause
#

PLAT_INCLUDES		+= \
	-I${PLAT_DRIVERS_INCLUDE_PATH}/clk/s32cc \

CLK_SOURCES		:= \
	${PLAT_DRIVERS_PATH}/clk/s32cc/s32cc_clk_drv.c \

ifeq (${BL_COMM_CLK_NEEDED},yes)
BL2_SOURCES		+= ${CLK_SOURCES}
endif
