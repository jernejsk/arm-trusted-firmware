#
# Copyright (c) 2017-2021, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

include lib/xlat_tables_v2/xlat_tables.mk
include lib/libfdt/libfdt.mk

AW_PLAT			:=	plat/allwinner

PLAT_INCLUDES		:=	-Iinclude/plat/arm/common/aarch64	\
				-I${AW_PLAT}/common/include		\
				-I${AW_PLAT}/${PLAT}/include

PLAT_BL_COMMON_SOURCES	:=	drivers/ti/uart/${ARCH}/16550_console.S	\
				${XLAT_TABLES_LIB_SRCS}			\
				${AW_PLAT}/common/plat_helpers.S	\
				${AW_PLAT}/common/sunxi_common.c

BL31_SOURCES		+=	drivers/allwinner/axp/common.c		\
				drivers/delay_timer/delay_timer.c	\
				drivers/delay_timer/generic_delay_timer.c \
				plat/common/plat_psci_common.c		\
				${AW_PLAT}/common/sunxi_bl31_setup.c	\
				${AW_PLAT}/${PLAT}/sunxi_idle_states.c	\
				${AW_PLAT}/common/sunxi_pm.c		\
				${AW_PLAT}/${PLAT}/sunxi_power.c	\
				${AW_PLAT}/common/sunxi_security.c	\
				${AW_PLAT}/common/sunxi_topology.c

# By default, attempt to use SCPI to the ARISC management processor. If SCPI
# is not enabled or SCP firmware is not loaded, fall back to a simpler native
# implementation that does not support CPU or system suspend.
#
# If SCP firmware will always be present (or absent), the unused implementation
# can be compiled out.
SUNXI_PSCI_USE_NATIVE	?=	1
SUNXI_PSCI_USE_SCPI	?=	1

$(eval $(call assert_boolean,SUNXI_PSCI_USE_NATIVE))
$(eval $(call assert_boolean,SUNXI_PSCI_USE_SCPI))
$(eval $(call add_define,SUNXI_PSCI_USE_NATIVE))
$(eval $(call add_define,SUNXI_PSCI_USE_SCPI))

ifeq (${SUNXI_PSCI_USE_NATIVE}${SUNXI_PSCI_USE_SCPI},00)
$(error "At least one of SCPI or native PSCI ops must be enabled")
endif

ifeq (${SUNXI_PSCI_USE_NATIVE},1)
BL31_SOURCES		+=	${AW_PLAT}/common/sunxi_cpu_new_ops.c	\
				${AW_PLAT}/common/sunxi_native_pm.c
endif

ifeq (${SUNXI_PSCI_USE_SCPI},1)
BL31_SOURCES		+=	drivers/allwinner/sunxi_msgbox.c	\
				drivers/arm/css/scpi/css_scpi.c		\
				${AW_PLAT}/common/sunxi_scpi_pm.c
endif

SUNXI_SETUP_REGULATORS	?=	1
$(eval $(call assert_boolean,SUNXI_SETUP_REGULATORS))
$(eval $(call add_define,SUNXI_SETUP_REGULATORS))

SUNXI_BL31_IN_DRAM	?=	0
$(eval $(call assert_boolean,SUNXI_BL31_IN_DRAM))

ifeq (${SUNXI_BL31_IN_DRAM},1)
SUNXI_AMEND_DTB		:=	1
$(eval $(call add_define,SUNXI_BL31_IN_DRAM))
endif

SUNXI_AMEND_DTB		?=	0
$(eval $(call assert_boolean,SUNXI_AMEND_DTB))
$(eval $(call add_define,SUNXI_AMEND_DTB))

ifeq (${SUNXI_AMEND_DTB},1)
BL31_SOURCES		+=	common/fdt_fixup.c			\
				${AW_PLAT}/common/sunxi_prepare_dtb.c
endif

# The bootloader is guaranteed to only run on CPU 0 by the boot ROM.
COLD_BOOT_SINGLE_CPU		:=	1

# The traditional U-Boot load address is 160MB into DRAM.
PRELOADED_BL33_BASE		?=	0x4a000000

# The reset vector can be changed for each CPU.
PROGRAMMABLE_RESET_ADDRESS	:=	1

# Allow mapping read-only data as execute-never.
SEPARATE_CODE_AND_RODATA	:=	1

# BL31 gets loaded alongside BL33 (U-Boot) by U-Boot's SPL
RESET_TO_BL31			:=	1

# Most Allwinner SoCs have 4 cores, but not all
PLATFORM_MAX_CPUS_PER_CLUSTER	?=	4
$(eval $(call add_define,PLATFORM_MAX_CPUS_PER_CLUSTER))

# Some Allwinner SoCs have standalone watchdog core
SUNXI_STANDALONE_WATCHDOG	?=	0
$(eval $(call assert_boolean,SUNXI_STANDALONE_WATCHDOG))
$(eval $(call add_define,SUNXI_STANDALONE_WATCHDOG))
