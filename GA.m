clc
clear
close all
format shortG
for nrun=1:10

%% parameters setting


X=xlsread('data_bcp');
Y=xlsread('target_bcp');


nvar=size(X,2);



fen=10000;
popsize=30;


pc=0.9;
ncross=2*round((popsize*pc)/2);

pm=0.1;
nmut=round(popsize*pm);

maxiter=floor((fen-popsize)/((2*ncross)+nmut));



%% initial population algorithm


emp.var=[];
emp.fit=[];
emp.x=[];
emp.acc=[];
emp.nfeat=[];

pop=repmat(emp,popsize,1);


for i=1:popsize
  
    pop(i).var=round(rand(1,nvar));

    if sum(pop(i).var)>0
       [pop(i).fit,pop(i).acc,pop(i).nfeat]=svm(X,Y,pop(i).var);
    else
       pop(i).fit=Inf;
    end
    
end

[value,index]=min([pop.fit]);
gpop=pop(index);






%% main loop algorithm

BEST=zeros(maxiter,1);

tic

for iter=1:maxiter

   % crossover
   crosspop=repmat(emp,ncross,1);
   crosspop=crossover(crosspop,pop,nvar,X,Y,ncross);
   
   
   % mutation
   mutpop=repmat(emp,nmut,1);   
   mutpop=mutation(mutpop,pop,nvar,X,Y,nmut,popsize);
   
   
   [pop]=[pop;crosspop;mutpop]; 
   [value,index]=sort([pop.fit]); 
   pop=pop(index);
   gpop=pop(1);
   pop=pop(1:popsize); 
    
   
BEST(iter)=gpop.fit;

disp([' Run = ' num2str(nrun)  ' Iter = ' num2str(iter)  ' BEST = ' num2str(BEST(iter)) ' Acc = ' num2str(gpop.acc) ' Nfeat = ' num2str(gpop.nfeat) ])


end

save(nrun,1)=gpop.acc;
save(nrun,2)=gpop.nfeat;
save(nrun,3)=toc;

end


%% results algorithm


%disp([ ' Best Solution = '  num2str(find(gpop.var==1))])
%disp([ ' Best Fitness = '  num2str(gpop.fit)])
%disp([ ' Time = '  num2str(toc)])


% figure(1)
% plot(BEST,'r')
% xlabel('Iteration')
% ylabel('Fitness')
% legend('BEST')
% title('GA')















