%CREATE TEMPLATES
%Letter
clc;
close all;
A=imread('cropped\A.PNG');B=imread('cropped\B.PNG');
C=imread('cropped\C.PNG');D=imread('cropped\D.PNG');
E=imread('cropped\E.PNG');F=imread('cropped\F.PNG');
G=imread('cropped\G.PNG');H=imread('cropped\H.PNG');
I=imread('cropped\I.PNG');J=imread('cropped\J.PNG');
K=imread('cropped\K.PNG');L=imread('cropped\L.PNG');
M=imread('cropped\M.PNG');N=imread('cropped\N.PNG');
O=imread('cropped\O.PNG');P=imread('cropped\P.PNG');
Q=imread('cropped\Q.PNG');R=imread('cropped\R.PNG');
S=imread('cropped\S.PNG');T=imread('cropped\T.PNG');
U=imread('cropped\U.PNG');V=imread('cropped\V.PNG');
W=imread('cropped\W.PNG');X=imread('cropped\X.PNG');
Y=imread('cropped\Y.PNG');Z=imread('cropped\Z.PNG');
%lower case letters
a=imread('cropped\a.bmp');b=imread('cropped\b.bmp');
c=imread('cropped\c.bmp');d=imread('cropped\d.bmp');
e=imread('cropped\e.bmp');f=imread('cropped\f.bmp');
g=imread('cropped\g.bmp');h=imread('cropped\h.bmp');
i=imread('cropped\i.bmp');j=imread('cropped\j.bmp');
k=imread('cropped\k.bmp');l=imread('cropped\l.bmp');
m=imread('cropped\m.bmp');n=imread('cropped\n.bmp');
o=imread('cropped\o.bmp');p=imread('cropped\p.bmp');
q=imread('cropped\q.bmp');r=imread('cropped\r.bmp');
s=imread('cropped\s.bmp');t=imread('cropped\t.bmp');
u=imread('cropped\u.bmp');v=imread('cropped\v.bmp');
w=imread('cropped\w.bmp');x=imread('cropped\x.bmp');
y=imread('cropped\y.bmp');z=imread('cropped\z.bmp');


%Number
one=imread('cropped\1.png');  two=imread('cropped\2.png');
three=imread('cropped\3.png');four=imread('cropped\4.png');
five=imread('cropped\5.png'); six=imread('cropped\6.png');
seven=imread('cropped\7.png');eight=imread('cropped\8.png');
nine=imread('cropped\9.png'); zero=imread('cropped\0.png');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
number=[one two three four five...
    six seven eight nine zero];

 
    
lowercase = [a b c d e f g h i j k ...
     l m n o p q r s t u v w x y z];
character=[letter number lowercase];
grayscale_imgs=rgb2gray(character);

templates=mat2cell(grayscale_imgs,16,[16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16]);


save ('templates','templates')
clear all