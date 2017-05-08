% Im is Nfold*Nfile cell
% Imv is 1*Nfold cell
% Im{nfold,nfile} is R*C
% Imv{nfold} is Dv*Nfile, Dv=R*C

function Im=vec2mat(Imv,R)
    Nfold=length(Imv); % # of folders
    [Dv,Nfile]=size(Imv{1}); % # of dimensions of datapoints and # of files per folder
    Im=cell(Nfold,Nfile);
    for nfold=1:Nfold
        for nfile=1:Nfile
            Imvnn=Imv{nfold}(:,nfile);
            Imvnn=mat2cell(Imvnn,R*ones(1,Dv/R),1);
            Imnn=cell2mat(transpose(Imvnn));
            Im{nfold,nfile}=Imnn;
        end
    end
end