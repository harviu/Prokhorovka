

function Prokhorovka
clear;
clc;
global Mot;
global Shell;
global Angel;
global Reload;
global Tiger;
global Tpic; 
global Talpha;
global FeedbackText;
global tur;
global f;
global signfordamage;
global reloadtimer;
Tpic=cell([1 181]);
Talpha=cell([1 181]);
Mot=75;
Shell=1;
Reload=1;
Angel=90;
tur=0;
signfordamage=[0 0 0 0];

%开场音效
[fc,fs]=audioread('fc.mp3');
sound(fc,fs);

%设置所有控件
f=figure('visible','on','position',[250,100,800,600],...
    'Toolbar','none','Menubar','None','Name','Prokhorovka',...
    'NumberTitle','off','Pointer','Cross');
Tiger=axes('visible','off');
FeedbackText=uicontrol('style','text','position',[0 0 800 20],...
    'string','Loading...','fontsize',12);
backgroundpic=axes('visible','off','position',[0 10/600 1 1]);
axes(backgroundpic);
imshow(imread('Prokhorovka.jpg'));
backgroundpic.PickableParts='none';
Churchill=axes('visible','off');
T34(1)=axes('visible','off');
T34(2)=axes('visible','off');
T34(3)=axes('visible','off');
Tiger.Position=[1/2-75/800,1/30,150/800,150/600];
movetimer=timer('executionmode','fixeddelay','period',1/25,...
    'timerfcn',{@ussrmove,Churchill,T34});
uicontrol('style','text','position',[0 170 800 2],...
    'backgroundcolor','k');
reloadtimer=timer('startdelay',2,'timerfcn',@reload);
f.ButtonDownFcn=@moveandattack;
f.WindowKeyPressFcn={@turret,Churchill,T34};
f.WindowKeyReleaseFcn=@turret2;

%随机选择出生位置
while(1)
    status=0;
    r=rand(1,4);
    for i=1:4
        if(r(i)>7/8)
            status=1;
        end
        for j=i+1:4
            if abs(r(j)-r(i))<1/8
                status=1;
            end
        end
    end
    if status==0;
        break;
    end
end 
T34(1).Position=[r(1),1-200/600,49.14/800,100/600];
T34(2).Position=[r(2),1-200/600,49.14/800,100/600];
T34(3).Position=[r(3),1-200/600,49.14/800,100/600];
Churchill.Position=[r(4),1-200/600,47/800,100/600];

%调整图片
%虎式
[Tpic{1},~,Talpha{1}]=imread('Tiger.png');
filler=zeros(351,874,3);
filler2=zeros(348,874,3);
filleralpha=zeros(351,874);
filleralpha2=zeros(348,874);
Tpic{1}=[filler;Tpic{1};filler2];
Talpha{1}=[filleralpha;Talpha{1};filleralpha2];
filler=zeros(1100,226,3);
filleralpha=zeros(1100,226);
Tpic{1}=[Tpic{1},filler];
Talpha{1}=[Talpha{1},filleralpha];
Tpic{1}=imresize(Tpic{1},150/1100);
Talpha{1}=imresize(Talpha{1},150/1100);
%丘吉尔
[pic,~,alpha]=imread('Churchill.png');
axes(Churchill);
pic=imrotate(pic,90);
pic=imresize(pic,100/753);
alpha=imrotate(alpha,90);
alpha=imresize(alpha,100/753);
image(pic,'alphadata',alpha);
Churchill.Visible='off';
set(Churchill,'PickableParts','none');
%T34
[pic,~,alpha]=imread('T34.png');
pic=imrotate(pic,90);
pic=imresize(pic,100/750);
alpha=imrotate(alpha,90);
alpha=imresize(alpha,100/750);
for i=1:3
    axes(T34(i));
    image(pic,'alphadata',alpha);
    T34(i).Visible='off';
    set(T34(i),'PickableParts','none');
end
axes(Tiger);



% 缓存旋转后图片
axes(Tiger);
for i=2:181
    Tpic{i}=imrotate(Tpic{1},1-i,'bicubic','crop');
    Talpha{i}=imrotate(Talpha{1},1-i,'bicubic','crop');
end
FeedbackText.String='Done!';
imageshow(90);
start(movetimer);


function ussrmove(src,~,Churchill,T34)
global FeedbackText;
global tur;
global Angel;
global signfordamage;

%苏军移动
if signfordamage(4)==0
Churchill.Position(2)=Churchill.Position(2)-1/1200;
end
for i=1:3
    if signfordamage(i)==0
        T34(i).Position(2)=T34(i).Position(2)-1/600;
    end
end

%不规范地把键盘控制虎式也写进这个函数里
if tur~=0
    Angel=Angel+tur*3;
    if Angel>180
        Angel=180;
    end
    if Angel<0
        Angel=0;
    end    
    imageshow(Angel);
end

%判断失败
if(Churchill.Position(2)<170/600)
    FeedbackText.String='You Fail';
    FeedbackText.BackgroundColor='r';
    stop(src);
    pause(2);
    exit(0);
end
for i=1:3
    if(T34(i).Position(2)<170/600)
        FeedbackText.String='You Fail';
        FeedbackText.BackgroundColor='r';
        stop(src);
        pause(2);
        exit(0);
    end
end

%判断胜利
status=0;
for i=1:4
    if signfordamage(i)==1
        continue;
    end
    status=1;
end
if status==0
    FeedbackText.String='You Survived!';
    FeedbackText.BackgroundColor='g'; 
end

function reload(~,~)
global Reload
global FeedbackText
Reload=1;
FeedbackText.String='Reload Completed!';
 FeedbackText.BackgroundColor='g';





