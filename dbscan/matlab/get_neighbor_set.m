% 得到当前核心点的密度可达的点的集合。
% point：核心点的序号。
% distance_matrix：距离矩阵，m * m。
% core_vector：核心点标记矩阵，m * 1。
% epsilon：ε。
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

% 得到某个核心点的ε邻域集合。
function epsilon_set = get_epsilon_set(ii, distance_matrix, epsilon)
    epsilon_set = setdiff(find(distance_matrix(ii, :) <= epsilon), ii);
end

% 从ε邻域集合中找到核心对象，构成集合。
function core_set = get_core_set_by_epsilon_set(epsilon_set, core_vector)
    core_set = epsilon_set(core_vector(epsilon_set) == 1);
end

% 从ε邻域集合中找到非核心对象，构成集合。
function not_core_set = get_not_core_set_by_epsilon_set(epsilon_set, core_vector)
    not_core_set = epsilon_set(core_vector(epsilon_set) == 0);
end