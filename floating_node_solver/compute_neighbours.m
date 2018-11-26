neighbours = -1*ones(nelm,8);

sur_elem = -1*ones(nnod,4);

for i = 1:nelm
	nodes = conn(i,:);
	for j = 1:length(nodes)
		k = 1;
		while(sur_elem(nodes(j),k) ~= -1)
			k = k+1;
		end
		sur_elem(nodes(j),k) = i;
	end
end

for i = 1:nelm
	nodes = conn(i,:);
	for j = 1:length(nodes)
		for k = 1:size(sur_elem,2)
			if(sur_elem(nodes(j),k) ~= -1 && ~ismember(sur_elem(nodes(j),k),neighbours(i,:)) && sur_elem(nodes(j),k) ~= i)
				l = 1;
				while(neighbours(i,l) ~= -1)
					l = l+1;
				end
				neighbours(i,l) = sur_elem(nodes(j),k);
			end
		end
	end
end