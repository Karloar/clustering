% edit by WangLei

% ��������
clear;
clc;
load('source_data.dat');

% ��������
distance_matrix = dist(source_data');
% ȷ��dc
dc = get_dc(distance_matrix, 0.02);   % һ��percentΪ1%-2%
disp(['dc:', num2str(dc)]);
% �������
rho_vector = get_rho_vector(distance_matrix, dc, 2);
% �������
delta_vector = get_delta_vector(distance_matrix, rho_vector, 2);
% �������
gama_vector = get_gama_vector(rho_vector, delta_vector);
sorted_gama = sort(gama_vector, 1, 'descend');
% ���������ľ���ͼ
figure;
plot(1:length(sorted_gama), sorted_gama, '.', 'markersize', 20);
ylabel('��'); 

% ȡ������
rect = getrect();

% �õ�����
cluster_center = get_cluster_center_by_gama(gama_vector, rect);

cluster_num = length(cluster_center);
disp(['�صĸ���:', num2str(cluster_num)]);

% �����ݽ��з���,�õ����ݵ��λ������
position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center);
% ��ͼ��δȥ������)
color = colormap(jet(cluster_num));
data_color = color(position_vector, :);
figure;
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end
plot(source_data(cluster_center, 1), source_data(cluster_center, 2), 'k.', 'markersize', 20);
title('���������ݵ�');

% ����ͼ���������
figure;
plot(1:length(sorted_gama), sorted_gama, 'k.', 'markersize', 20);
ylabel('��'); 
hold on;
for ii = 1:cluster_num
    gg = gama_vector(cluster_center(ii));
    plot(find(sorted_gama == gg, 1), gg, '.', 'color', color(ii, :), 'markersize', 20);
    hold on;
end
title('�����Ħ�ͼ');

% ��������ϵľ���ͼ
figure;
plot(rho_vector, delta_vector, 'k.', 'markersize', 20);
hold on;
for ii = 1:cluster_num
    plot(rho_vector(cluster_center(ii)), delta_vector(cluster_center(ii)), '.', 'color', color(ii, :), 'markersize', 20);
    hold on;
end
title('�����ľ���ͼ');