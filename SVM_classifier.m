% folder = 'C:\Mizzou works\Spring 2017\Intro to Machine learning and Pattern Recognition\Optical_Character_Recognition\74k_EnglishImgProcessed';
function classifier = SVM_classifier()
    f=dir('*.png');
    files={f.name};
    
    for k=1:numel(files)
      Im{k}=imread(files{k});
    end

    Imv=mat2vec(Im); % convert image matrices into datapoint vectors
    X=double(Imv{1}');

%     numbers=uint8([ones(1,105)*0 ones(1,79)*1 ones(1,70)*2 ones(1,50)*3 ones(1,47)*4 ones(1,64)*5 ones(1,64)*6 ...
%         ones(1,48)*7 ones(1,32)*8 ones(1,34)*9]);

%     y = [repmat('0',1,105) repmat('1',1,79) repmat('2',1,70) repmat('3',1,50) repmat('4',1,47) ...
%         repmat('5',1,64) repmat('6',1,64) repmat('7',1,48) repmat('8',1,32) repmat('9',1,34) ...
%         repmat('A',1,558) repmat('B',1,115) repmat('C',1,215)...
%         repmat('D',1,191) repmat('E',1,446) repmat('F',1,79) repmat('G',1,143) repmat('H',1,193) ...
%         repmat('I',1,302) repmat('J',1,77) repmat('K',1,92) repmat('L',1,215) repmat('M',1,149) ...
%         repmat('N',1,363) repmat('O',1,382) repmat('P',1,159) repmat('Q',1,35) repmat('R',1,389) ...
%         repmat('S',1,342) repmat('T',1,312) repmat('U',1,92) repmat('V',1,84) repmat('W',1,67) ...
%         repmat('X',1,80) repmat('Y',1,67) repmat('Z',1,55) repmat('a',1,158) repmat('b',1,38) ...
%         repmat('c',1,63) repmat('d',1,46) repmat('e',1,227) repmat('f',1,37) repmat('g',1,36) ...
%         repmat('h',1,52) repmat('i',1,127) repmat('j',1,33) repmat('k',1,34) repmat('l',1,58) ...
%         repmat('m',1,43) repmat('n',1,135) repmat('o',1,148) repmat('p',1,37) repmat('q',1,54) ...
%         repmat('r',1,126) repmat('s',1,124) repmat('t',1,111) repmat('u',1,41) repmat('v',1,33) ...
%         repmat('w',1,36) repmat('x',1,35) repmat('y',1,43) repmat('z',1,35)];
%     y = reshape(y,7705,1);

    y = uint8([ones(1,158)*97 ones(1,52)*104 ones(1,127)*105 ones(1,34)*107 ones(1,135)*110 ones(1,126)*114 ones(1,124)*115]);
    y = reshape(y,756,1);  
    
    % Train and Predict Using a SVM
    t = templateSVM('Standardize',1,'KernelFunction','gaussian');
    Mdl = fitcecoc(X,y,'Learners',t,'FitPosterior',1,'Verbose',2);
    classifier=Mdl;
    
end