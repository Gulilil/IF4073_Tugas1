function img = read_image(img_name)
    img_path = strcat("./img_in/" + img_name);
    img = imread(img_path); 
end
