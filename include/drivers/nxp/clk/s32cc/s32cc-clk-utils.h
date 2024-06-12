/* SPDX-License-Identifier: BSD-3-Clause */
/*
 * Copyright 2024 NXP
 */
#ifndef S32CC_CLK_UTILS_H
#define S32CC_CLK_UTILS_H

#include <s32cc-clk-modules.h>

struct s32cc_clk *s32cc_get_clk_from_table(const struct s32cc_clk_array *const *clk_arr,
					   size_t size,
					   unsigned long clk_id);

struct s32cc_clk *s32cc_get_arch_clk(unsigned long id);

#endif /* S32CC_CLK_UTILS_H */
