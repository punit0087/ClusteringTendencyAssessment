clc;
clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dimension=100;

[data_matrix] = CS_data_generate_Punit(-6,1,25000,dimension);
data_matrix_with_lables_1=[data_matrix zeros(25000,1)+1];

[data_matrix] = CS_data_generate_Punit(0,2,50000,dimension);
data_matrix=[data_matrix zeros(50000,1)+2];
data_matrix_with_lables_1=[data_matrix_with_lables_1;data_matrix];

[data_matrix] = CS_data_generate_Punit(6,3,25000,dimension);
data_matrix=[data_matrix zeros(25000,1)+3];
data_matrix_with_lables_1=[data_matrix_with_lables_1;data_matrix];
%

Data=data_matrix_with_lables_1(:,1:end-1);
Labels=data_matrix_with_lables_1(:,end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(Data,1);
NoofK=length(unique(Labels));
N=5;
cp=50;
ns=200;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%siVAT
for i=1:N
    i
    tic
    smp_cVAT= SamplingBigData(Data,cp,ns );
    cVAT_Samplingtime(i)=toc;
    cVAT_DD=Data(smp_cVAT,:);
    rs = distance2(cVAT_DD,cVAT_DD);
    [rv,C,I,ri,cut]=VAT(rs);
    [RiV,RV,reordering_mat]=iVAT(rv,1);
    figure, imagesc(RiV); colormap(gray); axis image; axis off;
    
    [cuts,ind]=sort(cut,'descend');
    ind=sort(ind(1:NoofK-1));
    Pi=zeros(length(smp_cVAT),1);
    Pi(smp_cVAT(I(1:ind(1)-1)))=1;
    Pi(smp_cVAT(I(ind(end):end)))=NoofK;
    for k=2:NoofK-1
        Pi(smp_cVAT(I(ind(k-1):ind(k)-1)))=k;
    end
    
    labels_smp=Pi(smp_cVAT);
end

%%siVAT+
samplepercent=5;
for i=1:N
    i
    tic
    [smp] = ApproximateMaximinSampling(Data,cp,ns,samplepercent);
    MMSR_Samplingtime(i)=toc;
    MMSR_DD=Data(smp,:);
    rs = distance2(MMSR_DD,MMSR_DD);
    [rv,C,I,ri,cut]=VAT(rs);
    [RiV,RV,reordering_mat]=iVAT(rv,1);
    figure, imagesc(RiV); colormap(gray); axis image; axis off;
    [cuts,ind]=sort(cut,'descend');
    ind=sort(ind(1:NoofK-1));
    Pi=zeros(length(smp),1);
    Pi(smp(I(1:ind(1)-1)))=1;
    Pi(smp(I(ind(end):end)))=NoofK;
    for k=2:NoofK-1
        Pi(smp(I(ind(k-1):ind(k)-1)))=k;
    end;
    SampleClusTime=toc;
    labels_smp=Pi(smp);
end




