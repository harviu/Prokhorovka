function imageshow(deg)
global Tpic;
global Talpha;
global Tiger;
if deg>180
    deg=180;
end
if deg<0
    deg=0;
end
image(Tpic{deg+1},'alphadata',Talpha{deg+1});
set(Tiger,'visible','off','color','none');

