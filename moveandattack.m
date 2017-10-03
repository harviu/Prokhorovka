function moveandattack(src,~)
global Mot;
global Angel;
global Tiger;
pos=src.CurrentPoint;
if pos(2)<170&&abs(pos(1)-(Tiger.Position(1)*800+75))>25 %Move
    Mot=pos(1);
    while(1)
        if abs(Mot-Tiger.Position(1)*800-75)<3
            break;
        end
        if Mot>Tiger.Position(1)*800+75+3
            if Angel<180
                Angel=Angel+3;
                imageshow(Angel);
            else
                Tiger.Position(1)=Tiger.Position(1)+1/800;
            end
        end
        if Mot<Tiger.Position(1)*800+75-3
            if Angel>0
                Angel=Angel-3;
                imageshow(Angel);
            else
                Tiger.Position(1)=Tiger.Position(1)-1/800;
            end
        end 
        pause(1/100);
    end
end
% if pos(2)>=170
%     Mot=Tiger.Position(1)*800+75;
%     tar=src.CurrentPoint;
%     pos=[Tiger.Position(1)*800+75 95];
%     ang=atan((tar(2)-pos(2))/(tar(1)-pos(1)))*180/pi;
%     if(ang>0)
%         ang=180-ang;
%     else
%         ang=-ang;
%     end
%     while(1)
%         if Angel>ang+3
%             Angel=Angel-3;
%             imageshow(Angel);
%         end
%         if Angel<ang-3
%             Angel=Angel+3;
%             imageshow(Angel);
%         end
%         if abs(Angel-ang)<3
%             break;
%         end
%         pause(1/100);
%     end
% end
    
        
    
        
            
