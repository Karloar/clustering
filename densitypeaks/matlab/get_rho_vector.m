% �����������
% distance_matrix���������m * m��
% dc��������ֵ��
% kind = 1�� ������ֵ�ķ�����
% kind = 2�� ���ø�˹�˵ķ�����
function rho_vector = get_rho_vector(distance_matrix, dc, kind)
    switch kind
        case 1
            rho_vector = sum(distance_matrix < dc, 2);
        case 2
            rho_vector = sum(exp(-(distance_matrix ./ dc) .^ 2), 2);
    end
    rho_vector = rho_vector - 1;                % ���Խ�����0�����Լ�һ
end