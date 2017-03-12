% 计算δ。
% distance_matrix：距离矩阵，m * m。
% rho_vector：ρ向量，m * 1。
% kind = 1，ρ最大的数据点的δ为离该点最远的点到它的距离，这是论文里的计算方法。
% kind = 2，ρ最大的数据点的δ为其余ρ的δ中的最大值，这是代码的计算方法。
function delta_vector = get_delta_vector(distance_matrix, rho_vector, kind)
    delta_vector = zeros(size(rho_vector));
    [~, rho_idx] = sort(rho_vector);                       % 将ρ从小到大排序得到索引
    for ii = 1:length(rho_idx)-1
        temp_distance = zeros(length(rho_idx) - ii, 1);    % 存储比当前的点密度大的点到该点的距离
        for jj = ii+1:length(rho_idx)
            temp_distance(jj-ii) = distance_matrix(rho_idx(ii), rho_idx(jj));
        end
        delta_vector(rho_idx(ii)) = min(temp_distance);    % 确定当前点的δ
    end
    % 确定密度最大点的δ
    switch kind
        case 1
            delta_vector(rho_idx(end)) = max(distance_matrix(rho_idx(end), :));
        case 2
            delta_vector(rho_idx(end)) = max(delta_vector);
    end
end