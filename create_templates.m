%CREATE TEMPLATES
%Letter
clc;
close all;
A=imread('correlation\A.PNG');B=imread('correlation\B.PNG');
C=imread('correlation\C.PNG');D=imread('correlation\D.PNG');
E=imread('correlation\E.PNG');F=imread('correlation\F.PNG');
G=imread('correlation\G.PNG');H=imread('correlation\H.PNG');
I=imread('correlation\I.PNG');J=imread('correlation\J.PNG');
K=imread('correlation\K.PNG');L=imread('correlation\L.PNG');
M=imread('correlation\M.PNG');N=imread('correlation\N.PNG');
O=imread('correlation\O.PNG');P=imread('correlation\P.PNG');
Q=imread('correlation\Q.PNG');R=imread('correlation\R.PNG');
S=imread('correlation\S.PNG');T=imread('correlation\T.PNG');
U=imread('correlation\U.PNG');V=imread('correlation\V.PNG');
W=imread('correlation\W.PNG');X=imread('correlation\X.PNG');
Y=imread('correlation\Y.PNG');Z=imread('correlation\Z.PNG');
%lower case letters
a=imread('correlation\a.bmp');b=imread('correlation\b.bmp');
c=imread('correlation\c.bmp');d=imread('correlation\d.bmp');
e=imread('correlation\e.bmp');f=imread('correlation\f.bmp');
g=imread('correlation\g.bmp');h=imread('correlation\h.bmp');
i=imread('correlation\i.bmp');j=imread('correlation\j.bmp');
k=imread('correlation\k.bmp');l=imread('correlation\l.bmp');
m=imread('correlation\m.bmp');n=imread('correlation\n.bmp');
o=imread('correlation\o.bmp');p=imread('correlation\p.bmp');
q=imread('correlation\q.bmp');r=imread('correlation\r.bmp');
s=imread('correlation\s.bmp');t=imread('correlation\t.bmp');
u=imread('correlation\u.bmp');v=imread('correlation\v.bmp');
w=imread('correlation\w.bmp');x=imread('correlation\x.bmp');
y=imread('correlation\y.bmp');z=imread('correlation\z.bmp');

a=rgb2gray(a);
b=rgb2gray(b);
c=rgb2gray(c);
d=rgb2gray(d);
e=rgb2gray(e);
f=rgb2gray(f);
g=rgb2gray(g);
h=rgb2gray(h);
i=rgb2gray(i);
j=rgb2gray(j);
k=rgb2gray(k);
l=rgb2gray(l);
m=rgb2gray(m);
n=rgb2gray(n);
o=rgb2gray(o);
p=rgb2gray(p);
q=rgb2gray(q);
r=rgb2gray(r);
s=rgb2gray(s);
t=rgb2gray(t);
u=rgb2gray(u);
v=rgb2gray(v);
w=rgb2gray(w);
x=rgb2gray(x);
y=rgb2gray(y);
z=rgb2gray(z);

%Number
one=imread('correlation\1.png');  two=imread('correlation\2.png');
three=imread('correlation\3.png');four=imread('correlation\4.png');
five=imread('correlation\5.png'); six=imread('correlation\6.png');
seven=imread('correlation\7.png');eight=imread('correlation\8.png');
nine=imread('correlation\9.png'); zero=imread('correlation\0.png');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
number=[one two three four five...
    six seven eight nine zero];

 
    
lowercase = [a b c d e f g h i j k ...
     l m n o p q r s t u v w x y z];
character=[letter number lowercase];
character=imcomplement(character);
% grayscale_imgs=rgb2gray(character);

templates=mat2cell(character,64,[64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64 64 ...
    64 64 64 64 64 64]);


save ('templates','templates')
clear all