% 计算Rand Index。
% cluster_vector：聚类之后得到的簇向量。
% true_cluster_vector：数据的真实簇向量。
function ri = get_RI(cluster_vector, true_cluster_vector)
    m = length(cluster_vector);
    a = get_ss(cluster_vector, true_cluster_vector);
    d = get_dd(cluster_vector, true_cluster_vector);
    ri = (a + d) / (m * (m - 1) / 2);
end

function ss = get_ss(cluster_vector, true_cluster_vector)
    ss = 0;
    for ii = 1:length(cluster_vector)-1
        for jj = ii+1:length(cluster_vector)
            if cluster_vector(ii) == cluster_vector(jj) && true_cluster_vector(ii) == true_cluster_vector(jj)
                ss = ss + 1;
            end
        end
    end
end

function dd = get_dd(cluster_vector, true_cluster_vector)
    dd = 0;
    for ii = 1:length(cluster_vector)-1
        for jj = ii+1:length(cluster_vector)
            if cluster_vector(ii) ~= cluster_vector(jj) && true_cluster_vector(ii) ~= true_cluster_vector(jj)
                dd = dd + 1;
            end
        end
    end
end