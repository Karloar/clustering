% edit by WangLei

% 加载数据
clear;
clc;
load('source_data.dat');

% 求距离矩阵
distance_matrix = dist(source_data');
% 确定dc
dc = get_dc(distance_matrix, 0.02);   % 一般percent为1%-2%
disp(['dc:', num2str(dc)]);
% 求ρ向量
rho_vector = get_rho_vector(distance_matrix, dc, 2);
% 求δ向量
delta_vector = get_delta_vector(distance_matrix, rho_vector, 2);
% 求γ向量
gama_vector = get_gama_vector(rho_vector, delta_vector);
sorted_gama = sort(gama_vector, 1, 'descend');
% 画γ向量的决策图
figure;
plot(1:length(sorted_gama), sorted_gama, '.', 'markersize', 20);
ylabel('γ'); 

% 取γ下限
rect = getrect();

% 得到簇心
cluster_center = get_cluster_center_by_gama(gama_vector, rect);

cluster_num = length(cluster_center);
disp(['簇的个数:', num2str(cluster_num)]);

% 对数据进行分配,得到数据点的位置向量
position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center);
% 画图（未去除噪声)
color = colormap(jet(cluster_num));
data_color = color(position_vector, :);
figure;
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end
plot(source_data(cluster_center, 1), source_data(cluster_center, 2), 'k.', 'markersize', 20);
title('聚类后的数据点');

% 画γ图，聚类完毕
figure;
plot(1:length(sorted_gama), sorted_gama, 'k.', 'markersize', 20);
ylabel('γ'); 
hold on;
for ii = 1:cluster_num
    gg = gama_vector(cluster_center(ii));
    plot(find(sorted_gama == gg, 1), gg, '.', 'color', color(ii, :), 'markersize', 20);
    hold on;
end
title('聚类后的γ图');

% 画聚类完毕的决策图
figure;
plot(rho_vector, delta_vector, 'k.', 'markersize', 20);
hold on;
for ii = 1:cluster_num
    plot(rho_vector(cluster_center(ii)), delta_vector(cluster_center(ii)), '.', 'color', color(ii, :), 'markersize', 20);
    hold on;
end
title('聚类后的决策图');