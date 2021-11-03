% Given Function
%{
fid=fopen('./t2_data.csv','r');
tline = fgetl(fid);

while ischar(tline)
    disp(tline);
    tline = fgetl(fid);
end
fclose(fid);
%}

% Self-Written Version
%{
df_opts = detectImportOptions('insurance.csv');
df = readtable('insurance.csv', df_opts);
age = table2array(df(:,1));
%}

fid = fopen('./insurance.csv','r');
tline = fgetl(fid);
tline = fgetl(fid);  % filtering out the header
ages = [];
sexs = [];  % 0: male; 1: female
bmis = [];
children = [];
smokers = [];  % 0: non-smoker; 1: smoker
regions = [];  % 0: NE, 1: NW, 2: SE, 3: SW
charges = [];


while ischar(tline)
    disp(tline);
    line_data = split(tline, ",");

    ages(end + 1) = str2double(line_data(1));
    
    if (string(line_data(2)) == "male")
        sexs(end + 1) = 0;
    else
        sexs(end + 1) = 1;
    end

    bmis(end + 1) = str2double(line_data(3));
    children(end + 1) = str2double(line_data(4));
    
    if (string(line_data(5)) == "no")
        smokers(end + 1) = 0;
    else
        smokers(end + 1) = 1;
    end

    switch string(line_data(6))
        case 'northeast'
            regions(end + 1) = 0;
        case 'northwest'
            regions(end + 1) = 1;
        case 'southwest'
            regions(end + 1) = 2;
        case 'southeast'
            regions(end + 1) = 3;
    end

    charges(end + 1) = str2double(line_data(7));

    tline = fgetl(fid);
end
fclose(fid);

% Figure 1

% Figure 2

% Figure 3

% Figure 4

% Figure 5