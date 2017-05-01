% It may help to forget LDA for a while and directly create a linear classifier using the slash operator. For example, since your images are of 10 digits 0:9, your target matrix should contains columns of the 10-dimensional unit matrix eye(10) where the row index of the 1 indicates the correct class index.
% 
% I doubt if you need all of the pixels in a 28X28 matrix. Therefore, I suggest averaging pixels to get a much smaller number I = nrowsr*ncolumns < 28*28.
% 
% Next, use the colon operator (:) to convert the matrices to column vectors. For each of the 10 classes choose a number of noisy training samples with Ntrni >> I for i = 1:10.
% 
% Form the input and target matrices with dimensions

[ I N ] = size(input);

[O N ] = size(target);

% O = 10 and N = sum(Ni) >> 10*I (e.g., ~ 100*I)

% The linear model is

y = W * [ ones(1,N) ; input ];

% where the row of ones yield bias weights. The weight matrix is obtained from the slash LMSE solution

W = target/[ ones(1,N) ; input ];

% Class assignments are obtaned from

class = vec2ind(y);