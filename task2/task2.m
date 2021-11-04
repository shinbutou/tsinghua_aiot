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
regions = [];  % 0: northeast, 1: northwest, 2: southeast, 3: southwest
charges = [];

male_charges = zeros(47, 1, 'double'); % Figure 1
female_charges = zeros(47, 1, 'double'); % Figure 1
male_smoker = []; % Figure 2
female_smoker = []; % Figure 2
male_overweight = []; % Figure 2
female_overweight = []; % Figure 2
northeast_charges = []; % Figure 3
northwest_charges = []; % Figure 3
southeast_charges = []; % Figure 3
southwest_charges = []; % Figure 3
scatter = zeros(); % Figure 4
heat = zeros(47, 39); % Figure 5

while ischar(tline)
    %disp(tline);
    line_data = split(tline, ",");
    ages(end + 1) = str2double(line_data(1));    
    if string(line_data(2)) == "female"
        sexs(end + 1) = 0;
        female_smoker(end + 1) = 0; % Figure 2
        female_overweight (end + 1) = 0;
    else
        sexs(end + 1) = 1;
        male_smoker(end+1) = 0; % Figure 2
        male_overweight (end + 1) = 0;
    end

    bmis(end + 1) = str2double(line_data(3));
    if bmis(end) > 25 && string(line_data(2)) == "female"
        female_overweight (end) = 1;
    elseif bmis(end) >25 && string(line_data(2)) == "male"
        male_overweight (end) = 1;
    end

    children(end + 1) = str2double(line_data(4));
    
    if (string(line_data(5)) == "no")
        smokers(end + 1) = 0;
        smoker_cur = 0; % Figure 4
    else
        smokers(end + 1) = 1;
        if string(line_data(2)) == "female"
            female_smoker(end) = 1;
        else
            male_smoker(end) = 1;
        end

        smoker_cur = 1; % Figure 4
    end

    charges(end + 1) = str2double(line_data(7));

    switch string(line_data(6))
        case 'northeast'
            regions(end + 1) = 0;
            northeast_charges(end + 1) = charges(end); % Figure 3
        case 'northwest'
            regions(end + 1) = 1;
            northwest_charges(end + 1) = charges(end); % Figure 3
        case 'southwest'
            regions(end + 1) = 2;
            southeast_charges(end + 1) = charges(end); % Figure 3
        case 'southeast'
            regions(end + 1) = 3;
            southwest_charges(end + 1) = charges(end); % Figure 3
    end

    tline = fgetl(fid);

    % Illustration Common Variables
    age_index = int64(str2double(line_data(1)));
    bmi_index = int64(str2double(line_data(3)));
    charge_var = str2double(line_data(7));

    % Figure 1
    switch string(line_data(2))
        case 'male'
            charge_cur = male_charges(age_index-17);
            if charge_cur == 0
                male_charges(age_index-17) = charge_var;
            elseif charge_var < charge_cur
                male_charges(age_index-17) = charge_var;
            end

        case 'female'
            charge_cur = female_charges(age_index-17);

            if charge_cur == 0
                female_charges(age_index-17) = charge_var;
            elseif charge_var < charge_cur
                female_charges(age_index-17) = charge_var;
            end
    end

    % Figure 4    
    if smoker_cur == 1
        scatter(end + 1) = 1;
    else
        scatter(end + 1) = 0;
    end

    % Figure 5
    charge_cur = heat(age_index - 17, bmi_index - 14);
    
    if charge_var > charge_cur
        heat(age_index - 17, bmi_index - 14) = charge_var;
    end
end

fclose(fid);

% Figure 1 Min Charge of Each Age
%{
hold all
age_axis = 18:64;
fig1 = bar(age_axis, female_charges);
fig1 = bar(age_axis, male_charges);
hold off

labels = {'Female', 'Male'};
lgd = legend(labels);
%}

% Figure 2 Smoker Proportion
%{
sm_data = [sum(male_smoker == 1); size(male_smoker, 2) - sum(male_smoker == 1)];
sf_data = [sum(female_smoker == 1); size(female_smoker, 2) - sum(female_smoker == 1)];
om_data = [sum(male_overweight == 1); size(male_overweight, 2) - sum(male_overweight == 1)];
of_data = [sum(female_overweight == 1); size(female_overweight, 2) - sum(female_overweight == 1)];
pies = tiledlayout(2, 2, 'TileSpacing', 'compact');

sm = nexttile;
pie(sm, sm_data);
title('Male Smoker');

sf = nexttile;
pie(sf, sf_data);
title('Female Smoker');

om = nexttile;
pie(om, om_data);
title('Male Obesity');

of = nexttile;
pie(of, of_data);
title('Female Obesity');
%}

% Figure 3 Regional Box chart
box_data = [northeast_charges northwest_charges southeast_charges southwest_charges];
box_group = [zeros(fliplr(size(northeast_charges))); ones(fliplr(size(northwest_charges))); 2*ones(fliplr(size(southeast_charges))); 3*ones(fliplr(size(southwest_charges)))]';
boxchart(box_group, box_data);

% Figure 4 Scatter of Smoker, BMI, and Children
%{
scatter = scatter(2: end);
z = scatter;
x = children;
y = bmis;
scatter3(x, y, z, 'filled')
view(-35, 5, 5)
%}

% Figure 5 Heatmap of Age, BMI, and Charge
%{
fig5 = heatmap((15:53), (18:64), heat);
fig5.Title = 'Maximum Charges';
fig5.XLabel = 'BMI';
fig5.YLabel = 'Age';
%}