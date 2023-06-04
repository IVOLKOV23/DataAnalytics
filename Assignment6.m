%Assignment 6
%Ivan Volkov, 988146
%Alisha Collenette, 996715
%(Jason) Kwan Tung Tam, 915781

clear all
clc

rng(1);

%Question 1
%Load the data
load('HeartData.mat');

%Plot a histogram of Subject 10
sub10 = HeartData(:, 10);
figure;
histogram(sub10, 30, 'Normalization', 'pdf');
title('Subject 10 heart rate data');
xlabel('Heart rate (bpm)');

%Question 2
%GMM for each subject
for i = 1:100
    data = HeartData(:, i);
    %2 component GMM for each subject
    gm{i} = fitgmdist(data, 2, 'Options', statset('MaxIter', 1000));
    gmmu(:, i) = gm{i}.mu;
    %gmcomponents(i, :) = gm{i}.ComponentProportion;
    %Find lambda1 for each subject
    if gm{i}.mu(1) < gm{i}.mu(2)
        lambda1(i) = gm{i}.ComponentProportion(1);
    else
        lambda1(i) = gm{i}.ComponentProportion(2);
    end
    p(i) = pdf(gm{i}, 89);
    
end

%Subject 10 overlay
figure;
histogram(sub10, 30, 'Normalization', 'pdf');
title('Subject 10 heart rate data with GMM pdf');
xlabel('Heart rate (bpm)');
hold on

x = linspace(1, 140);
y = pdf(gm{10}, x');
plot(x, y);
hold off

%Question 4
%Athletes histogram
lambda1_athletes = lambda1(1:1:50)';
figure;
histogram(lambda1_athletes, 15, 'Normalization', 'pdf');
title('Lambda1 for athletes');
xlabel('Mixing coefficient');

%Non-athletes histogram
lambda1_non_athletes = lambda1(51:1:100)';
figure;
histogram(lambda1_non_athletes, 15, 'Normalization', 'pdf');
title('Lambda1 for non-athletes');
xlabel('Mixing coefficient');

%Statistic significance
[H, P] = ttest2(lambda1_athletes, lambda1_non_athletes);

%Question 5
%Athletes and non-athletes histogram
mean_athletes = gmmu(:, 1:50);
figure;
histogram(mean_athletes, 30, 'Normalization', 'pdf');
hold on
mean_non_athletes = gmmu(:, 51:100);
histogram(mean_non_athletes, 30, 'Normalization', 'pdf');
title('Average Heart Rate for Athletes vs Non-Athletes');
legend('Athletes','Non-Athletes');
xlabel('Heart rate (bpm)');
hold off

%Question 6
%Athletes or non-athletes
p_athletes = mean(p(1:50));
p_non_athletes = mean(p(51:100));

%Resting or active
%Find probability of active given heart rate 89 (using nonathlete dist)
for i = 51:100
    p_89_temp = posterior(gm{i},89);
    if gm{i}.mu(1) < gm{i}.mu(2)
        %first class is resting
        p_89_resting(i-50) = p_89_temp(1);
        p_89_active(i-50) = p_89_temp(2);
    else
        %first class is active
        p_89_resting(i-50) = p_89_temp(2);
        p_89_active(i-50) = p_89_temp(1);
    end
end
p_active = mean(p_89_active);
p_resting = mean(p_89_resting);
