% ������ĵ��Ǿ���
% distance_matrix��������� m * m��
% minpts��Minpts��
% epsilon���š�
function core_vector = get_core_vector(distance_matrix, minpts, epsilon)
    core_vector = zeros(length(distance_matrix), 1);
    core_vector(sum(distance_matrix <= epsilon, 2) - 1 >= minpts) = 1;
end