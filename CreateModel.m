function model=CreateModel()
% P is process time for jobs 
p=[46 41 36 29 59 51 31 55 59 58];
%     s=randi([10 20],10,10);
% s is setup time 
s=[10	20	20	19	11	20	19	10	13	14
16	12	18	15	14	20	17	12	11	13
20	16	20	12	17	19	18	13	14	19
12	14	17	20	19	19	13	10	20	20
18	17	15	17	19	18	15	19	10	12
12	10	15	18	19	10	13	11	11	20
20	15	18	11	19	19	15	19	18	11
16	20	13	19	10	12	19	13	13	20
16	15	18	20	12	11	14	13	19	14
10	12	19	17	15	16	15	20	10	11];
% d is jobs due 
d=[1206 1305 614 753 936 343 556 1425 737 1332];
n=numel(p);
w1=1;
w2=1;
model.n=n;
model.p=p;
model.d=d;
model.s=s;
model.w1=w1;
model.w2=w2;
end