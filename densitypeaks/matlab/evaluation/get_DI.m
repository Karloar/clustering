% ����Dunn Index��
% cluster_vector������֮��õ��Ĵ�������
% distance_matrix�������ݵõ��ľ������
% kind = 1��������������
% kind = 2�������������������0��
function di = get_DI(cluster_vector, distance_matrix, kind)
    k = 0;
    switch kind
        case 1
            k = 1;
        case 2
            k = 0;
    end
    % ��������diam
    max_diam = get_diam(find(cluster_vector == k), distance_matrix);
    for ii = k+1:max(cluster_vector)
        temp_diam = get_diam(find(cluster_vector == ii), distance_matrix);
        if temp_diam > max_diam
            max_diam = temp_diam;
        end
    end
    % ������С��dmin
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

% ����diam�������ڵ������롣
function diam = get_diam(c, distance_matrix)
    dist = distance_matrix(c, c);
    diam = max(dist(:));
end

% ����dmin�����ؼ����С���롣
function dmin = get_dmin(c1, c2, distance_matrix)
    dis = distance_matrix(c1, c2);
    dmin = min(dis(:));
end