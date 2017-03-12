% ����Davies-Bouldin Index
% cluster_vector������֮��õ��Ĵ�������
% data��ԭʼ���ݡ�
% kind = 1���ز�����������
% kind = 2���ذ��������� �������0��
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
    % �洢�صı�š�
    cidx = k:max(cluster_vector);
    % ����ÿ���ء�
    for ii=k:max(cluster_vector)
        % �ҵ�������֮��������صı�š�
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

% ���� avg(C)��������������ƽ������
function avgc = get_avgc(c, data)
    c_data = data(c, :);
    c_dist_matrix = squareform(pdist(c_data));
    m = length(c);
    total_dis = sum(c_dist_matrix(logical(triu(ones(size(c_dist_matrix)) - eye(length(c_dist_matrix))))));
    avgc = total_dis / (m * (m - 1) / 2);
end

% ���� dcen(mu1, mu2)���ؼ��Ӧ���ĵ�ľ��롣
function dcen = get_dcen(c1, c2, data)
    mu_1 = mean(data(c1, :), 1);
    mu_2 = mean(data(c2, :), 1);
    dcen = pdist2(mu_1, mu_2);
end