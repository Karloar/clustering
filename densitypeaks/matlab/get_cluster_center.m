% ������ġ�
% rho_vector����������m * 1��
% delta_vector����������m * 1��
% rect��getrect�����ķ���ֵ��
function cluster_center = get_cluster_center(rho_vector, delta_vector, rect)
    cluster_center = intersect(find(rho_vector > rect(1)), find(delta_vector > rect(2))); % intersect�����󽻼�
end