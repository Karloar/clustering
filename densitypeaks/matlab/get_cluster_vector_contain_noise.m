% �õ�ȥ�������Ĵ������������ı����0��
% distance_matrix���������m * m��
% rho_vector����������m * 1��
% dc���������ֵ��
% cluster_vector������������k * 1��
% ���kind == 1�� ������ܶȾ�ֵ�����ֵ��Ϊ��b
% ���kind == 2�� ������ܶȵ����ֵ��Ϊ��b
function cluster_noise_vector = get_cluster_vector_contain_noise(distance_matrix, rho_vector, dc, cluster_vector, kind)
    data_num = length(rho_vector);
    cluster_num = max(cluster_vector);
    rho_b = zeros(cluster_num, 1);                                                             % ��ʼ����b����
    for ii = 1:data_num-1
        for jj=ii+1:data_num
            if cluster_vector(ii) ~= cluster_vector(jj) && distance_matrix(ii, jj) < dc       % ���ݵ㲻��ͬһ���أ����Ҿ���С��dc
               switch kind
                   case 1
                       average_rho = (rho_vector(ii) + rho_vector(jj)) / 2;
                   case 2
                       average_rho = max(rho_vector(ii) + rho_vector(jj));
               end
               if average_rho > rho_b(cluster_vector(ii))                                     % �øôصĦ�b�����ݵ��ܶȾ�ֵ�����ֵ
                   rho_b(cluster_vector(ii)) = average_rho;
               end
               if average_rho > rho_b(cluster_vector(jj))
                   rho_b(cluster_vector(jj)) = average_rho;
               end
            end
        end
    end
    for k=1:cluster_num                                                                       % �������Ԫ�ظ���С�ڵ���1�� ���Ħ�bΪ0
        if length(find(cluster_vector == k)) <= 1
            rho_b(k) = 0;
        end
    end
    data_rho_b = rho_b(cluster_vector);                                                       % �õ��������ݵ�Ħ�b����
    halo_data_idx = find(rho_vector <= data_rho_b);                                           % �ҵ��ܶ�С�ڦ�b�����ݵ�
    cluster_noise_vector = cluster_vector;
    cluster_noise_vector(halo_data_idx) = zeros(length(halo_data_idx), 1);                    % ���ܶ�С�ڦ�b�����ݵ�ŵ�0���У���halo���С�
end