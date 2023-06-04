%Ivan Volkov, Alisha Collenette and Jason Tam
%Assignment 1
clear all
clc

%Question 1
load('OpticNerveAxonRadii.mat');
figure;
histogram(R, 'Normalization', 'pdf'); %data display in a form of a histogram
xlabel('Axon Radii (µm)');
ylabel('Probability');

%Question 2
sample_mean = mean(R) %sample mean calculations
sample_var = var(R) %sample variance calculations

%Question 3
estimated_k = sample_mean^2/sample_var %expected value (mean) = k*theta
estimated_theta = sample_var/sample_mean %variance = k*theta^2

%Question 4
figure;
histogram(R, 'Normalization', 'pdf');
xlabel('Axon Radii (µm)');
ylabel('Probability');
hold on
r = 0:(max(R)- min(R))/length(R):max(R); %X-axis
plot(r, gampdf(r, estimated_k, estimated_theta), 'LineWidth', 2); %to plot gamma distribution pdf using parameters k & theta
legend('Axon radii pdf', 'Gamma pdf');

%Question 5
A = pi * (R.^2); %axon area
mean_area = mean(A) %mean axon area
fun = @(r) pi*r.^2.*gampdf(r, estimated_k, estimated_theta); %function to define area of an axon with the probability distribution
mean_area_integral = integral(fun, -Inf, Inf) %axon area from a function integration

%Question 6
figure;
histogram(R, 'Normalization', 'pdf');
xlabel('Axon Radii (µm)');
ylabel('Probability');
hold on
r = -1:(max(R)- min(R))/length(R):max(R); %X-axis
plot(r, gampdf(r, estimated_k, estimated_theta), 'LineWidth', 2);
Norm_aprox = normpdf(r, estimated_k*estimated_theta, sqrt(estimated_k*(estimated_theta)^2)); %CLT normal approximation with mu and sigma from gamma distribution
plot(r, Norm_aprox, 'LineWidth', 2);
legend('Axon radii pdf', 'Gamma pdf', 'CLT Gaussian pdf');

%Question 7
theta = 1; %arbitrary theta value

figure;
tiledlayout(2, 4); %figure with 8 separate graphs
nexttile
k = 1;
r = 0:0.1:10;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2)); %normal approximation with k and theta values
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta); %gamma pdf with the same k and theta parameters
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 1');
rmse1 = sqrt(mean((gam - norm_aprox).^2)) %rmse to determine how good approximation is
nexttile
k = 5; %repeated for a range of k values
r = 0:0.1:20;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 5');
rmse5 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 10;
r = 0:0.1:30;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 10');
rmse10 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 15;
r = 0:0.1:40;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 15');
rmse15 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 20;
r = 0:0.1:80;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 20');
rmse20 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 25;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 25');
rmse25 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 30;
r = 0:0.1:100;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 30');
rmse30 = sqrt(mean((gam - norm_aprox).^2))
nexttile
k = 35;
norm_aprox = normpdf(r, k*theta, sqrt(k*(theta)^2));
plot(r, norm_aprox, 'LineWidth', 2);
hold on
gam = gampdf(r, k, theta);
plot(r, gam, 'LineWidth', 2);
legend('CLT Gaussian pdf', 'Gamma pdf');
title('k = 35');
rmse35 = sqrt(mean((gam - norm_aprox).^2))
