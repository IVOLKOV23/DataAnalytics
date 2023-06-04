%Assignment 2
%Ivan Volkov, Alisha Collenette, Kwan Tung Tam
clear all
clc

%Question 1
data = xlsread('BMEN90037_Assignment2_DensityData.xlsx');
data(:, 3) = []; %to remove an empty column in the data set
%Control Baseline
figure;
histogram(data(:, 1)); %plot a histogram of the first column of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Control Baseline');

figure;
boxplot(data(:, 1)); %plot a boxplot of the first column of the data set
ylabel('Mean HU');
title('Control Baseline');

%Control 1 year
figure;
histogram(data(:, 2)); %plot a histogram of the second column of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Control 1 year');

figure;
boxplot(data(:, 2)); %plot a boxplot of the second column of the data set
ylabel('Mean HU');
title('Control 1 year');

%Control Difference
figure;
controldiff = data(:, 2) - data(:, 1);
histogram(controldiff); %plot a histogram of a difference between the first and the second columns of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Control Difference');

figure;
boxplot(controldiff); %plot a boxplot of a difference between the first and the second columns of the data set
ylabel('Mean HU');
title('Control Difference');

%Treatment Baseline
figure;
histogram(data(:, 3)); %plot a histogram of the third column of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Treatment Baseline');

figure;
boxplot(data(:, 3)); %plot a boxplot of the third column of the data set
ylabel('Mean HU');
title('Treatment Baseline');

%Treatment 1 year
figure;
histogram(data(:, 4)); %plot a histogram of the fourth column of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Treatment 1 year');

figure;
boxplot(data(:, 4)); %plot a boxplot of the fourth column of the data set
ylabel('Mean HU');
title('Treatment 1 year');

%Treatment Difference
figure;
treatmentdiff = data(1:75, 4) - data(1:75, 3);
histogram(treatmentdiff); %plot a histogram of the difference between the third and the fourth columns of the data set
xlabel('Mean HU');
ylabel('Frequency (number)');
title('Treatment Difference');

figure;
boxplot(treatmentdiff); %plot a boxplot of the difference between the third and the fourth columns of the data set
ylabel('Mean HU');
title('Treatment Difference');

%Question 2
%Null hyp: that the means are the same
%Alt hyp: that the mean after a year is greater than the baseline
%Paired t-test to be used since the test subjects are the same over the
%whole duration of the experiment
%Assume significance level of 5%

std2 = std(controldiff); %standard deviation of the control difference
mean2 = mean(controldiff); %mean of the control difference
n2 = 78; %number of mic recieving the placebo

T2 = mean2/(std2/sqrt(n2)); %test statistic
c2 = tinv(1 - (0.05), n2 - 1);

if abs(T2) < c2
    disp('There is no statistically significant change in the Control group HU data over the year');
else
    disp('There is statistically significant change in the Control group HU data over the year. Specifically increase in bone density');
end

%Question 3
%Null hyp: that the means are the same
%Alt hyp: that the mean after a year is greater than the baseline
%Paired t-test to be used since the test subjects are the same over the
%whole duration of the experiment
%Assume significance level of 5%

std3 = std(treatmentdiff); %standard deviation of the treatment difference
mean3 = mean(treatmentdiff); %mean of the treatment difference
n3 = 75; %number of mic recieving the treatment

T3 = mean3/(std3/sqrt(n3)); %test statistic
c3 = tinv(1 - (0.05), n3 - 1);

if abs(T3) < c3
    disp('There is no statistically significant change in the Treatment group HU data over the year');
else
    disp('There is statistically significant change in the Treatment group HU data over the year. Specifically increase in bone density');
end

%Question 4
%Null hyp: that the means are the same
%Alt hyp: that the mean after the treatment is greater than the control
%Two samples mean inference 
%Assume significance level of 5%

n4 = 78; %number of controls samples
m4 = 75; %number of treatment samples

%Check to see if the variances are the same
F4 = (std2^2)/(std3^2);
c1F = finv(0.05/2, n4 - 1, m4 - 1);

if F4 <= c1F
    disp('The variances of two data groups are not the same');
else
    disp('The variances of the two data groups are the same');
end

%Since the variances are not the same
[h4, p4] = ttest2(treatmentdiff, controldiff, 'alpha', 0.05, 'tail', 'right', 'vartype', 'unequal');

%Question 5
%Null hyp: that the means are the same
%Alt hyp: that the mean after the treatment is greater than the control
%Two samples mean inference 
%Assume significance level of 5%
%Assume that the variances are the same for the two samples

n5 = 10; %number of controls samples
m5 = 10; %number of treatment samples
stdcontrol = std(data(1:10, 2) - data(1:10, 1)); %standard deviation of the control difference
stdtreatment = std(data(1:10, 4) - data(1:10, 3)); %standard deviation of the treatment difference

%Check to see if the variances are the same
F5 = (stdcontrol^2)/(stdtreatment^2);
c2F = finv(1 - (0.05/2), n5 - 1, m5 - 1);

if F5 > c2F
    disp('The variances of two data groups are not the same');
else
    disp('The variances of the two data groups are the same');
end

%Since the variances are the same
[h5, p5] = ttest2(data(1:10, 4) - data(1:10, 3), data(1:10, 2) - data(1:10, 1), 'alpha', 0.05, 'tail', 'right');