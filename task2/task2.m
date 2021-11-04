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

df_opts = detectImportOptions('insurance.csv');
df = readtable('insurance.csv', df_opts);
age = table2array(df(:,1));


fid = fopen('./insurance.csv','r');
tline = fgetl(fid);
tline = fgetl(fid);  % filtering out the header
ages = [];
sexs = [];  % 1: male; 0: female
bmis = [];
children = [];
smokers = [];  % 0: non-smoker; 1: smoker
regions = [];  % 0: NE, 1: NW, 2: SE, 3: SW
charges = [];

heat = zeros(47, 39) % Figure 5

% Figure 1
male_charges = zeros(47, 'double');
female_charges = zeros(47, 'double');

while ischar(tline)
    %disp(tline);
    line_data = split(tline, ",");

    ages(end + 1) = str2double(line_data(1));
    
    if (string(line_data(2)) == "female")
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

    % Figure 5
    age_index = int64(str2double(line_data(1)));
    bmi_index = int64(str2double(line_data(3)));
    charge_var = str2double(line_data(7));
    charge_cur = heat(age_index - 17, bmi_index - 14);
    
    if charge_var > charge_cur
        heat(age_index - 17, bmi_index - 14) = charge_var;
    else
        disp(charge_var);
    end

end
fclose(fid);

% Figure 1 Min Charge of Each Age

% Figure 2 Smoker Proportion

% Figure 3 Regional Box chart

% Figure 4 Scatter of Smoker, BMI, and Children 

% Figure 5 Heatmap of Age, BMI, and Charge

