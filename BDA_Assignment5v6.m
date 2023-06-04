% Assignment 5
% Work of Alisha Collenette (996715), Ivan Volkov (988146) and (Jason) Kwan
% Tung Tam (915781)

clear all
clc

%Question 1

%load InfusionPumpLocations into matrix
readmatrix('InfusionPumpLocations.xlsx');
locations = ans;
x_loc = locations(:,1);
y_loc = locations(:,2);

%plot the infusion pump locations
figure
scatter(locations(:,1),locations(:,2))
title('Scatter Plot of Infusion Pump Locations');
axis equal


%Question 2 

%N sets the number of simulations to determine the minimum possible cost
N = 100;

%Allocating points into clusters via the Kmeans distance measure is 
%non-deterministic. The outer loop therefore runs the allocation multiple 
%times to find the most likely K value that incurs minimal cost to
%the hospital
for j = 1:N
    rng(j)  %for reproducibility
    
    %The middle for loop reiterates to find the cost for each K value
    for K = 1:105
        [allocations,C,SUMD,D] = kmeans(locations,K);
        
        %The inner for loop reiterates to find the sum of point-centroid
        %distances per cluster
        for i=1:K
            Distance_cluster(i) = sum(sqrt(((x_loc(allocations==i) - C(i,1)).^2) + ((y_loc(allocations==i) - C(i,2)).^2)));
        end
    
        %Costs based on the within-cluster distance and the charge sations
        %used
        Dist(K) = sum(Distance_cluster);
        cost(K) = 10*Dist(K)+11500*K; 
    end
    
    %Store only the minimum costs with maximum 80 pumps per cluster
    [allocation_no, max_pump_no] = mode(allocations);
    if max_pump_no <= 80
        [M(j) I(j)] = min(cost);
    end
end

%Find the lowest cost possible of all of the iterations and K associated
[global_min_cost, global_min_cost_ind] = min(M);
K_opt = I(global_min_cost_ind);

%Re-run allocation code with the random distribution that will produce the
%minimal cost
rng(global_min_cost_ind);

for K = 1:105
        [allocations,C,SUMD,D] = kmeans(locations,K);
        for i=1:K
            Distance_cluster(i) = sum(sqrt(((x_loc(allocations==i) - C(i,1)).^2) + ((y_loc(allocations==i) - C(i,2)).^2)));
        end
    Dist(K) = sum(Distance_cluster);
    cost(K) = 10*Dist(K)+11500*K;
end

%Plot the number of recharge station vs cost
figure;
K = [1:105];
plot(K, cost(1:105))
title('Cost vs number of recharge stations');
ylabel('Cost ($)')
xlabel('Number of Recharge Stations')

%Run the code again to store the optimal centroid locations
[allocations, C_opt] = kmeans(locations, K_opt);

%Display results
fprintf('Based on %d iterations, having %d recharge stations tend to incur minimal cost.\n', N, K_opt)
fprintf('The lowest cost was given by having %d recharge stations at $%f.\n',K_opt, global_min_cost);
fprintf('The charging stations are located at:\n');
for m = 1:K_opt
    fprintf('(%0.2f, %0.2f)\n',C_opt(m,1),C_opt(m,2));
end

%Verify again that the number of infusion pumps don't exceed 80 at each recharge
%station
size1 = numel(locations(allocations==1));
size2 = numel(locations(allocations==2));
fprintf('There are %d pumps around recharge station 1.\n', size1); 
fprintf('There are %d pumps around recharge station 2.\n', size2);

%Plot the most effective clusters
figure
gscatter(locations(:,1),locations(:,2),allocations)
hold on
scatter(C_opt(:,1), C_opt(:,2),60,'kx');
legend('Cluster 1','Cluster 2','Centroid Locations')
hold off
title('Plot of most effective recharge station clusters');
axis equal

%Question 3

%Find variances of the points within each cluster
c1 = [x_loc(allocations==1), y_loc(allocations==1)];
var1 = var(c1);
c2 = [x_loc(allocations==2), y_loc(allocations==2)];
var2 = var(c2);