% edit by WangLei

% 加载数据
clear;
clc;
load('source_data.dat');

% 求距离矩阵
distance_matrix = squareform(pdist(source_data));
% 确定dc
dc = get_dc(distance_matrix, 0.02);   % 一般percent为1%-2%
disp(['dc:', num2str(dc)]);
% 求ρ向量
rho_vector = get_rho_vector(distance_matrix, dc, 2);
% 求δ向量
delta_vector = get_delta_vector(distance_matrix, rho_vector, 2);
% 画决策图
plot(rho_vector, delta_vector, '.');
xlabel('ρ');ylabel('δ');title('Decision Graph');
% 从决策图上选取簇中心,得到簇中心
rect = getrect();
cluster_center = get_cluster_center(rho_vector, delta_vector, rect); % cluster_center里是数据索引
cluster_num = length(cluster_center);
disp(['簇的个数：', num2str(cluster_num)]);
% 对数据进行分配,得到数据点的位置向量
position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center);
% 画图（未去除噪声)
color = colormap(jet(cluster_num));
data_color = color(position_vector, :);
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end
% 去除噪声,得到簇和噪声集合：-1就是噪声集合
figure;
noised_position_vector = get_cluster_vector_contain_noise(distance_matrix, rho_vector, dc, position_vector, 1);
for ii = 1:cluster_num
    cluster = source_data(noised_position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end
halo = source_data(noised_position_vector == 0, :);
plot(halo(:, 1), halo(:, 2), 'k.');

figure;
subplot(2, 1, 1);
plot(rho_vector, delta_vector, '.');
xlabel('ρ');ylabel('δ');title('Decision Graph');
subplot(2, 1, 2);
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end

% gama = rho_vector .* delta_vector;
% figure;
% plot(1:length(gama), sort(gama, 1, 'descend'), '.');
