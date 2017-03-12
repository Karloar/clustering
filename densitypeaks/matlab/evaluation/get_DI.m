% 计算Dunn Index。
% cluster_vector：聚类之后得到的簇向量。
% distance_matrix：由数据得到的距离矩阵。
% kind = 1：不包括噪声。
% kind = 2：包括噪声，噪声标号0。
function di = get_DI(cluster_vector, distance_matrix, kind)
    k = 0;
    switch kind
        case 1
            k = 1;
        case 2
            k = 0;
    end
    % 计算最大的diam
    max_diam = get_diam(find(cluster_vector == k), distance_matrix);
    for ii = k+1:max(cluster_vector)
        temp_diam = get_diam(find(cluster_vector == ii), distance_matrix);
        if temp_diam > max_diam
            max_diam = temp_diam;
        end
    end
    % 计算最小的dmin
    min_dmin = get_dmin(find(cluster_vector == k), find(cluster_vector == k + 1), distance_matrix);
    for ii=k:max(cluster_vector)-1
        for jj=ii+1:max(cluster_vector)
            temp_dmin = get_dmin(find(cluster_vector == ii), find(cluster_vector == jj), distance_matrix);
            if temp_dmin < min_dmin
                min_dmin = temp_dmin;
            end
        end
    end
    di = min_dmin / max_diam;
end

% 计算diam，即簇内的最大距离。
function diam = get_diam(c, distance_matrix)
    dist = distance_matrix(c, c);
    diam = max(dist(:));
end

% 计算dmin，即簇间的最小距离。
function dmin = get_dmin(c1, c2, distance_matrix)
    dis = distance_matrix(c1, c2);
    dmin = min(dis(:));
end