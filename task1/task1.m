%% Scalar Variables
a = 2^8;
b = 22/7 - pi;
c = nthroot(9^2+(19^2)/22, 4) - pi;
d = pi - exp(pi);
e = log10(2);
f = tanh(exp(1));

%% Vector Variables
p = [3.14 15 9 26];

% generating variable 'r'
upper_limit = 100;
r = zeros(1,100);
counter = 1;

while counter <= upper_limit
	r(counter) = 101 - counter;
    counter = counter + 1;
end

% generating variable 's'
p = [3.14 15 9 26];

% generating variable 'r'
s = zeros(1,100);
counter = 1;

while counter <= upper_limit
	s(counter) = (counter-1)/99;
    counter = counter + 1;
end

%% Matrix Variables
u = ones(9, 9)*2;

% generating variable 'v'
diag_array = [1 2 3 4 5 4 3 2 1]
v = diag(diag_array)

% generating variable 'w'
w = 1:100
w = reshape(w, [10, 10])