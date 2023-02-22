function [predicted_label, scores] = predict_model(model,modelname,layer_name,eval_List)
    % 学習済みモデルで画像を分類する.
    net = modelname;
    IM = [];
    % 画像を束ねる
    for i=1:size(eval_List,1)
        img = imread(eval_List{i});
        reimg = imresize(img,net.Layers(1).InputSize(1:2)); 
        IM=cat(4,IM,reimg); 
    end
    % DCNN特徴を抽出する
    dcnnf = activations(net,IM,layer_name);  
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    dcnnf = dcnnf.';
    %分類する
    [predicted_label, scores] = predict(model, dcnnf);
end