% ����ġ�
% distance_matrix���������m * m��
% rho_vector����������m * 1��
% kind = 1�����������ݵ�Ħ�Ϊ��õ���Զ�ĵ㵽���ľ��룬����������ļ��㷽����
% kind = 2�����������ݵ�Ħ�Ϊ����ѵĦ��е����ֵ�����Ǵ���ļ��㷽����
function delta_vector = get_delta_vector(distance_matrix, rho_vector, kind)
    delta_vector = zeros(size(rho_vector));
    [~, rho_idx] = sort(rho_vector);                       % ���Ѵ�С��������õ�����
    for ii = 1:length(rho_idx)-1
        temp_distance = zeros(length(rho_idx) - ii, 1);    % �洢�ȵ�ǰ�ĵ��ܶȴ�ĵ㵽�õ�ľ���
        for jj = ii+1:length(rho_idx)
            temp_distance(jj-ii) = distance_matrix(rho_idx(ii), rho_idx(jj));
        end
        delta_vector(rho_idx(ii)) = min(temp_distance);    % ȷ����ǰ��Ħ�
    end
    % ȷ���ܶ�����Ħ�
    switch kind
        case 1
            delta_vector(rho_idx(end)) = max(distance_matrix(rho_idx(end), :));
        case 2
            delta_vector(rho_idx(end)) = max(delta_vector);
    end
end