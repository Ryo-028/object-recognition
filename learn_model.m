function model = learn_model(modelname,layer_name,training_List,training_label)
    % dcnn特徴を抽出して学習を行う
    net = modelname;
    IM = [];
    % 画像を束ねる
    for i=1:size(training_List,1)
        img = imread(training_List{i});
        reimg = imresize(img,net.Layers(1).InputSize(1:2)); 
        IM=cat(4,IM,reimg); 
    end
    
    % DCNN特徴を抽出する
    dcnnf = activations(net,IM,layer_name);  
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    dcnnf = dcnnf.';
    
    % 線形SVMを学習
    model = fitcsvm(dcnnf, training_label,'KernelFunction','linear'); 
end