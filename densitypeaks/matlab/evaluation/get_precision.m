% �����׼��
% cluster_vector������֮��õ��Ĵ�������
% true_cluster_vector�����ݵ���ʵ��������
% kind = 1��macro precision����׼��Ϊÿ����Ĳ�׼�ʵľ�ֵ��
% kind = 2��micro precision����׼��Ϊaverage(tp) / (average(tp) + average(fp))��
% �����صı����0��
function p = get_precision(cluster_vector, true_cluster_vector, kind)
    p = 0;
    switch kind
        case 1
            k = 0;
            for ii=0:max(true_cluster_vector)
                if isempty(find(cluster_vector == ii, 1))
                    k = k + 1;
                else
                    tp = get_tp(cluster_vector, true_cluster_vector, ii);
                    fp = get_fp(cluster_vector, true_cluster_vector, ii);
                    p = p + tp / (tp + fp);
                end
            end
            p = p / (max(true_cluster_vector) + 1 - k);
        case 2
            tp = 0;
            fp = 0;
            for ii=0:max(true_cluster_vector)
                tp = tp + get_tp(cluster_vector, true_cluster_vector, ii);
                fp = fp + get_fp(cluster_vector, true_cluster_vector, ii);
            end
            p = tp / (tp + fp);
    end
end

function tp = get_tp(cluster_vector, true_cluster_vector, ii)
    tp = length(find(true_cluster_vector(cluster_vector == ii) == ii));
end

% function fn = get_fn(cluster_vector, true_cluster_vector, ii)
%     fn = length(find(true_cluster_vector(cluster_vector ~= ii) == ii));
% end

function fp = get_fp(cluster_vector, true_cluster_vector, ii)
    fp = length(find(true_cluster_vector(cluster_vector == ii) ~= ii));
end

% function tn = get_tn(cluster_vector, true_cluster_vector, ii)
%     tn = length(find(true_cluster_vector(cluster_vector ~= ii) ~= ii));
% end