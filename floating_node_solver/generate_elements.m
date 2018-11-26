function elem = generate_elements(conn)
    for i = 1:size(conn,1)
       elem(i).nodes = conn(i,:);
       elem(i).discont = 0;
    end
end