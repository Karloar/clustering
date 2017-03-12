function err = get_error(cluster_vector, true_cluster_vector)
    err = sum(cluster_vector ~= true_cluster_vector) / length(true_cluster_vector);
end