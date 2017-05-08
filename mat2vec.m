% Im is Nfold*Nfile cell
% Imv is 1*Nfold cell
% Im{nfold,nfile} is R*C
% Imv{nfold} is Dv*Nfile, Dv=R*C

function Imv=mat2vec(Im)
    [Nfold,Nfile]=size(Im); % # of folders and # of files per folder
    Imv=cell(1,Nfold);
    for nfold=1:Nfold
        for nfile=1:Nfile
            Imnn=Im{nfold,nfile};
            [R,C]=size(Imnn);
            Imnn=mat2cell(Imnn,R,ones(1,C));
            Imvnn=cell2mat(transpose(Imnn));
            Imv{nfold}(:,nfile)=Imvnn;
        end
    end
end