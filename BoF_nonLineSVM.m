function BoF_nonLineSVM(class1name,class2name)
    % BoFベクトルと非線形SVMで画像を分類する.
    % 画像の読み込み
    class1List=textread(class1name,'%s');
    class2List=textread(class2name,'%s');
    class1size = size(class1List,1);
    class2size = size(class2List,1);
    
    % コードブックの作成
    datanamelist = [class1List; class2List];
    codebook = makecodebook(datanamelist);
    % bof特徴ベクトルの作成
    bof = makebof(codebook,datanamelist);
    bof_class1 = bof(1:class1size,:);
    bof_class2 = bof(class1size+1:class1size+class2size,:);

    cv=5;
    accuracy=[];
    idx1=1:size(class1List,1);
    idx2=1:size(class2List,1);
    
    for i=1:cv 
        % トレーニングデータとテストデータの分割
        training_class1=bof_class1(find(mod(idx1,cv)~=(i-1)),:);
        eval_class1=bof_class1(find(mod(idx1,cv)==(i-1)),:);
        eval_name1=class1List(find(mod(idx1,cv)==(i-1)),:);
        training_class2=bof_class2(find(mod(idx2,cv)~=(i-1)),:);
        eval_class2=bof_class2(find(mod(idx2,cv)==(i-1)),:);
        eval_name2=class2List(find(mod(idx2,cv)==(i-1)),:);
        training_data=[training_class1; training_class2];
        eval_data=[eval_class1; eval_class2];
        eval_name=[eval_name1; eval_name2];
        
        training_label=[ones(size(training_class1,1),1); ones(size(training_class2,1),1)*2];
        eval_label =[ones(size(eval_class1,1),1); ones(size(eval_class2,1),1)*2];

        % 非線形SVMの学習
        model = fitcsvm(training_data, training_label,'KernelFunction','rbf', 'KernelScale','auto');
        % 分類
        [predicted_label, ~] = predict(model, eval_data);
        ac = numel(find(eval_label==predicted_label))/numel(eval_label);
        accuracy=[accuracy ac];
        fprintf("accuracy%d : %f\n", i, ac);

        % 画像の保存
        predict_preview(predicted_label,eval_label,eval_name,i);
    end
    % 精度の表示
    fprintf('accuracy: %f\n',mean(accuracy))
end