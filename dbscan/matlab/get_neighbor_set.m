% �õ���ǰ���ĵ���ܶȿɴ�ĵ�ļ��ϡ�
% point�����ĵ����š�
% distance_matrix���������m * m��
% core_vector�����ĵ��Ǿ���m * 1��
% epsilon���š�
function neighbor_set = get_neighbor_set(point, distance_matrix, core_vector, epsilon)
    neighbor_set = [];
    core_queue = point;
    core_flag = core_vector;
    while ~isempty(core_queue)
        first = core_queue(1);
        core_queue = core_queue(2:end);
        if  core_flag(first) == 1
            core_flag(first) = 0;
            neighbor_set = union(neighbor_set, first);
            epsilon_set = get_epsilon_set(first, distance_matrix, epsilon);
            core_set = get_core_set_by_epsilon_set(epsilon_set, core_vector);
            not_core_set = get_not_core_set_by_epsilon_set(epsilon_set, core_vector);
            neighbor_set = union(neighbor_set, not_core_set);
            core_queue = union(core_queue, core_set);
        end
    end
end

% �õ�ĳ�����ĵ�Ħ����򼯺ϡ�
function epsilon_set = get_epsilon_set(ii, distance_matrix, epsilon)
    epsilon_set = setdiff(find(distance_matrix(ii, :) <= epsilon), ii);
end

% �Ӧ����򼯺����ҵ����Ķ��󣬹��ɼ��ϡ�
function core_set = get_core_set_by_epsilon_set(epsilon_set, core_vector)
    core_set = epsilon_set(core_vector(epsilon_set) == 1);
end

% �Ӧ����򼯺����ҵ��Ǻ��Ķ��󣬹��ɼ��ϡ�
function not_core_set = get_not_core_set_by_epsilon_set(epsilon_set, core_vector)
    not_core_set = epsilon_set(core_vector(epsilon_set) == 0);
end