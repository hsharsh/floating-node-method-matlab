function vtkwrite(filename,connectivity,position,u,v,a,stress)
%    fid = fopen(['/home/hsharsh/fnm/data/',filename],'w');
    fid = fopen(['D:\Floating Node Method\floating-node-method\data\',filename],'w');
    fprintf(fid, '# vtk DataFile Version 1.0\n');
    fprintf(fid, 'VTK - Matlab export\n');
    fprintf(fid, 'ASCII\n');
    precision = 8;

    fprintf(fid, 'DATASET POLYDATA\n');
    fprintf(fid, ['POINTS ',num2str(size(position,1)),' float\n']);
    for lmn = 1:length(position)
        fprintf(fid, ['%0.', num2str(precision), 'f '], position(lmn,:)');
        fprintf(fid,'\n');
    end

    fprintf(fid, ['\nPOLYGONS ',num2str(size(connectivity,1)),' ',num2str(5*size(connectivity,1)),'\n']);
    for lmn = 1:length(connectivity)
        fprintf(fid,'4 ');
        fprintf(fid, ['%0d '], connectivity(lmn,:)-1');
        fprintf(fid,'\n');
    end


    fprintf(fid, '\nPOINT_DATA %d\n',size(position,1));
    fprintf(fid, 'VECTORS displacement float\n');

    for lmn = 1:length(u)
        fprintf(fid, ['%0.', num2str(precision), 'f '], u(lmn,:)');
        fprintf(fid,'\n');
    end

    fprintf(fid, '\nVECTORS velocity float\n');
    for lmn = 1:length(v)
        fprintf(fid, ['%0.', num2str(precision), 'f '], v(lmn,:)');
        fprintf(fid,'\n');
    end
    
    fprintf(fid, '\nVECTORS acceleration float\n');
    for lmn = 1:length(a)
        fprintf(fid, ['%0.', num2str(precision), 'f '], a(lmn,:)');
        fprintf(fid,'\n');
    end
    
    fprintf(fid, 'SCALARS stress_mises float\n');    
    fprintf(fid, 'LOOKUP_TABLE default\n');
   
     for lmn = 1:length(stress)
        fprintf(fid, ['%0.', num2str(precision), 'f '], stress(lmn,:)');
        fprintf(fid,'\n');
    end

    fclose(fid);
end

