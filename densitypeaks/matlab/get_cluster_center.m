% 计算簇心。
% rho_vector：ρ向量，m * 1。
% delta_vector：δ向量，m * 1。
% rect：getrect函数的返回值。
function cluster_center = get_cluster_center(rho_vector, delta_vector, rect)
    cluster_center = intersect(find(rho_vector > rect(1)), find(delta_vector > rect(2))); % intersect函数求交集
end