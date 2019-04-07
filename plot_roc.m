clc; clear all;

%%
figure(1);
A =[0, 1, 1;
0.1, 0.225437, 0.902591;
0.2, 0.170975, 0.884789;
0.3, 0.136737, 0.863401;
0.4, 0.113389, 0.842324;
0.5, 0.097127, 0.812933;
0.6, 0.0856356, 0.770432;
0.7, 0.0765638, 0.704669;
0.8, 0.0688839, 0.601355;
0.9, 0.0598219, 0.475486;
1.0, 0.0, 0.0];

Prob = A(:, 1);
Precision = A(:, 2);
Recall = A(:, 3);

plot(Precision, Recall, 'k-.'); hold on;
A =[0, 1, 1;
0.1, 0.500301, 0.826268;
0.2, 0.388887, 0.774459;
0.3, 0.30375, 0.724488;
0.4, 0.239102, 0.669402;
0.5, 0.182503, 0.611215;
0.6, 0.150412, 0.520323;
0.7, 0.126102, 0.453346;
0.8, 0.102918, 0.373166;
0.9, 0.0759655, 0.250662;
1.0, 0.0, 0.0];

Prob = A(:, 1);
Precision = A(:, 2);
Recall = A(:, 3);

plot(Precision, Recall, 'k-'); hold on;

A =[0, 1, 1;
0.1, 0.184026, 0.846078;
0.2, 0.123731, 0.799863;
0.3, 0.0925575, 0.755938;
0.4, 0.0726977, 0.712214;
0.5, 0.0533132, 0.66482;
0.6, 0.0447825, 0.608492;
0.7, 0.0379329, 0.544067;
0.8, 0.0320088, 0.467825;
0.9, 0.0260234, 0.359382;
1.0, 0.0, 0.0];

Prob = A(:, 1);
Precision = A(:, 2);
Recall = A(:, 3);

plot(Precision, Recall, 'k--'); hold on;

title('ROC Curve'); hold on;
xlabel('False Positive Rate'); hold on;
ylabel('True Positive Rate'); hold on;
legend('Hilbertmap EUROC VICON01 Easy', 'Hilbertmap EUROC VICON02 Medium', 'Hilbertmap EUROC VICON03 Difficult'); hold off;

%%
%%
figure(2);
A =[0, 1, 1;
0.1, 0.225437, 0.902591;
0.2, 0.170975, 0.884789;
0.3, 0.136737, 0.863401;
0.4, 0.113389, 0.842324;
0.5, 0.097127, 0.812933;
0.6, 0.0856356, 0.770432;
0.7, 0.0765638, 0.704669;
0.8, 0.0688839, 0.601355;
0.9, 0.0598219, 0.475486;
1.0, 0.0, 0.0];

Prob = A(:, 1);
Precision = A(:, 2);
Recall = A(:, 3);

plot(Precision, Recall, 'k-.'); hold on;

A =[0, 1, 1;
0.1, 0.385287, 0.920674;
0.2, 0.385287, 0.916604;
0.3, 0.368326, 0.91332;
0.4, 0.348538, 0.909277;
0.5, 0.28608, 0.88081;
0.6, 0.257466, 0.608657;
0.7, 0.257466, 0.587997;
0.8, 0.228755, 0.565466;
0.9, 0.213933, 0.506483;
1.0, 0.0, 0.0];

Prob = A(:, 1);
Precision = A(:, 2);
Recall = A(:, 3);

plot(Precision, Recall, 'k-'); hold on;

title('ROC Curve'); hold on;
xlabel('False Positive Rate'); hold on;
ylabel('True Positive Rate'); hold on;
legend('Hilbertmap TSDF Map', 'Hilbertmap Raw'); hold off;
