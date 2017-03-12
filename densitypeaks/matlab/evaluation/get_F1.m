% ����F1ֵ
% cluster_vector������֮��õ��Ĵ�������
% true_cluster_vector�����ݵ���ʵ��������
% kind = 1��macro F1
% kind = 2��micro F1
function f1 = get_F1(cluster_vector, true_cluster_vector, kind)
    p = get_precision(cluster_vector, true_cluster_vector, kind);
    r = get_recall(cluster_vector, true_cluster_vector, kind);
    f1 = 2 * p * r / (p + r);
end