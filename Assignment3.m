%Assignment 3
%Ivan Volkov, Alisha Collenette, Kwan Tung Tam

%Load the data from the file
load('BMEN90037_Assignment3_GaitData.mat'); 

%Question 1
%Set up table
%Gender
Gn = cell(size(G));
Gn(G==0) = {'Male'};
Gn(G==1) = {'Female'};

%Job type
Dn = cell(size(D));
Dn(D==0) = {'Active Job'};
Dn(D==1) = {'Desk Job'};

%OA status
An = cell(size(A));
An(A==0) = {'Not affected by knee OA'};
An(A==1) = {'Affected by knee OA'};

%Merged data
GDAn = [Gn Dn An];
GDA = [G D A];

Count = zeros(8,1);

%Get counts
for i = 1:132
    if GDA(i,1) == 1 && GDA(i,2) == 1 && GDA(i,3) == 1
        Count(1) = Count(1)+1;
    elseif GDA(i,1) == 1 && GDA(i,2) == 1 && GDA(i,3) == 0
           Count(2) = Count(2)+1;
    elseif GDA(i,1) == 1 && GDA(i,2) == 0 && GDA(i,3) == 1
           Count(3) = Count(3)+1;
    elseif GDA(i,1) == 1 && GDA(i,2) == 0 && GDA(i,3) == 0
           Count(4) = Count(4)+1;
    elseif GDA(i,1) == 0 && GDA(i,2) == 1 && GDA(i,3) == 1
           Count(5) = Count(5)+1;
    elseif GDA(i,1) == 0 && GDA(i,2) == 1 && GDA(i,3) == 0
           Count(6) = Count(6)+1;
    elseif GDA(i,1) == 0 && GDA(i,2) == 0 && GDA(i,3) == 1
           Count(7) = Count(7)+1;
    elseif GDA(i,1) == 0 && GDA(i,2) == 0 && GDA(i,3) == 0
           Count(8) = Count(8)+1;
    end
end

[aGroup, Gender, JobType, KneeOA] = findgroups(Gn,Dn,An);

%Table 
table(Gender, JobType, KneeOA,Count)

%Question 2
%Three-way ANOVA
[p, tbl, stats] = anovan(Cadence,{G, D, A}, 'model', 'interaction','varnames',{'Gender','Job type','OA status'});
multcompare(stats,'Dimension',[1 2 3]);

%Question 3
%Line regression analysis
X = [ones(length(G),1),G,D,A,G.*D,G.*A,D.*A];
[b,bint,r,rint,stats1] = regress(Cadence,X);

%Question 4
%R-squared from ANOVA
R22 = 1-(tbl{8,2}/tbl{9,2});

%R-squared from regress function
R23 = stats1(1);

%Question 5
%Cadence based on the approximation
Cadence_pred = (sum((b'.*X)'))';

%Plotting of the Cadences
figure
plot(Cadence);
ylabel('Cadence (steps/minute)');
hold on
plot(Cadence_pred);
ylabel('Cadence (steps/minute)');
hold off
legend('Measured Cadence', 'Predicted Cadence');

%Plotting of the sorted Cadences
figure
[Cadence_sort,ind]=sort(Cadence);
plot(sort(Cadence));
ylabel('Cadence (steps/minute)');
hold on
plot(Cadence_pred(ind));
ylabel('Cadence (steps/minute)');
legend('Measured Cadence', 'Predicted Cadence');

