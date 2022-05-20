function [modified_trcfile] = modify_trc(trc_file)
% Function for modifieing the trc file generated from motion capture and
% Mokka. Mokka is used to convert c3d to trc. But the orientation of the
% coordinate axes are differnt for OpenSim and motion capture.

number_of_markers = 41; % Markers used in motion capture
number_of_columns = number_of_markers*3+2;

fid = fopen(trc_file,'r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);

format2 = repmat('%f', [1,number_of_columns]);
number_of_frames=length(A)-7; % Since first 7 lines always contain text
matrix = [];
for i= 7:number_of_frames+6
    C = textscan(A{i}, format2,'Delimiter','→');
   matrix = [matrix ; cellfun(@(v)v(1),C)];
end
transformed_matrix = matrix;


for i = 3:3:number_of_columns
    transformed_matrix(:,i+1) = matrix(:,i+2);
    transformed_matrix(:,i+2) = -matrix(:,i+1);
end

modified_trcfile = trc_file+'transformed.trc'; %KOLLA MED ERIK

% Write cell A into txt
fid3 = fopen(modified_trcfile, 'w');
for i = 1:6 
    if A{i+1} == -1
        fprintf(fid3,'%s', A{i});
        break
    else
        fprintf(fid3,'%s\n', A{i});
    end
end

dlmwrite(modified_trcfile,transformed_matrix,'-append','precision','%.5f','delimiter','\t');

fclose(fid3);

end