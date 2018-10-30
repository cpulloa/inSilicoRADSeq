% strucutre plot complete genome %
%clear workspace
clc
clear all
% read data from txt file space delimited
fileName = 'data.txt';
formatSpec = '%s %f %f %f %f %f %s';

[strain, pop_1, pop_2, ...
    pop_3, pop_4, pop_5, MLS_class] ...
    =  textread(fileName, formatSpec);
%%
% Bar plot
pops = [pop_1,pop_2,pop_3,pop_4,pop_5];
nPops = size(pops,2);

h = barh(pops,0.5,'stacked');


pbaspect([1 2 1])
axis([0 1 1 125]);
colormap(parula(nPops));
l = cell(1,5);
l{1}='pop_1'; l{2}='pop_2'; l{3}='pop_3'; l{4}='pop_4'; l{5}='pop_5'; 
legend(h,l);

ax = gca;
set(ax,'yticklabel', strain,'FontSize', 2)

