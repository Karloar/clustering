% 计算召回率（查全率)。
% cluster_vector：聚类之后得到的簇向量。
% true_cluster_vector：数据的真实簇向量。
% kind = 1：macro recall，召回率为每个类的召回率的均值。
% kind = 2：micro recall，召回率为average(tp) / (average(tp) + average(fn))。
% 噪声簇的标号是0。
function r = get_recall(cluster_vector, true_cluster_vector, kind)
    r = 0;
    switch kind
        case 1
            k = 0;
            for ii=0:max(true_cluster_vector)
                if isempty(find(cluster_vector == ii, 1))
                    k = k + 1;
                else
                    tp = get_tp(cluster_vector, true_cluster_vector, ii);
                    fn = get_fn(cluster_vector, true_cluster_vector, ii);
                    r = r + tp / (tp + fn);
                end
            end
            r = r / (max(true_cluster_vector) + 1 - k);
        case 2
            tp = 0;
            fn = 0;
            for ii=0:max(true_cluster_vector)
                tp = tp + get_tp(cluster_vector, true_cluster_vector, ii);
                fn = fn + get_fn(cluster_vector, true_cluster_vector, ii);
            end
            r = tp / (tp + fn);
    end
end

function tp = get_tp(cluster_vector, true_cluster_vector, ii)
    tp = length(find(true_cluster_vector(cluster_vector == ii) == ii));
end

function fn = get_fn(cluster_vector, true_cluster_vector, ii)
    fn = length(find(true_cluster_vector(cluster_vector ~= ii) == ii));
end

% function fp = get_fp(cluster_vector, true_cluster_vector, ii)
%     fp = length(find(true_cluster_vector(cluster_vector == ii) ~= ii));
% end

% function tn = get_tn(cluster_vector, true_cluster_vector, ii)
%     tn = length(find(true_cluster_vector(cluster_vector ~= ii) ~= ii));
% end