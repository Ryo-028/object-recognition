function histdata = makehist64list(imglist)
    % 渡された画像の名前リストから各画像のカラーヒストグラム(正規化済み)を行列で返す．
    histdata = [];
    for i=1:length(imglist)
        img=imread(imglist{i});
        RED = img(:,:,1);
        GREEN = img(:,:,2);
        BLUE = img(:,:,3);
        img_64 = uint8(floor(double(RED)/64) *4*4 + ...
            floor(double(GREEN)/64) *4 + floor(double(BLUE)/64));
        img_64_vec=reshape(img_64,1,numel(img_64));
        hist=histc(img_64_vec,[0:63]);
        hist = hist / sum(hist);
        histdata=[histdata; hist];
    end
end

