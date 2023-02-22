function downloadimg(imgURLlist)
    % 渡されたURLリストの画像をダウンロードする．
    list=textread(imgURLlist,'%s');
    OUTDIR='testpancakedir';
    mkdir(OUTDIR);
    for i=1:size(list,1)
        fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg')
        try
            websave(fname,list{i});
        catch
        end
    end
end