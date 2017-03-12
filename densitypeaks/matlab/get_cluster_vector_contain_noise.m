% 得到去除噪声的簇向量，噪声的标号是0。
% distance_matrix：距离矩阵，m * m。
% rho_vector：ρ向量，m * 1。
% dc：距离的阈值。
% cluster_vector：簇心向量，k * 1。
% 如果kind == 1， 则采用密度均值的最大值作为ρb
% 如果kind == 2， 则采用密度的最大值作为ρb
function cluster_noise_vector = get_cluster_vector_contain_noise(distance_matrix, rho_vector, dc, cluster_vector, kind)
    data_num = length(rho_vector);
    cluster_num = max(cluster_vector);
    rho_b = zeros(cluster_num, 1);                                                             % 初始化ρb向量
    for ii = 1:data_num-1
        for jj=ii+1:data_num
            if cluster_vector(ii) ~= cluster_vector(jj) && distance_matrix(ii, jj) < dc       % 数据点不在同一个簇，并且距离小于dc
               switch kind
                   case 1
                       average_rho = (rho_vector(ii) + rho_vector(jj)) / 2;
                   case 2
                       average_rho = max(rho_vector(ii) + rho_vector(jj));
               end
               if average_rho > rho_b(cluster_vector(ii))                                     % 让该簇的ρb是数据点密度均值的最大值
                   rho_b(cluster_vector(ii)) = average_rho;
               end
               if average_rho > rho_b(cluster_vector(jj))
                   rho_b(cluster_vector(jj)) = average_rho;
               end
            end
        end
    end
    for k=1:cluster_num                                                                       % 如果簇中元素个数小于等于1， 它的ρb为0
        if length(find(cluster_vector == k)) <= 1
            rho_b(k) = 0;
        end
    end
    data_rho_b = rho_b(cluster_vector);                                                       % 得到所有数据点的ρb向量
    halo_data_idx = find(rho_vector <= data_rho_b);                                           % 找到密度小于ρb的数据点
    cluster_noise_vector = cluster_vector;
    cluster_noise_vector(halo_data_idx) = zeros(length(halo_data_idx), 1);                    % 将密度小于ρb的数据点放到0簇中，即halo簇中。
end