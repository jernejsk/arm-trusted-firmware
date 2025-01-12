#
# Copyright (c) 2025, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

include drivers/arm/gic/v2/gicv2.mk

BL31_SOURCES		+=	${GICV2_SOURCES}			\
				lib/cpus/${ARCH}/cortex_a53.S		\
				plat/common/plat_gicv2.c		\
				${AW_PLAT}/common/sunxi_gicv2.c

# Do not enable SPE (not supported on ARM v8.0).
ENABLE_SPE_FOR_NS		:=	0

# Do not enable SVE (not supported on ARM v8.0).
ENABLE_SVE_FOR_NS		:=	0

# Enable workarounds for Cortex-A53 errata. Allwinner uses at least r0p4.
ERRATA_A53_835769		:=	1
ERRATA_A53_843419		:=	1
ERRATA_A53_855873		:=	1
ERRATA_A53_1530924		:=	1

# This platform is single-cluster and does not require coherency setup.
WARMBOOT_ENABLE_DCACHE_EARLY	:=	1
