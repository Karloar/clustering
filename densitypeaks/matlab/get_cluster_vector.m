% 得到没有去除噪声的簇向量。
% distance_matrix：距离矩阵，m * m。
% rho_vector：ρ向量，m * 1。
% delta_vector：δ向量，m * 1。
% cluster_center：簇心向量，k * 1。
function position_vector = get_cluster_vector(distance_matrix, rho_vector, cluster_center)
    cluster_num = length(cluster_center);                                  % 簇的个数
    data_num = length(rho_vector);                                         % 数据个数
    position_vector = zeros(size(rho_vector));                             % 初始化位置向量
    position_vector(cluster_center) = 1:cluster_num;                       % 先分配中心点
    [~, sorted_rho_idx] = sort(rho_vector, 1, 'descend');                  % 将ρ从大到小排列
    for ii = 1:data_num
        if position_vector(sorted_rho_idx(ii)) == 0                        % 未分配的数据点
            temp = zeros(size(cluster_center));                            % 用来存每个簇中离当前点最近的点
            for k = 1:cluster_num
                cl = find(position_vector == k);                           % 取第K个簇
                [~, idx] = min(distance_matrix(sorted_rho_idx(ii), cl));   % 第K个簇中离当前点最近的点在簇中的索引
                temp(k) = cl(idx);                                         
            end
            [~, idx] = min(distance_matrix(sorted_rho_idx(ii), temp));     % 确定离当前点最近的数据点是哪个簇的
            position_vector(sorted_rho_idx(ii)) = idx;                     % 分配
        end
    end 
end
