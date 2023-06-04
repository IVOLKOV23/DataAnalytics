%Assignment 4
%Question 1
%Read the image
Image = imread('BrainMRI.png');

%Convert to grayscale
Image_grey = rgb2gray(Image);
figure;
image(Image_grey);
title('Original Image');
colormap gray
axis image

%COnvert to double
Image_svd = double(Image_grey);

%Question 2
%SVD
[u, s, v] = svd(Image_svd);

%Singular values
sing_values = svd(Image_svd);

%Image reconstruction
Recon = u(:, 1:5)*s(1:5, 1:5)*v(:, 1:5)';
figure;
image(Recon);
title('Image reconstruction using 5 largest singular values');
colormap gray
axis image

%Question 3
%Singular values plot
figure;
plot(diag(s));
grid on
xlabel('Dimensionality');
ylabel('Singular value');
title('Singular values plot');

%Image reconstruction using the graph
Recon1 = u(:, 1:18)*s(1:18, 1:18)*v(:, 1:18)';
figure;
image(Recon1);
title('Image reconstruction using elbow point');
colormap gray
axis image

%Question 4
%Minimum number
Recon3 = u(:, 1:75)*s(1:75, 1:75)*v(:, 1:75)';
figure;
image(Recon3);
title('Image reconstruction using minimum number of singular values');
colormap gray
axis image

%Captured variance
cap_var = sum(eig(s(1:75, 1:75)))/sum(sing_values);

