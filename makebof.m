function bof2 = makebof(codebook,list)
    % 渡されたコードブックと画像リストからbofベクトル行列を返す.
    listsize = size(list,1);
    bof = zeros(listsize,500);
    % bof行列を作成
    % 全画像でSURF特徴を抽出
    for j=1:listsize
        I=rgb2gray(imread(list{j}));
        p=createRandomPoints(I,2000);
        [f,p2]=extractFeatures(I,p);
        % 各特徴に最も類似したvisual wordを探索
        for i=1:size(p2,1)
            matrix_a = repmat(f(i,:),size(codebook,1),1);
            matrix_a = sqrt(sum((codebook-matrix_a).^2,2));
            [~, index] = min(matrix_a);
            %visual wordの出現をカウント
            bof(j,index)=bof(j,index)+1;
        end
    end
    % 各行の合計を1に正規化
    bof2 = bof ./ sum(bof,2);
end