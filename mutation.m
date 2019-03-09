function  mutpop=mutation(mutpop,pop,nvar,X,Y,nmut,popsize)

for n=1:nmut
    
i=randi([1 popsize]);  

p=pop(i).var;

j1=randi([1 nvar]);
% j2=randi([j1+1 nvar]);

if p(j1)==1
    p(j1)=0;
else p(j1)=1;
end

mutpop(n).var=p;
if sum(mutpop(n).var)>0 
   [mutpop(n).fit,mutpop(n).acc,mutpop(n).nfeat]=svm(X,Y,mutpop(n).var);
else
   mutpop(n).fit=Inf;
end

end

end