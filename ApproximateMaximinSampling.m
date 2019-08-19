function [smp,rp,m] = ApproximateMaximinSampling(x, cp, ns,subsamplepercent)
[n,p]=size(x);

[m,rp]=ApproximatesamplePlus(x,cp,subsamplepercent);

subsamplesize=ceil(subsamplepercent*size(x,1)/100);
Subsamples= ceil(rand(subsamplesize,1)*size(x,1)) ;%% select random p1% (subsample) of the original data
rp=distance2(x(m,:),x(Subsamples,:))'; %% calculate distance of subsample from first point

[d,i]=min(rp,[],2);
smp=[];

for t=1:length(m)
    s = find(i==t);
    nt = ceil(ns*length(s)/subsamplesize) ;
    
    ind = ceil(rand(nt,1)*length(s));
    smp=[smp; Subsamples(s(ind))];
end;

smp=unique(smp);
end