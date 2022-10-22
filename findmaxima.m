% jmin=0;
% jmax=0;
% for j=2:length(fVal)-1
%     if (fVal(j)>fVal(j-1))&&(fVal(j)>fVal(j+1))
%         jmax=jmax+1;
%         max_index(jmax)=j;
%         max_value(jmax)=fVal(j);
%     end;
%     if (fVal(j)<fVal(j-1))&&(fVal(j)<fVal(j+1))
%         jmin=jmin+1;
%         min_index(jmin)=j;
%         min_value(jmin)=fVal(j);
%     end;
% end;
axis tight
grid on

iks1 = linspace(-1,1,length(max_value));
plot(iks1, max_value)

iks2 = linspace(-1,1,length(min_value));
plot(iks2, min_value)
