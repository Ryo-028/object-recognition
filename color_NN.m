function color_NN(class1name,class2name)
    % カラーヒストグラムと最近傍分類で画像を分類する．
    
    % 画像の読み込み
    class1List=textread(class1name,'%s');
    class2List=textread(class2name,'%s');
    
    cv=5;
    accuracy=[];
    idx1=1:size(class1List,1);
    idx2=1:size(class2List,1);
    
    for i=1:cv 
        % トレーニングデータとテストデータの分割
        train_class1=class1List(find(mod(idx1,cv)~=(i-1)),:);
        eval_class1 =class1List(find(mod(idx1,cv)==(i-1)),:);
        train_class2=class2List(find(mod(idx2,cv)~=(i-1)),:);
        eval_class2=class2List(find(mod(idx2,cv)==(i-1)),:);
        
        train_name=[train_class1; train_class2];
        eval_name=[eval_class1; eval_class2];
        
        train_label=[ones(numel(train_class1),1); ones(numel(train_class2),1)*2];
        eval_label =[ones(numel(eval_class1),1); ones(numel(eval_class2),1)*2];
        
        % 特徴量を求める
        train_data = makehist64list(train_name);
        eval_data = makehist64list(eval_name);
        
        % 分類
        [predicted_label,ac] = NNmethod(train_data,eval_data,train_label,eval_label);
        accuracy=[accuracy ac];
        fprintf("accuracy%d : %f\n", i, ac);
        
        % 画像の保存
        predict_preview(predicted_label,eval_label,eval_name,i);
    end
    % 精度の表示
    fprintf('accuracy: %f\n',mean(accuracy))
end