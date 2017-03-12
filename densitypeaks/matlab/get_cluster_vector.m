% �õ�û��ȥ�������Ĵ�������
% distance_matrix���������m * m��
% rho_vector����������m * 1��
% delta_vector����������m * 1��
% cluster_center������������k * 1��
function position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center)
    cluster_num = length(cluster_center);                                  % �صĸ���
    data_num = length(rho_vector);                                         % ���ݸ���
    position_vector = zeros(size(rho_vector));                             % ��ʼ��λ������
    position_vector(cluster_center) = 1:cluster_num;                       % �ȷ������ĵ�
    [~, sorted_rho_idx] = sort(rho_vector, 1, 'descend');                  % ���ѴӴ�С����
    for ii = 1:data_num
        if position_vector(sorted_rho_idx(ii)) == 0                        % δ��������ݵ�
            temp = zeros(size(cluster_center));                            % ������ÿ�������뵱ǰ������ĵ�
            for k = 1:cluster_num
                cl = find(position_vector == k);                           % ȡ��K����
                [~, idx] = min(distance_matrix(sorted_rho_idx(ii), cl));   % ��K�������뵱ǰ������ĵ��ڴ��е�����
                temp(k) = cl(idx);                                         
            end
            [~, idx] = min(distance_matrix(sorted_rho_idx(ii), temp));     % ȷ���뵱ǰ����������ݵ����ĸ��ص�
            position_vector(sorted_rho_idx(ii)) = idx;                     % ����
        end
    end 
end
