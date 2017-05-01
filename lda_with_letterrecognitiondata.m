clear

train_images = load('data/train_features.dat');
train_labels = textread('data/train_labels.dat','%c');
test_images = load('data/test_features.dat');
test_labels = textread('data/test_labels.dat','%c');

ImageNum = 16000;
count=0;
allmu_train=[];
allmu=0;
Sw=0;
Sw_train=[];
class_train=[];
tot=0;

for i=0:26
    for j=1:16000
        if(train_labels(j)==i)
            count=count+1;
            allmu = allmu+mean(train_images(:,j));
            Sw = Sw+cov(train_images(:,j));
            tot=tot+train_images(:,j);
        end
    end
    allmu=allmu/count;
    allmu_train=cat(2,allmu_train,allmu);
    Sw_train=cat(2,Sw_train,Sw);
    class_train=cat(2,class_train,(tot/count));
    count=0;
    tot=0;
end

label=[];
muY=[];
totY=[];

for i=1:ImageNum
    ctest=test_images(:,i);
    mu1=mean(ctest);
    S1=cov(ctest);
    mu_newct=[];
    for j=0:9
        Sw=S1+Sw_train(j+1);
        SB=(mu1-allmu_train(j+1))*(mu1-allmu_train(j+1))';
        invSw=inv(Sw);
        invSw_by_SB=invSw*SB;
% [vector,value]=eig(invSw_by_SB);

        [vector,value]=eig(SB,Sw,'chol');
        W=vector;
        Y=W*ctest;
        muY=cat(2,muY,mean(Y));
        totY=cat(2,totY,Y);
    end
    mudiff=[];
    for k=1:10
        mudiff=cat(2,mudiff,abs(muY(k)-ctest(k)));
    end
    newk=0;
    minmudiff=mudiff(1);
    for k=1:10
        if(mudiff(k)<minmudiff)
            minmudiff=mudiff(k);
            newk=k-1;
        end
    end
    label=cat(2,label,newk);
    muY=[];
    totY=[];
end

ok=0;
no=0;

for i=1:ImageNum
    if(label(i)==test_labels(i))
        ok=ok+1;
    else
        no=no+1;
    end
end
