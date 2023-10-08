import numpy as np
import os
import batch_config as cfg

def create_bash(p):
    network_n1 = 5
    network_n2 = 9
    # Marabou
    filename = 'run_marabou.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\n'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            line_temp = 'timeout --foreground --signal=SIGQUIT $TIMEOUT ./Marabou/build/Marabou Marabou/resources/nnet/acasxu/ACASXU_experimental_v2a_'\
                        +str(i)+'_'+str(j)+'.nnet Marabou/resources/properties/property_temp'+str(p)+'.txt 2>&1 | tee ' + cfg.path_logs + 'logs_mara/results_p'+str(p)+'_n'+str(i)+str(j)+'.txt\n'
            lines = lines + line_temp

    f.write(lines)
    f.close()

    # Marabou dnc
    filename = 'run_marabou_dnc.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\n'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            line_temp = 'timeout --foreground --signal=SIGQUIT $TIMEOUT ./Marabou/build/Marabou Marabou/resources/nnet/acasxu/ACASXU_experimental_v2a_'\
                        +str(i)+'_'+str(j)+'.nnet Marabou/resources/properties/property_temp'+str(p)+\
                        '.txt --dnc --initial-divides=4 --initial-timeout=5 --num-online-divides=4 --timeout-factor=1.5 --num-workers=8 2>&1 | ' \
                        'tee ' + cfg.path_logs + 'logs_dnc/results_p'+str(p)+'_n'+str(i)+str(j)+'.txt\n'
            lines = lines + line_temp

    f.write(lines)
    f.close()

    # reluval
    filename = 'run_reluval.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\n'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            line_temp = 'timeout --foreground --signal=SIGQUIT $TIMEOUT ./ReluVal/network_test '+str(p)+' ./ReluVal/nnet/ACASXU_run2a_'\
                        +str(i)+'_'+str(j)+'_batch_2000.nnet 0 2>&1 | tee ' + cfg.path_logs + 'logs_reluval/results_p'+str(p)+'_n'+str(i)+str(j)+'.txt \n'
            lines = lines + line_temp

    f.write(lines)
    f.close()

    # nnv star
    filename = 'run_nnv_star.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\ntimeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r \'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/' \
            'verify_P0_N00_star('+str(1)+','+str(1)+');clear;'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            if i==1 and j==1:
                continue
            line_temp = 'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/verify_P0_N00_star('+str(i)+','+str(j)+');clear;'
            lines = lines + line_temp

    lines = lines + 'quit\''
    f.write(lines)
    f.close()

    # nnv abs
    filename = 'run_nnv_abs.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\ntimeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r \'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/' \
            'verify_P0_N00_abs(' + str(1) + ',' + str(1) + ');clear;'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            if i == 1 and j == 1:
                continue
            line_temp = 'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/verify_P0_N00_abs('+str(i)+','+str(j)+');clear;'
            lines = lines + line_temp

    lines = lines + 'quit\''
    f.write(lines)
    f.close()

    # nnv star appr
    filename = 'run_nnv_star_appr.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\ntimeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r \'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/' \
            'verify_P0_N00_star_appr('+str(1)+','+str(1)+');clear;'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            if i == 1 and j == 1:
                continue
            line_temp = 'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/verify_P0_N00_star_appr(' + str(i) + ',' + str(j) + ');clear;'
            lines = lines + line_temp

    lines = lines + 'quit\''
    f.write(lines)
    f.close()


    # nnv star zono
    filename = 'run_nnv_zono.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\ntimeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r \'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/' \
            'verify_P0_N00_zono('+str(1)+','+str(1)+');clear;'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            if i == 1 and j == 1:
                continue
            line_temp = 'run ' + cfg.path_nnv_abs + 'nnv/examples/Submission/CAV2020/verify_P0_N00_zono(' + str(i) + ',' + str(j) + ');clear;'
            lines = lines + line_temp

    lines = lines + 'quit\''
    f.write(lines)
    f.close()

    # reluplex
    filename = 'run_reluplex.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=10h \n\n'
    for i in range(1,network_n1+1):
        for j in range(1,network_n2+1):
            line_temp = 'timeout --foreground --signal=SIGQUIT $TIMEOUT ./ReluplexCav2017/check_properties/bin/property'+str(p)+'.elf ./ReluplexCav2017/nnet/ACASXU_run2a_'+str(i)+'_'+str(j)+'_batch_2000.nnet ' +\
                        cfg.path_logs+'logs_reluplex/property'+str(p)+'_summary.txt 2>&1 | tee '+cfg.path_logs+'logs_reluplex/property'+str(p)+'_stats_'+str(i)+'_'+str(j)+'.txt\n'
            lines = lines + line_temp

    f.write(lines)
    f.close()





