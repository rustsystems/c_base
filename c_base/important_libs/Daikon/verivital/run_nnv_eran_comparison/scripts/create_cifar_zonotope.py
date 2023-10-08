# Author: Xiaodong Yang, 04/19/2020

import os

class cifar_zonotope:

    def __init__(self, raw_image, threshold, epsilon, filename):

        self.image = raw_image/255
        self.threshold = threshold/255
        self.epsilon = epsilon
        self.filename = filename
        self.pixels = self.valid_pixels()


    def normalize_channel(self, val, c):

        means = [0.4914, 0.4822, 0.4465]
        stds = [0.2023, 0.1994, 0.201]

        return (val-means[c])/stds[c]

    def normalize_epsilon(self, val, c):

        means = [0.4914, 0.4822, 0.4465]
        stds = [0.2023, 0.1994, 0.201]

        return val/stds[c]


    def create_channel_vector(self, channel, dim, total_length, c):
        current_epsilon = self.epsilon
        new_channel = channel
        if channel < self.epsilon:
            current_epsilon = (self.epsilon + channel) / 2
            new_channel = current_epsilon
        elif channel > (1 - self.epsilon):
            current_epsilon = (self.epsilon + (1 - channel)) / 2
            new_channel = 1 - current_epsilon

        norm_channel = self.normalize_channel(new_channel, c)
        norm_epsilon = self.normalize_epsilon(current_epsilon, c)
        vector = str(norm_channel) + ' '
        for i in range(total_length):
            if i == dim:
                vector += str(norm_epsilon) + ' '
            else:
                vector += '0 '

        return vector + '\n'


    def valid_pixels(self):
        pixels = []
        for i in range(int(len(self.image)/3)):
            dim = i * 3
            red, green, blue = self.image[dim], self.image[dim + 1], self.image[dim + 2]
            if red >= self.threshold or green >= self.threshold or blue >= self.threshold:
                pixels.append(i)

        return pixels


    def create_cifar_zonotope(self, dependent):
        zonotope = open(self.filename, 'w+')
        temp_str = str()

        if dependent:
            total_length = len(self.pixels)
            for i in range(int(len(self.image)/3)):
                dim =i*3
                red, green, blue = self.image[dim], self.image[dim+1],self.image[dim+2]
                if i in self.pixels:
                    j = self.pixels.index(i)
                    red_vector = self.create_channel_vector(red, j*3, total_length, 0)
                    green_vector = self.create_channel_vector(green, j*3, total_length, 1)
                    blue_vector = self.create_channel_vector(blue, j*3, total_length, 2)
                else:
                    red_vector = self.create_channel_vector(red, -1, total_length, 0)
                    green_vector = self.create_channel_vector(green, -1, total_length, 1)
                    blue_vector = self.create_channel_vector(blue, -1, total_length, 2)

                temp_str += red_vector
                temp_str += green_vector
                temp_str += blue_vector
        else:
            total_length = len(self.pixels)*3
            for i in range(int(len(self.image)/3)):
                dim = i * 3
                red, green, blue = self.image[dim], self.image[dim + 1], self.image[dim + 2]
                if i in self.pixels:
                    j = self.pixels.index(i)
                    red_vector = self.create_channel_vector(red, j*3, total_length, 0)
                    green_vector = self.create_channel_vector(green, j*3+1, total_length, 1)
                    blue_vector = self.create_channel_vector(blue, j*3+2, total_length, 2)
                else:
                    red_vector = self.create_channel_vector(red, -1, total_length, 0)
                    green_vector = self.create_channel_vector(green, -1, total_length, 1)
                    blue_vector = self.create_channel_vector(blue, -1, total_length, 2)

                temp_str += red_vector
                temp_str += green_vector
                temp_str += blue_vector

        first_line = str(len(self.image)) + ' ' + str(1+total_length) + '\n'
        zonotope.write(first_line+temp_str)
        zonotope.close()


def create_zontopes(images, labels, epsilons, threshold, pixels_dependent):

    for i in range(len(epsilons)):
        epsilon = epsilons[i]
        path = '../logs/zonotope_inputs' + str(i)
        if not os.path.isdir(path):
            os.mkdir(path)
        path_eran = '../logs/eran' + str(i)
        if not os.path.isdir(path_eran):
            os.mkdir(path_eran)
        path_nnv = '../logs/nnv' + str(i)
        if not os.path.isdir(path_nnv):
            os.mkdir(path_nnv)

        for j in range(images.shape[0]):
            image = images[j]
            filename = path + '/input_' + str(j)
            zonotope = cifar_zonotope(image, threshold, epsilon, filename)
            zonotope.create_cifar_zonotope(pixels_dependent)
