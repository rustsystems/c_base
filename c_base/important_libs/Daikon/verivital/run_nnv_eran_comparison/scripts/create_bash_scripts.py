# Author: Xiaodong Yang 04/19/2020
import numpy as np
import eran_params
import create_cifar_zonotope as ccz
import os


def create_bash_eran(model_name, images_len, epsilons_len, domain):
    filename = 'eran_scripts.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=1h \ncd ERAN/tf_verify \n'

    for i in range(epsilons_len):
        for j in range(images_len):
            line_temp = 'SECONDS=0\n'
            line_temp += 'timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/' + model_name + \
                        '  --zonotope=../../logs/zonotope_inputs' + str(i) + '/input_' + str(j) + '  --domain=' + domain + ' 2>&1 | tee ../../logs/eran' + str(i) +'/results' + str(j) + '.txt\n'

            line_temp += 'echo \"Time: $SECONDS  \" ' + ' >> ../../logs/eran' + str(i) +'/results' + str(j) + '.txt\n'
            lines += line_temp

        lines += '\n\n'

    lines += 'cd ../../'
    f.write(lines)
    f.close()

def create_bash_nnv(images_len, epsilons_len):
    filename = 'nnv_scripts.sh'
    f = open(filename, 'w')
    lines = '#!/bin/bash\n\nTIMEOUT=1h \n\ntimeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r \'run ' + 'scripts/fn_imagestar(' + str(
        images_len) + ',' + str(epsilons_len) + ');clear;'

    lines = lines + 'quit\''
    f.write(lines)
    f.close()

model_name, images, labels, epsilons, threshold, domain, pixels_dependent = eran_params.set_eran_params()
ccz.create_zontopes(images, labels, epsilons, threshold, pixels_dependent)
create_bash_eran(model_name, len(images), len(epsilons), domain)
create_bash_nnv(len(images), len(epsilons))
