% 计算核心点标记矩阵。
% distance_matrix：距离矩阵， m * m。
% minpts：Minpts。
% epsilon：ε。
function core_vector = get_core_vector(distance_matrix, minpts, epsilon)
    core_vector = zeros(length(distance_matrix), 1);
    core_vector(sum(distance_matrix <= epsilon, 2) - 1 >= minpts) = 1;
end