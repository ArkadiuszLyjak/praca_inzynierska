function figDisplay(fig1, fig2, fig3, fig4, fig5, fig6, fig7)
% function figDisplay(fig7)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ustawienie okienek na ekranie w ustalonym porzadku oraz wielkosci %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(0,'Units','pixels') 
%% 
get(0,'ScreenSize');
scnsize = get(0,'ScreenSize');

position = get(fig7,'Position');
outerpos = get(fig7,'OuterPosition');
borders = outerpos - position;
edge = -borders(1)/2;
task_bar_down_px = 40; % Wysokosc paska zadan

% % [left bottom width height]
% % [0      0    1440   900]

pos1 = [edge, ...                         % granica skraj od lewej
        task_bar_down_px, ...             % od dolu na wykosc paska zadan          
        scnsize(3)/2 - edge, ...          % szerokosc na polowe ekranu
        scnsize(4) - scnsize(4) * 0.045]; % wysokosc na caly ekran - edge

pos2 =  [scnsize(3)/2, ...
         scnsize(4)/2 + task_bar_down_px/2,  ...  
         scnsize(3)/2, ...  
         scnsize(4)/2 - task_bar_down_px/2];

pos3 = [scnsize(3)/2, ...       % zaczyna sie od polowy ekranu do prawej
        task_bar_down_px, ...   % cala wysokosc
        scnsize(3)/2, ...      
        scnsize(4)/2 - (task_bar_down_px/2)];

pos4 = [scnsize(3)/3, ...
        task_bar_down_px, ...
        pos1(3), ...
        pos1(4)];

pos5 = [scnsize(3)/4, ...
        scnsize(4)/5, ...    
        scnsize(3)/2.5, ...      
        scnsize(4)/1.5];

% pos6 = [scnsize(3) - scnsize(3)/3, ...
%         task_bar_down_px, ...    
%         scnsize(3)/1.75, ...      
%         scnsize(3)/2];
    
pos7 = [scnsize(3) - scnsize(3)/1.25, ...
        task_bar_down_px + 10, ...    
        scnsize(3)/1.25, ...      
        scnsize(3)/1.75];
    
pos8 = [edge, ...
        task_bar_down_px, ...    
        (scnsize(3)) - edge, ...            % max szer.
        scnsize(4) - scnsize(4) * 0.045];   % max wys.

set(fig1, 'OuterPosition', pos1);
set(fig2, 'OuterPosition', pos2);
set(fig3, 'OuterPosition', pos3);
set(fig4, 'OuterPosition', pos4);
set(fig5, 'OuterPosition', pos5);
set(fig6, 'OuterPosition', pos7);
set(fig7, 'OuterPosition', pos8);