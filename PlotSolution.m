function PlotSolution(sol,model)

n=model.n;

ST=sol.ST;
FT=sol.FT;
Cmax=sol.Cmax;

Colors=hsv(n*2);

h=1;

for i=1:n
X=[ST(i) FT(i) FT(i) ST(i)];
Y=[0     0     h     h    ];
fill(X,Y,Colors(i+1,:));
hold on;
xm=(ST(i)+FT(i))/2;
ym=h/2;
text(xm,ym,num2str(i),'HorizontalAlignment','center','FontWeight','bold');
end

plot([Cmax Cmax],[0 2*h],'k-','LineWidth',2);

title(['C{max} = ' num2str(Cmax)]);
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','[0.6 0.8 0.6]')
hold off
ylim([0 2*h]);

end