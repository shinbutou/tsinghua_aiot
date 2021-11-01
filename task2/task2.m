%{
fid=fopen('./t2_data.csv','r');
tline = fgetl(fid);

while ischar(tline)
    disp(tline);
    tline = fgetl(fid);
end
fclose(fid);
%}

df_opts = detectImportOptions('insurance.csv');
df = readtable('insurance.csv', df_opts);

% Figure 1

% Figure 2

% Figure 3

% Figure 4

% Figure 5