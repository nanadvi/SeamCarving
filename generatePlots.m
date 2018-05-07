files = dir('result/im2/*.JPG');
for i=1:size(files)
    figure
    img = fullfile(files(i).folder, files(i).name);
    subplot(3,3,i), imshow(imread(img));
end
