function hist = makehist64(img)
    % 渡された画像データからカラーヒストグラムを作成して返す．
    RED = img(:,:,1);
    GREEN = img(:,:,2);
    BLUE = img(:,:,3);
    img_64 = uint8(floor(double(RED)/64) *4*4 + ...
        floor(double(GREEN)/64) *4 + floor(double(BLUE)/64));
    img_64_vec=reshape(img_64,1,numel(img_64));
    hist=histc(img_64_vec,[0:63]);
end