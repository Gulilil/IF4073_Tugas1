function img = read_image(img_name)
    img_path = strcat("./img_in/" + img_name);
    if exist(img_path, 'file')
        img = imread(img_path); 
    else
        img = NaN;
    end
end
