% Im is Nfold*Nfile cell
% Im{nfold,nfile} is R*C

function Im=readimages(foldtitle,foldnum,fileext,filenum)
    Nfold=length(foldnum); % # of folders
    Nfile=length(filenum); % # of files
    Im=cell(Nfold,Nfile);
    for nfold=1:Nfold
        for nfile=1:Nfile
            filename=[foldtitle,num2str(foldnum(nfold)),'/',num2str(filenum(nfile)),'.',fileext];
            Im{nfold,nfile}=double(imread(filename));
        end
    end
end