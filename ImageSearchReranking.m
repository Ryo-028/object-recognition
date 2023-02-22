function ImageSearchReranking(posListname,negListname,testListname,test_Label,n)
    % 検索画像をリランキングする
    % 学習画像の読み込み
    posList=textread(posListname,'%s');
    negList=textread(negListname,'%s');
    posList = posList(1:n);
    training_List = [posList; negList];
    training_label = [ones(numel(posList),1); ones(numel(negList),1)*(-1)];

    % DCNN特徴を抽出線形SVMを学習する．
    model = learn_model(vgg16,'fc7',training_List,training_label);
    
    % テスト画像の読み込み
    test_List=textread(testListname,'%s');
    test_Label = textread(test_Label,'%d');
    
    % 分類してsortする
    [~, scores] = predict_model(model,vgg16,'fc7',test_List);
    [sorted_score,sorted_idx] = sort(scores(:,2),'descend');
    
    % 画像のパスとテストのラベルをソートの順に並び替える
    test_List = string(test_List);
    filepath = strings(size(sorted_idx,1),1);
    sorted_testLabel = zeros(size(sorted_idx,1),1);
    for i = 1:numel(sorted_idx)
        filepath(i,1) = test_List(sorted_idx(i));
        sorted_testLabel(i) = test_Label(sorted_idx(i));
    end
    
    % 精度の表示
    before_accuracy = numel(find(test_Label(1:100)==1))/100
    after_accuracy = numel(find(sorted_testLabel(1:100)==1))/100

    % 画像のnameとscoreをtextfileに出力
    FID = fopen('rerank50.txt','w');
    for i = 1:size(filepath,1)
        fprintf(FID,'%s ',filepath(i));
        fprintf(FID,'%.5f\n',sorted_score(i));
    end
    fclose(FID);
end