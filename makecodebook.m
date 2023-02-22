function codebook = makecodebook(datanamalist)
    % 渡された画像リストからコードブックを作成する.
    Features=[];
    listsize = size(datanamalist,1);
    for i=1:listsize
        I=rgb2gray(imread(datanamalist{i}));
        p=createRandomPoints(I,2000);
        [f,p2]=extractFeatures(I,p);
        Features=[Features; f];
    end
    [idx,codebook]=kmeans(Features,500);
end