% ����dc��������ֵ��
% distance_matrix���������m * m��
% percent���ٷֱȣ�һ��ȡ0.01-0.02��
function dc=get_dc(distance_matrix, percent)
    [m, ~] = size(distance_matrix);
    all_distance = distance_matrix(logical(triu(ones(size(distance_matrix))) - eye(m)));  % �õ������������������������������Խ��ߣ�
    all_distance = sort(all_distance);
    dc = all_distance(round(length(all_distance) * percent));
end