function [z sol]=MyCost(s,model)

[~, q]=sort(s);

n=model.n;
p=model.p;
d=model.d;
s=model.s;

ST=zeros(1,n);
FT=zeros(1,n);

ST(q(1))=0;
FT(q(1))=ST(q(1))+p(q(1));

for i=2:n
job=q(i);
previous_job=q(i-1);

ST(job)=FT(previous_job)+s(previous_job,job);
FT(job)=ST(job)+p(job);
end

Cmax=max(FT);

Tard=max(FT-d,0);

TotalTard=sum(Tard);

w1=model.w1;
w2=model.w2;

z=w1*Cmax+w2*TotalTard;

sol.q=q;
sol.ST=ST;
sol.FT=FT;
sol.Tard=Tard;
sol.TotalTard=TotalTard;
sol.Cmax=Cmax;
sol.z=z;

end