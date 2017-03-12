% 得到DBSCAN聚类之后的向量。
% distance_matrix：距离矩阵，m * m。
% core_vector：核心点标记向量， m * 1。
% epsilon：ε。
function cluster_vector = get_cluster_vector(distance_matrix, core_vector, epsilon)
    cluster_vector = zeros(length(distance_matrix), 1);
    cluster_num = 1;
    core_point = find(core_vector == 1);
    for ii=1:length(core_point)
        if cluster_vector(core_point(ii)) == 0
            neighbor_set = get_neighbor_set(core_point(ii), distance_matrix, core_vector, epsilon);
            cluster_vector(neighbor_set) = cluster_num;
            cluster_num = cluster_num + 1;
        end
    end
end
