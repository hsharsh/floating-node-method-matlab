function un = update_un_mod(edge,un,dof,xnodes,ynodes)
    if length(find(edge(1,:)==1)) == 2 && length(find(edge(1,:)==-1)) == 2  
        flag = 0;   p = -1; e = -1;
        for i = 1:4
            if edge(1,i) == 1 && edge(1,mod(i,4)+1) == 1  && ~flag
                flag = 1;   p = mod(i,4)+1;
            end
            if edge(1,i) == 1 && edge(1,mod(i+1,4)+1) == 1 && ~flag
                flag = 2;   e = i;
            end
        end
        if flag == 1
            un(dof(3:4)) 	= un(dof(1:2))*(1-edge(2,mod(p+2,4)+1))+un(dof(21:22))*edge(2,mod(p+2,4)+1);
            un(dof(19:20)) 	= un(dof(1:2))*(1-edge(2,mod(p+2,4)+1))+un(dof(21:22))*edge(2,mod(p+2,4)+1);
            un(dof(23:24)) 	= un(dof(21:22))*(1-edge(2,p))+un(dof(15:16))*edge(2,p);
            un(dof(9:10)) 	= un(dof(21:22))*(1-edge(2,p))+un(dof(15:16))*edge(2,p);
        else
            un(dof(3:4)) 	= un(dof(1:2))*(1-edge(2,e))+un(dof(11:12))*edge(2,e);
            un(dof(9:10)) 	= un(dof(1:2))*(1-edge(2,e))+un(dof(11:12))*edge(2,e);
            un(dof(15:16)) 	= un(dof(13:14))*(1-edge(2,mod(e+1,4)+1))+un(dof(7:8))*edge(2,mod(e+1,4)+1);
            un(dof(5:6)) 	= un(dof(13:14))*(1-edge(2,mod(e+1,4)+1))+un(dof(7:8))*edge(2,mod(e+1,4)+1);          
        end                      
    elseif length(find(edge(1,:)==1)) == 3 && length(find(edge(1,:)==2)) == 1
        e = find(edge(1,:)==2);
		un(dof(3:4))	= un(dof(1:2))*(1-edge(2,mod(e+1,4)+1))+un(dof(11:12))*edge(2,mod(e+1,4)+1);
		un(dof(9:10))	= un(dof(1:2))*(1-edge(2,mod(e+1,4)+1))+un(dof(11:12))*edge(2,mod(e+1,4)+1);
		un(dof(13:14))	= un(dof(11:12))*(1-edge(2,mod(e+2,4)+1))+un(dof(21:22))*edge(2,mod(e+2,4)+1);
		un(dof(19:20))	= un(dof(11:12))*(1-edge(2,mod(e+2,4)+1))+un(dof(21:22))*edge(2,mod(e+2,4)+1);
		un(dof(17:18))	= un(dof(21:22))*(1-edge(2,mod(e,4)+1))+un(dof(23:24))*edge(2,mod(e,4)+1);
		un(dof(7:8))	= un(dof(21:22))*(1-edge(2,mod(e,4)+1))+un(dof(23:24))*edge(2,mod(e,4)+1);

		un(dof(5:6))	= un(dof(13:14))*(1-edge(2,e))+un(dof(17:18))*edge(2,e);
		un(dof(15:16))	= un(dof(13:14))*(1-edge(2,e))+un(dof(17:18))*edge(2,e);
       
    elseif length(find(edge(1,:)==1)) == 4
		un(dof(3:4))	= un(dof(1:2))*(1-edge(2,1))+un(dof(11:12))*edge(2,1);
		un(dof(9:10))	= un(dof(1:2))*(1-edge(2,1))+un(dof(11:12))*edge(2,1);
		un(dof(13:14))	= un(dof(11:12))*(1-edge(2,2))+un(dof(21:22))*edge(2,2);
		un(dof(19:20))	= un(dof(11:12))*(1-edge(2,2))+un(dof(21:22))*edge(2,2);
		un(dof(23:24))	= un(dof(21:22))*(1-edge(2,3))+un(dof(31:32))*edge(2,3);
		un(dof(29:30))	= un(dof(21:22))*(1-edge(2,3))+un(dof(31:32))*edge(2,3);
		un(dof(25:26))	= un(dof(31:32))*(1-edge(2,4))+un(dof(1:2))*edge(2,4);
		un(dof(7:8))	= un(dof(31:32))*(1-edge(2,4))+un(dof(1:2))*edge(2,4);

		x = zeros(1,4); y = zeros(1,4);
	    for i = 1:4
	        if(edge(2,i)==-1)
	            x(i) = -1;  y(i) = -1;
	        else
	            x(i) = xnodes(i)*(1-edge(2,i))+xnodes(mod(i,4)+1)*edge(2,i);
	            y(i) = ynodes(i)*(1-edge(2,i))+ynodes(mod(i,4)+1)*edge(2,i);
	        end
	    end
	    r = ((x(1)-x(2))*(y(3)-y(1)) - (y(1)-y(2))*(x(3)-x(1)))/((x(4)-x(2))*(y(3)-y(1)) - (y(4)-y(2))*(x(3)-x(1)));
		un(dof(5:6)) = un(dof(13:14))*(1-r)+un(dof(25:26))*(r);
		un(dof(15:16)) = un(dof(13:14))*(1-r)+un(dof(25:26))*(r);
		un(dof(17:18)) = un(dof(13:14))*(1-r)+un(dof(25:26))*(r);
		un(dof(27:28)) = un(dof(13:14))*(1-r)+un(dof(25:26))*(r);
    end
end