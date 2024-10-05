function [img, img_name] = read_image()
    disp("Make sure to put the image inside the `img_in` folder!")    
    img_name = input("Which image do you want to process? ", 's');
    img_path = strcat("./img_in/" + img_name);
    img = imread(img_path); 
end
