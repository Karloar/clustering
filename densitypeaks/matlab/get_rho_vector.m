% 计算ρ向量。
% distance_matrix：距离矩阵，m * m。
% dc：距离阈值。
% kind = 1， 采用阈值的方法。
% kind = 2， 采用高斯核的方法。
function rho_vector = get_rho_vector(distance_matrix, dc, kind)
    switch kind
        case 1
            rho_vector = sum(distance_matrix < dc, 2);
        case 2
            rho_vector = sum(exp(-(distance_matrix ./ dc) .^ 2), 2);
    end
    rho_vector = rho_vector - 1;                % 主对角线是0，所以减一
end