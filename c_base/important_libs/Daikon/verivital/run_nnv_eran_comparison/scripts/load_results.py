# Author: Xiaodong Yang 04/19/2020
import os
import numpy as np
import eran_params
import scipy.io as sio

file_eran = '../logging/eran/'
file_nnv = '../logging/nnv/'

# eran
def get_item(start_postion, astr):
    # start_position shoudld be character, and end_position should be ' '
    item = ''
    n = start_postion
    while True:
        if n == len(astr) or astr[n] == ' ':
            break
        else:
            item += astr[n]
        n += 1

    end_position = n
    return item, end_position


def load_results_eran(images_len, epsilons_len):
    all_verified_num, all_verified_idx, all_verified_time = [], [], []
    for i in range(epsilons_len):
        verified_num, verified_time = 0, 0
        for j in range(images_len):
            filename = '../logs/eran' + str(i) +'/results' + str(j) + '.txt'
            f = open(filename, 'r')
            contents = f.readlines()
            f.close()

            for m in range(len(contents)):
                astr = contents[m]
                item, _ = get_item(0, astr)
                if item == 'Verified\n':
                    verified_num += 1
                    break
                elif item == 'Failed\n':
                    break

            next_astr = contents[m + 1]
            t, _ = get_item(6, next_astr)
            verified_time += float(t)

        all_verified_num.append(verified_num)
        all_verified_time.append(verified_time)

    return all_verified_num, all_verified_time


def load_results_nnv(images_len, epsilons_len):
    all_verified_num = []
    all_verified_time = []
    for i in range(epsilons_len):
        filename = '../logs/nnv' + str(i) + '/results.mat'
        results = sio.loadmat(filename, mat_dtype=True)['results'][0][0]
        total_verified = results[2]
        total_time = results[3]
        all_verified_num.append(total_verified)
        all_verified_time.append(total_time)

    return all_verified_num, all_verified_time


_, images, _, epsilons, _, _, _ = eran_params.set_eran_params()
verified_num_eran, verified_time_eran = load_results_eran(len(images), len(epsilons))
verified_num_nnv, verified_time_nnv = load_results_nnv(len(images), len(epsilons))

print('\n\n')
for n in range(len(epsilons)):
    print('Epsilon: ', epsilons[n])
    print('The number of verified images of ERAN: ', verified_num_eran[n], 'out of ', len(images),' images')
    print('The total runing time of ERAN: %.2f' %verified_time_eran[n], ' seconds')
    print('The number of verified images of NNV: ', int(verified_num_nnv[n][0][0]), 'out of ', len(images),' images')
    print('The total runing time of NNV: %.2f' %verified_time_nnv[n][0][0], ' seconds')
    print('\n')

