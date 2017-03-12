% 计算Davies-Bouldin Index
% cluster_vector：聚类之后得到的簇向量。
% data：原始数据。
% kind = 1：簇不包括噪声。
% kind = 2：簇包括噪声， 噪声标号0。
function dbi = get_DBI(cluster_vector, data, kind)
    k = 0;
    s = 0;
    switch kind
        case 1
            k = 1;
            s = 0;
        case 2
            k = 0;
            s = 1;
    end
    dbi = 0;
    % 存储簇的标号。
    cidx = k:max(cluster_vector);
    % 遍历每个簇。
    for ii=k:max(cluster_vector)
        % 找到除本簇之外的其它簇的标号。
        temp_ci = setdiff(cidx, ii);
        cii = find(cluster_vector == ii);
        ctemp = find(cluster_vector == temp_ci(1));
        max_val = (get_avgc(cii, data) + get_avgc(ctemp, data)) / get_dcen(cii, ctemp, data);
        for jj=2:length(temp_ci)
            ctemp = find(cluster_vector == temp_ci(jj));
            temp_val = (get_avgc(cii, data) + get_avgc(ctemp, data)) / get_dcen(cii, ctemp, data);
            if temp_val > max_val
                max_val = temp_val;
            end
        end
        dbi = dbi + max_val;
    end
    dbi = dbi / (max(cluster_vector) + s);
end

% 计算 avg(C)，即簇内样本的平均距离
function avgc = get_avgc(c, data)
    c_data = data(c, :);
    c_dist_matrix = squareform(pdist(c_data));
    m = length(c);
    total_dis = sum(c_dist_matrix(logical(triu(ones(size(c_dist_matrix)) - eye(length(c_dist_matrix))))));
    avgc = total_dis / (m * (m - 1) / 2);
end

% 计算 dcen(mu1, mu2)，簇间对应中心点的距离。
function dcen = get_dcen(c1, c2, data)
    mu_1 = mean(data(c1, :), 1);
    mu_2 = mean(data(c2, :), 1);
    dcen = pdist2(mu_1, mu_2);
end