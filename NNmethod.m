function [predictedlabel,class_ac] = NNmethod(traindata,evaldata,trainlabel,evallabel)
    % 各画像の特徴量の距離行列を作成して，分類してその精度を返す．
    % traindata,evaldata:特徴量行列
    % trainlabel,evallabel:各特徴量のラベル

    % 各画像同士の距離行列の作成
    % 行:traindata,列:evaldata
    Trowsize = size(traindata,1);
    colsize = size(traindata,2);
    Erowsize = size(evaldata,1);
    matrix1 = repmat(traindata,Erowsize,1);
    matrix2 = reshape(repmat(reshape(evaldata,1,Erowsize*colsize),Trowsize,1),Trowsize*Erowsize,colsize);
    D = reshape(sqrt(sum(((matrix1-matrix2).^2)')),Trowsize,Erowsize);
    
    % 各画像の分類と最も類似する画像のindexの検索
    [~,index] = min(D);
    predictedlabel = zeros(Erowsize,1);
    for i = 1:Erowsize
        predictedlabel(i,1) = trainlabel(index(i),1);
    end
    
    % 分類率
    correctnum = numel(find(evallabel==predictedlabel));
    class_ac = correctnum / Erowsize;
    
end