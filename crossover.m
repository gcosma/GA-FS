function  crosspop=crossover(crosspop,pop,nvar,X,Y,ncross)

f=[pop.fit];
f=max(f)-f+eps;
f=f./sum(f);
f=cumsum(f);


for n=1:2:ncross

    i1=find(rand<=f,1,'first');
    i2=find(rand<=f,1,'first');
    

p1=pop(i1).var;
p2=pop(i2).var;

j=randi([1 nvar-1]);


o1=[p1(1:j) p2(j+1:end)];
o2=[p2(1:j) p1(j+1:end)];

% o1=unique([o1 randperm(nvar)],'stable');
% o2=unique([o2 randperm(nvar)],'stable');

crosspop(n).var=o1;
if sum(crosspop(n).var)>0
  [crosspop(n).fit,crosspop(n).acc,crosspop(n).nfeat]=svm(X,Y,crosspop(n).var);
else
crosspop(n).fit=Inf;
end

crosspop(n+1).var=o2;
if sum(crosspop(n+1).var)>0
   [crosspop(n+1).fit,crosspop(n+1).acc,crosspop(n+1).nfeat]=svm(X,Y,crosspop(n+1).var);
else
    crosspop(n+1).fit=Inf;
end

end
end



















