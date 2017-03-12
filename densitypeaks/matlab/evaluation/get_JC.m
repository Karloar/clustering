% 计算Jaccard Coefficient。
% cluster_vector：聚类之后得到的簇向量。
% true_cluster_vector：数据的真实簇向量。
function jc = get_JC(cluster_vector, true_cluster_vector)
    a = get_ss(cluster_vector, true_cluster_vector);
    b = get_sd(cluster_vector, true_cluster_vector);
    c = get_ds(cluster_vector, true_cluster_vector);
    jc = a / (a + b + c);
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

function sd = get_sd(cluster_vector, true_cluster_vector)
    sd = 0;
    for ii = 1:length(cluster_vector)-1
        for jj = ii+1:length(cluster_vector)
            if cluster_vector(ii) == cluster_vector(jj) && true_cluster_vector(ii) ~= true_cluster_vector(jj)
                sd = sd + 1;
            end
        end
    end
end

function ds = get_ds(cluster_vector, true_cluster_vector)
    ds = 0;
    for ii = 1:length(cluster_vector)-1
        for jj = ii+1:length(cluster_vector)
            if cluster_vector(ii) ~= cluster_vector(jj) && true_cluster_vector(ii) == true_cluster_vector(jj)
                ds = ds + 1;
            end
        end
    end
end
