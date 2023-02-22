function DCNN_LineSVM(class1name,class2name)
    % DCNN特徴と線形SVMで画像を分類する.
    % 画像の読み込み
    class1List=textread(class1name,'%s');
    class2List=textread(class2name,'%s');
    
    cv=5;
    accuracy=[];
    idx1=1:size(class1List,1);
    idx2=1:size(class2List,1);
    
    for i=1:cv 
        % トレーニングデータとテストデータの選択
        train_class1=class1List(find(mod(idx1,cv)~=(i-1)),:);
        eval_class1 =class1List(find(mod(idx1,cv)==(i-1)),:);
        train_class2=class2List(find(mod(idx2,cv)~=(i-1)),:);
        eval_class2=class2List(find(mod(idx2,cv)==(i-1)),:);
        
        training_data=[train_class1; train_class2];
        eval_data=[eval_class1; eval_class2];
        
        train_label=[ones(numel(train_class1),1); ones(numel(train_class2),1)*2];
        eval_label =[ones(numel(eval_class1),1); ones(numel(eval_class2),1)*2];
        
        % 学習
        model = learn_model(vgg16,'fc7',training_data,train_label);
        % 分類
        [predicted_label, scores] = predict_model(model,vgg19,'fc7',eval_data);
        ac = numel(find(eval_label==predicted_label))/numel(eval_label); % 評価
        accuracy=[accuracy ac];
        fprintf("accuracy%d : %f\n", i, ac);

        % 画像の保存
        predict_preview(predicted_label,eval_label,eval_data,i);
    end
    % 精度の表示
    fprintf('accuracy: %f\n',mean(accuracy))
end