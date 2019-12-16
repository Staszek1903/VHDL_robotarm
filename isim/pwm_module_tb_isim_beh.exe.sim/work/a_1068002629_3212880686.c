/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "E:/programowanie/xilinx_projects/project_SW/timer.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1068002629_3212880686_p_0(char *t0)
{
    char t15[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t16;
    unsigned int t17;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3360);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t3 = (t0 + 1512U);
    t4 = *((char **)t3);
    t3 = (t0 + 5368U);
    t5 = (t0 + 1192U);
    t6 = *((char **)t5);
    t5 = (t0 + 5336U);
    t7 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t3, t6, t5);
    if (t7 != 0)
        goto LAB5;

LAB7:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t1 = (t0 + 5368U);
    t4 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t3, t1, 1);
    t5 = (t15 + 12U);
    t16 = *((unsigned int *)t5);
    t17 = (1U * t16);
    t2 = (18U != t17);
    if (t2 == 1)
        goto LAB8;

LAB9:    t6 = (t0 + 3456);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t4, 18U);
    xsi_driver_first_trans_fast(t6);

LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t8 = xsi_get_transient_memory(18U);
    memset(t8, 0, 18U);
    t9 = t8;
    memset(t9, (unsigned char)2, 18U);
    t10 = (t0 + 3456);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t8, 18U);
    xsi_driver_first_trans_fast(t10);
    goto LAB6;

LAB8:    xsi_size_not_matching(18U, t17, 0);
    goto LAB9;

}

static void work_a_1068002629_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(57, ng0);

LAB3:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 3520);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 18U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3376);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1068002629_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1068002629_3212880686_p_0,(void *)work_a_1068002629_3212880686_p_1};
	xsi_register_didat("work_a_1068002629_3212880686", "isim/pwm_module_tb_isim_beh.exe.sim/work/a_1068002629_3212880686.didat");
	xsi_register_executes(pe);
}
