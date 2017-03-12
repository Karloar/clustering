% 计算dc，距离阈值。
% distance_matrix：距离矩阵，m * m。
% percent：百分比，一般取0.01-0.02。
function dc=get_dc(distance_matrix, percent)
    [m, ~] = size(distance_matrix);
    all_distance = distance_matrix(logical(triu(ones(size(distance_matrix))) - eye(m)));  % 得到距离矩阵的上三角向量（不包括主对角线）
    all_distance = sort(all_distance);
    dc = all_distance(round(length(all_distance) * percent));
end