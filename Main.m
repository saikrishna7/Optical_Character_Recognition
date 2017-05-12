
imagen=imread('name.png');
% Show image
imagen1 = imagen;
figure,imshow(imagen1);
title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
% Convert to BW
threshold = graythresh(imagen);

imagen = ~im2bw(imagen,threshold);
imshow(imagen)

imagen2 = imagen;

re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');

i=0;
j=0;
Images={};

while 1
    i=i+1; 
    %'lines_crop' function separates lines in text
    [fl re]=lines_crop(re); %fl= first line, re= remaining image
    imgn=fl;
    n=0;
    rc = fl;              
    
    while 1
        j=j+1;
        %Fcn 'letter_crop' separate letters in a line
       [fc rc space]=letter_crop(rc);  %fc =  first letter in the line
                                       %rc =  remaining cropped line
                                       %space = space between the letter cropped and the next letter
      
       [a,b] = size(fc);
       padsize_row = floor((64-a)/2);
       padsize_col = floor((64-b)/2);
       img_r = fc;
       if(a<64)
           img_r=padarray(img_r,[padsize_row 0]);
       end
       if(b<64)
           img_r=padarray(img_r,[0 padsize_col]);
       end
       img_r = imresize(img_r,[64 64]);   %resize letter so that correlation can be performed
       n = n + 1;
       spacevector(n)=space;
       imshow(img_r)
       img_r=imcomplement(img_r)
       Images{j}=img_r;
              
       if isempty(rc)  %breaks loop when there are no more characters
           break;
        end
    end
    
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end

Imv=mat2vec(Images); % convert image matrices into datapoint vectors

% Ytest=double(Imv{1}');
% Ylabels=[75,82,73,83,72,78,65];

f=dir('74k_EnglishHndProcessed64_Test/*.png');
    files={f.name};
    n = numel(files);
    images = zeros(n,64*64);
    for k=1:n
        img=imread(files{k});
        img = logical(img/255);
%         features = feature_extractor(img);
%         images(k,:) = features';
        images(k,:) = reshape(img,1,64*64);
    end
    Ytest = images;
    Ylabels = uint8([ones(1,5)*48 ones(1,5)*49 ones(1,5)*50 ones(1,5)*51 ones(1,5)*52 ones(1,5)*53 ...
        ones(1,5)*54 ones(1,5)*55 ones(1,5)*56 ones(1,5)*57 ones(1,5)*65 ...
        ones(1,5)*66 ones(1,5)*67 ones(1,5)*68 ...
        ones(1,5)*69 ones(1,5)*70 ones(1,5)*71 ones(1,5)*72 ones(1,5)*73 ...
        ones(1,5)*74 ones(1,5)*75 ones(1,5)*76 ones(1,5)*77 ones(1,5)*78 ...
        ones(1,5)*79 ones(1,5)*80 ones(1,5)*81 ones(1,5)*82 ones(1,5)*83 ...
        ones(1,5)*84 ones(1,5)*85 ones(1,5)*86 ones(1,5)*87 ...
        ones(1,5)*88 ones(1,5)*89 ones(1,5)*90 ones(1,5)*97 ones(1,5)*98 ...
        ones(1,5)*99 ones(1,5)*100 ones(1,5)*101 ones(1,5)*102 ones(1,5)*103 ...
        ones(1,5)*104 ones(1,5)*105 ones(1,5)*106 ones(1,5)*107 ones(1,5)*108 ...
        ones(1,5)*109 ones(1,5)*110 ones(1,5)*111 ones(1,5)*112 ones(1,5)*113 ...
        ones(1,5)*114 ones(1,5)*115 ones(1,5)*116 ones(1,5)*117 ones(1,5)*118 ...
        ones(1,5)*119 ones(1,5)*120 ones(1,5)*121 ones(1,5)*122]);
    Ylabels = reshape(Ylabels,n,1);    
    


mdl_ctree = DT_classifier();
Ypred = predict(mdl_ctree,Ytest);
Ypred=uint8(Ypred);
disp(char(Ypred));
Confmat_bag = confusionmat(Ypred,Ylabels);
stats=confusionmatStats(Ypred,Ylabels);
sprintf('%dAccuracy',sum(stats.accuracy)/62)
% view(mdl_ctree)
% Confusion Matrices
figure,
heatmap(Confmat_bag, 0:9, 0:9, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);
title('Confusion Matrix: Ensemble of Bagged Classification Trees')


% [r,c] = size(Xtest);
% for j = 1: 10
%     model = mdl_ctree.Trained(j);
%     model = model{1};
%     for i = 1: r
%         im = Xtest(i,:);
%         im = reshape(im,64,64);
%         im = imcomplement(im);
%     %     im = uint8(im*255);
%         test_features = reshape(im,1,64*64);
%     %     test_features = double(test_features)/255;
%     %     test_features = feature_extractor(im)';
%         ypred = predict(model,test_features);
%         disp(char(ypred));
%     %     keyboard
%     end
%     disp('======');
% end


% 
% Mdl=KNN_classifier();
% label = predict(Mdl,Xtest);
% disp(char(label));
% [label,score,cost] = predict(Mdl,X)


% Mdl=SVM_classifier();
% [label,~,~,Posterior] = resubPredict(Mdl,1);
% disp(Mdl.BinaryLoss);
% 
% idx = randsample(size(Images,2),10,1);
% disp(Mdl.ClassNames);
% table(Y(idx),label(idx),Posterior(idx,:),...
%     'VariableNames',{'TrueLabel','PredLabel','Posterior'})




% fclose(fid);
% winopen('text.txt')
% clear all
% i = 4
% im = Xtest(i,:);
%     im = reshape(im,64,64);
%     im = imcomplement(im);
%     imshow(im);.



%  f=dir('a/*.JPG');
%  files={f.name};
%  for i = 1: numel(files)
%      img=imread(strcat('a/',files{i}));
%      img = imresize(img,[64 64]);
%      imwrite(img,fullfile('C:\Users\saikr\Desktop\a\',sprintf('%d.bmp', files{i})));
%  end
%        