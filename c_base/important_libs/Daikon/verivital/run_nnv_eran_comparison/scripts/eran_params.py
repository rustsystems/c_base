# Author: Xiaodong Yang 04/19/2020
# params for eran
from numpy import genfromtxt

def set_eran_params():
    model_name = 'cifar_conv_maxpool.pyt'

    images_dir = '../models/classified_images.csv'
    labels_dir = '../models/classified_Labels.csv'
    csvfile_images = open(images_dir, 'r')
    images = genfromtxt(csvfile_images, delimiter=',')
    csvfile_labels = open(labels_dir, 'r')
    labels = genfromtxt(csvfile_labels, delimiter=',')

    epsilons = [0.01, 0.05, 0.10]
    threshold = 200
    domain = 'deepzono'
    pixels_dependent = True
    return model_name, images, labels, epsilons, threshold, domain, pixels_dependent
