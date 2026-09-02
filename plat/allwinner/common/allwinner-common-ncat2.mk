#
# Copyright (c) 2026, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

# Everything the NCAT2 generation shares, whichever cores it was built from:
# each core sits in its own power domain, behind a GIC-600, in one cluster
# that is coherent in hardware.

ifeq (${SUNXI_PSCI_USE_NATIVE},1)
BL31_SOURCES		+=	${AW_PLAT}/common/sunxi_native_pm_ncat2.c
endif

USE_GIC_DRIVER			:=	3
GICV3_SUPPORT_GIC600		:=	1

# ARISC SCP not yet supported
SUNXI_PSCI_USE_SCPI		:=	0

USE_COHERENT_MEM		:=	0
WARMBOOT_ENABLE_DCACHE_EARLY	:=	1
HW_ASSISTED_COHERENCY		:=	1
