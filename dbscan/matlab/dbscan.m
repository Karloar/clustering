% edit by karloar
% 2022.3.4
clear;
clc;
data = load('source_data.dat');
distance_matrix = squareform(pdist(data));
epsilon = 0.05;
minpts = 25;
core_vector = get_core_vector(distance_matrix, minpts, epsilon);
cluster_vector = get_cluster_vector(distance_matrix, core_vector, epsilon);

color_map = colormap(jet(max(cluster_vector)));
noise = data(cluster_vector == 0, :);
plot(noise(:, 1), noise(:, 2), 'k.');
hold on;
for i=1:max(cluster_vector)
    c_data = data(cluster_vector == i, :);
    plot(c_data(:, 1), c_data(:, 2), '.', 'Color', color_map(i, :, :), 'markersize', 16);
    hold on;
end
title('minpts = 25, epsilon = 0.05');
% print(1, '-dpng', 'p_dbscan');
% print(1, '-dpng', 'source_data_dbscan');
