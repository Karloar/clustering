% edit by WangLei

% ��������
clear;
clc;
load('source_data.dat');

% ��������
distance_matrix = squareform(pdist(source_data));
% ȷ��dc
dc = get_dc(distance_matrix, 0.02);   % һ��percentΪ1%-2%
disp(['dc:', num2str(dc)]);
% �������
rho_vector = get_rho_vector(distance_matrix, dc, 2);
% �������
delta_vector = get_delta_vector(distance_matrix, rho_vector, 2);
% ������ͼ
plot(rho_vector, delta_vector, '.');
xlabel('��');ylabel('��');title('Decision Graph');
% �Ӿ���ͼ��ѡȡ������,�õ�������
rect = getrect();
cluster_center = get_cluster_center(rho_vector, delta_vector, rect); % cluster_center������������
cluster_num = length(cluster_center);
disp(['�صĸ�����', num2str(cluster_num)]);
% �����ݽ��з���,�õ����ݵ��λ������
position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center);
% ��ͼ��δȥ������)
color = colormap(jet(cluster_num));
data_color = color(position_vector, :);
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end
% ȥ������,�õ��غ��������ϣ�-1������������
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
xlabel('��');ylabel('��');title('Decision Graph');
subplot(2, 1, 2);
for ii = 1:cluster_num
    cluster = source_data(position_vector == ii, :);
    plot(cluster(:, 1), cluster(:, 2), '.', 'color', color(ii, :));
    hold on;
end

% gama = rho_vector .* delta_vector;
% figure;
% plot(1:length(gama), sort(gama, 1, 'descend'), '.');
