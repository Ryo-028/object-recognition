function predict_preview(predictlabel,label,imgname,num)
    % 予測が合っていた画像，間違っていた画像をいくつか表示する．
    namelist = strings(4,1);
    count = zeros(1,4);
    for i=1:size(imgname,1)
        % クラス１で合っている画像
        if predictlabel(i)==1&&label(i)==1&&count(1)<2
            namelist(count(1)+1) = string(imgname(i));
            count(1) = count(1) + 1;
        % クラス１で間違っている画像
        elseif predictlabel(i)==2&&label(i)==1&&count(2)<2
            namelist(count(2)+3) = string(imgname(i));
            count(2) = count(2) + 1;
        % クラス2で合っている画像
        elseif predictlabel(i)==2&&label(i)==2&&count(3)<2
            namelist(count(3)+5) = string(imgname(i));
            count(3) = count(3) + 1;
        % クラス2で間違っている画像
        elseif predictlabel(i)==1&&label(i)==2&&count(4)<2
            namelist(count(4)+7) = string(imgname(i));
            count(4) = count(4) + 1;
        end
    end

    % 画像リストをファイル出力
    filename = sprintf('sample(BoF_nonLineSVM)/sampleimg%d.txt',num);
    FID = fopen(filename,'w');
    fprintf(FID,'%s\n',namelist);
    fclose(FID);
end