function cluster_center = get_cluster_center_by_gama(gama_vector, rect)
    gama_lim = rect(2);
    cluster_center = find(gama_vector > gama_lim);
end