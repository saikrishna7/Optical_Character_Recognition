function classifier = KNN_classifier()
    f=dir('74k_EnglishHndProcessed64/*.png');
    files={f.name};
    images = zeros(3410,4096);
    for k=1:numel(files)
        img=imread(files{k});
        img = logical(img/255);
        images(k,:) = reshape(img,1,64*64);
    end
    X = images;


% Change the filenames if you have saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte

labels = [repmat('0',1,55) repmat('1',1,55) repmat('2',1,55) repmat('3',1,55) repmat('4',1,55) ...
        repmat('5',1,55) repmat('6',1,55) repmat('7',1,55) repmat('8',1,55) repmat('9',1,55) ...
        repmat('A',1,55) repmat('B',1,55) repmat('C',1,55)...
        repmat('D',1,55) repmat('E',1,55) repmat('F',1,55) repmat('G',1,55) repmat('H',1,55) ...
        repmat('I',1,55) repmat('J',1,55) repmat('K',1,55) repmat('L',1,55) repmat('M',1,55) ...
        repmat('N',1,55) repmat('O',1,55) repmat('P',1,55) repmat('Q',1,55) repmat('R',1,55) ...
        repmat('S',1,55) repmat('T',1,55) repmat('U',1,55) repmat('V',1,55) repmat('W',1,55) ...
        repmat('X',1,55) repmat('Y',1,55) repmat('Z',1,55) repmat('a',1,55) repmat('b',1,55) ...
        repmat('c',1,55) repmat('d',1,55) repmat('e',1,55) repmat('f',1,55) repmat('g',1,55) ...
        repmat('h',1,55) repmat('i',1,55) repmat('j',1,55) repmat('k',1,55) repmat('l',1,55) ...
        repmat('m',1,55) repmat('n',1,55) repmat('o',1,55) repmat('p',1,55) repmat('q',1,55) ...
        repmat('r',1,55) repmat('s',1,55) repmat('t',1,55) repmat('u',1,55) repmat('v',1,55) ...
        repmat('w',1,55) repmat('x',1,55) repmat('y',1,55) repmat('z',1,55)];
labels = reshape(labels,3410,1);   

k=20; %k value (no. of neighbours to be considered)

%or if you have too much fire in your ass 
%test=images(:,:); %if you want to use array

mdl = fitcknn(X,labels);
classifier=mdl;

% count=0;
% for i=1:size(test,2)
%     label = kNN (X, labels, test(:,i) , k);
%     if (label==testLabels(i,1))
%         disp('yes');
%         count=count+1
%         disp(label);
%     else
%         disp('no');
%     end
% end
% 
% display('Accuracy is: ');
% count/size(test,2)*100
% display('%');
% 
% end
% 
% function [label] = kNN(X, y, test_image, k)
% 
% m=size(X,2); %no. of images
% 
% %array to store RMS values
% Decider=zeros(m,1);
% 
% for i=1:m
%     Decider(i,1)=calc_diff(X(:,i), test_image);
% end
% 
% label=0;
% 
% indices=return_n_min(Decider,k);
% 
% Labels=zeros(k,1);
% 
% %Labels array store the value in labels array to get info about the class of image. 
% for i=1: size(indices,2)
%     Labels(i)=labels(indices(i),1);
% end
% 
% %the answer, the class to which that test image belong.
% label=mode(Labels);
% 
% 
% end
% 
% % function to return indices of neighbours with min. RMS diff to calculate
% % class of test set
% function [V] = return_n_min(Arr, n)
% for z=1:n
%     [M,I]=min(Arr);
%     V(z)=I;
%     Arr(I)=Inf;
% end
% end
% 
% 
% %calculates RMS difference between two vectors and return an integer value
% function [weight] = calc_diff(X1, X2)
% n=size(X1,1);
% weight=0;
% for i=1:n
%     weight = weight + sqrt( (X2(i,1)-X1(i,1))^2 ) ; 
% end
% end
