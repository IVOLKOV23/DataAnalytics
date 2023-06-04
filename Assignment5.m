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
%Performed Dunn Index analysis to find the most effective clusters
N = 100;
centroid = [];
lowest_cost = 11500*105; %initialise the lowest cost

%Repeat the code to find a minimum solution
for j = 1:N
    
    %Iterating through each of the possible number of clusters
    for K = 1:105
        [allocations,C,SUMD,D] = kmeans(locations,K);
        
        %Within-cluster distance to a centroid for each cluster
        for i=1:K
            Distance_cluster(i) = sum(sqrt(((x_loc(allocations==i) - C(i,1)).^2) + ((y_loc(allocations==i) - C(i,2)).^2)));
        end
        
        %Cost associated with the distances found
    Dist(K) = sum(Distance_cluster);
    cost(K, j) = 10*Dist(K)+11500*K;
    
    %Find the lowest cost possible nad with 80 pumps at max per station
    [~, max_pump_no] = mode(allocations);
    if cost(K, j) < lowest_cost && max_pump_no <= 80
        lowest_cost = cost(K, j);
        k_value = K; %K associated with that cost
        centroid = C; %Recharge station locations
        final_allocations = allocations; %Allocated pumps
        final_j = j; %Associated column of costs
    end
    end
end

%Plot the most effective clusters
figure
gscatter(locations(:,1), locations(:,2), final_allocations)
hold on
scatter(centroid(:,1),centroid(:,2),60,'kx');
legend('Cluster 1','Cluster 2','Centroid Locations')
hold off
title('Plot of most effective recharge station clusters');
axis equal

%Verify that the number of infusion pumps don't exceed 80 at each recharge
%station
[allocation_no, max_pump_no] = mode(final_allocations);
size1 = numel(locations(final_allocations==1));
size2 = numel(locations(final_allocations==2));
fprintf('Most infusion pumps cluster around recharge station %d. There are %d pumps there.\n', allocation_no, max_pump_no);

%Display results
fprintf('Based on %d iterations, having %d recharge stations tend to incur minimal cost.\n', N, k_value)
fprintf('The lowest cost was given by having %d recharge stations at $%f.\n', k_value, lowest_cost);
fprintf('The charging stations are located at:\n');
for m = 1:k_value
    fprintf('(%0.2f, %0.2f)\n', centroid(m,1), centroid(m,2));
end

%Plot the number of recharge stations vs cost
figure;
K = [1:105];
plot(K, cost(:, final_j));
title('Cost vs number of recharge stations');
ylabel('Cost ($)');
xlabel('Number of Recharge Stations');

%Question 3
%Find variances of the points within each cluster
c1 = [x_loc(final_allocations==1), y_loc(final_allocations==1)];
var1 = var(c1);
c2 = [x_loc(final_allocations==2), y_loc(final_allocations==2)];
var2 = var(c2);
