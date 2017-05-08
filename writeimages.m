% Im is Nfold*Nfile cell
% Im{nfold,nfile} is R*C

function writeimages(Im,foldtitle,foldnum,fileext,filenum)
    Nfold=length(foldnum); % # of folders
    Nfile=length(filenum); % # of files
    for nfold=1:Nfold
        mkdir([foldtitle,num2str(foldnum(nfold))]);
        for nfile=1:Nfile
            filename=[foldtitle,num2str(foldnum(nfold)),'/',num2str(filenum(nfile)),'.',fileext];
            imwrite(uint8(Im{nfold,nfile}),filename);
        end
    end
end