function write_image(img, img_name)
    disp("The image will be written inside the `img_out` folder!")  
    img_path = strcat("./img_out/", img_name);
    imwrite(img, img_path);
    fprintf("The image is successfully written in %s", img_path);
end