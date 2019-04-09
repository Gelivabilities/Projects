function mi=mutual_information(x,y)
    unique_x=unique(x);
    unique_y=unique(y);
    n_x=size(unique_x,1);
    n_y=size(unique_y,1);
    n=size(x,1);
    mi=0;
    all_data=[x,y];
    for i=1:n_x
        for j=1:n_y
            p_xy=size(all_data(all_data(:,1)==unique_x(i) & all_data(:,2)==unique_y(j),:),1)/n;
            p_x=size(all_data(all_data(:,1)==unique_x(i),:),1)/n;
            p_y=size(all_data(all_data(:,2)==unique_y(j),:),1)/n;
            if p_xy~=0
                mi=mi+p_xy*log(p_xy/(p_x*p_y))/log(2);
            end
        end
    end
end