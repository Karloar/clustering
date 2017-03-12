% �����ٻ��ʣ���ȫ��)��
% cluster_vector������֮��õ��Ĵ�������
% true_cluster_vector�����ݵ���ʵ��������
% kind = 1��macro recall���ٻ���Ϊÿ������ٻ��ʵľ�ֵ��
% kind = 2��micro recall���ٻ���Ϊaverage(tp) / (average(tp) + average(fn))��
% �����صı����0��
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