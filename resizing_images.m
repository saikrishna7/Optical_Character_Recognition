files = [dir('letters_numbers\*.PNG');dir('letters_numbers\*.BMP')];

for k = 1:numel(files)
    rgb = imread(['letters_numbers\' files(k).name]);
%    rgb = rgb(1:1800, 520:2000, :);
    rgb = imresize(rgb, [16 16], 'bicubic');
    imwrite(rgb, ['cropped\' files(k).name],'PNG');
end