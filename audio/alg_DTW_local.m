function min_error = alg_DTW_local(p,t)
    DTW = zeros(size(p,2)+1,size(t,2)+1);
    DTW(2:end,1) = Inf;
    DTW(1,2:end) = Inf;
    
    for i = 2:size(p,2)+1
        for j = 2:size(t,2)+1
            dist = d_euclid(p(:,i-1),t(:,j-1));
            DTW(i,j) = dist + min([DTW(i-1,j) DTW(i,j-1) DTW(i-1,j-1)]);
        end
    end
    min_error = DTW(size(p,2)+1,size(t,2)+1);
end