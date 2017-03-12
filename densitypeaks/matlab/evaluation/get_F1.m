% 计算F1值
% cluster_vector：聚类之后得到的簇向量。
% true_cluster_vector：数据的真实簇向量。
% kind = 1：macro F1
% kind = 2：micro F1
function f1 = get_F1(cluster_vector, true_cluster_vector, kind)
    p = get_precision(cluster_vector, true_cluster_vector, kind);
    r = get_recall(cluster_vector, true_cluster_vector, kind);
    f1 = 2 * p * r / (p + r);
end