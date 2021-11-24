% Code for envelope
% a, d, and r can be [0 1000], s is [0 1]
% Sometimes this breaks when adjusting variables, but 
% works again without changing anything on second run?
% Adjustable values to be convolved with sounds

t = 0:0.001:3.2;
td = 0.001:0.001:d/1000;
tr = 0.001:0.001:r/1000;
dt = 0.001;
a = 200;
d = 0;
s = 1;
r = 200;

env = ones(1, 3201);

for i = 1:length(t)
    if i <= a+1
        env(i) = 1/a * t(i) * 1000;
    elseif i < a + d + 1
        env(i) = 1 + td(i-a) * ((s - 1)/d)*1000;
    elseif i < a + d + 201
        env(i) = s;
    elseif i < a + d + r + 201
        env(i) = s - tr(i-a-d-200) * (s/r)*1000;
    else
        env(i) = 0;
    end
end

figure(1)
plot(t, env)
ylim([0 1.2])
xlim([0 3.2])