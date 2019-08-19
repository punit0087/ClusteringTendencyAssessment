function [m,Rp,max_distance_Rp] = ApproximatesamplePlus(X,cp,subsamplepercent)
subsamplesize=ceil(subsamplepercent*size(X,1)/100);
[n,p]=size(X);
m=ones(cp,1);
max_distance_Rp=zeros(cp,1);
m(1)=ceil(rand(1)*size(X,1)); %%radonmly choose first point
Subsamples= ceil(rand(subsamplesize,1)*size(X,1)) ;%% select random p1% (subsample) of the original data
d=distance2(X(m(1),:),X(Subsamples,:))'; %% calculate distance of subsample from first point

[~,temp]=max(d);
m(1)=Subsamples(temp);
for t=2:cp,
    Subsamples= ceil(rand(subsamplesize,1)*size(X,1)); %% select random p1% (subsample) of the original data
    Rp=distance2(X(m(1:t-1),:),X(Subsamples,:))';
    d=min(Rp,[],2);
    [~,temp]=max(d);
    m(t)=Subsamples(temp);
end;