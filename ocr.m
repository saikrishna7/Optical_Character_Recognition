imagen=imread('test3.png');
% Show image
imagen1 = imagen;
figure,imshow(imagen1);

% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end

% Convert to BW
threshold = graythresh(imagen);

imagen = ~im2bw(imagen,threshold);
imshow(imagen)

imagen2 = imagen;

imagen = bwareaopen(imagen,15);

imagen3 = imagen;
imshow(imagen3)

word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');

% Load templates
load templates
global templates
i=0;
j=0;
Images={};
% Compute the number of letters in template file
num_letters=size(templates,2);
while 1
    i=i+1; 
    %Fcn 'lines_crop' separate lines in text
    [fl re]=lines_crop(re); %fl= first line, re= remaining image
    imgn=fl;
    n=0;
    
    spacevector = [];  % to compute the total spaces betweeen adjacent letter
    rc = fl;              

    while 1
        j=j+1;
        %'letter_crop' function separates letters in a line
       [fc rc space]=letter_crop(rc);  %fc =  first letter in the line
                                       %rc =  remaining cropped line
                                       %space = space between the letter cropped and the next letter
       
       img_r = fc;
       img_r = imresize(img_r,[64 64]);   %resize letter so that correlation can be performed
       n = n + 1;
       spacevector(n)=space;
       imshow(img_r)
       Images{j}=img_r;
       
       letter = read_letter(img_r,num_letters);
       
       %letter concatenation
       word = [word letter];
       
       if isempty(rc)  %breaks loop when there are no more characters
           break;
        end
    end
    
            
    fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  
        break
    end    
end


fclose(fid);
winopen('text.txt')
clear all
close all
clc