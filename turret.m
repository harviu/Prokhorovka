function turret(~,data,chur,t34)
global tur;
global Mot;
global Tiger;
global Angel;
global FeedbackText;
global signfordamage;
global Shell;
global Reload;
global reloadtimer;
if data.Character=='a'
Mot=Tiger.Position(1)*800+75;
    tur=-1;
end
if data.Character=='d'
Mot=Tiger.Position(1)*800+75;
    tur=1;
end

%判断射击
if strcmp(data.Key,'space')==1
    [gun,fs]=audioread('88.wma');
    gun=gun(80000:160000,:);
    if(Reload==1)
        sound(gun,fs);
        status=0;
        [ang(4),side(4)]=ifhit(Angel,Tiger.Position(1)*800+75,...
            chur.Position(1)*800,chur.Position(2)*600);
        for i=1:3
            [ang(i),side(i)]=ifhit(Angel,Tiger.Position(1)*800+75,...
                t34(i).Position(1)*800,t34(i).Position(2)*600); 
        end
        for i=1:4
            if side(i)>0
                status=status+1;
            end
        end
        %没有射中
        if status==0
            FeedbackText.String='It seems we missed.';
            FeedbackText.BackgroundColor='w';
        end
        %路线上有一个以上
        s=0;
        if status>1
            min=10000000000;
            for i=1:4
                if side(i)>0
                    if i<4
                        dx=t34(i).Position(1)*800+50-(Tiger.Position(1)*800+75);
                        dy=t34(i).Position(2)*600+50-95;
                        d=dx*dx+dy*dy;
                    end
                    if i==4
                        dx=chur.Position(1)*800+50-(Tiger.Position(1)*800+75);
                        dy=chur.Position(2)*600+50-95;
                        d=dx*dx+dy*dy;
                    end
                    if d<min
                        min=d;
                        s=i;
                    end
                end
            end
        end
        if status==1
            for i=1:4
                if side(i)>0
                    s=i;
                    break;
                end
            end
        end
        
        %判断击穿
        if status>0
            if s==4
                if ((side(s)==1&&ang(s)>80)||(side(s)==2&&ang(s)>60))&&Shell==1
                    if signfordamage(4)==1
                        FeedbackText.String='They are already terminated!';
                        FeedbackText.BackgroundColor='w';
                    else
                        FeedbackText.String='Enemy Armour Distroyed!';
                        FeedbackText.BackgroundColor='w';
                        signfordamage(4)=1;
                    end
                else
                    FeedbackText.String='That one bounced.';
                    FeedbackText.BackgroundColor='w';
                end
            else
               if ((side(s)==1&&ang(s)>45)||(side(s)==2&&ang(s)>30))&&Shell==1
                    if signfordamage(s)==1
                        FeedbackText.String='They are already terminated!';
                        FeedbackText.BackgroundColor='w';
                    else
                        FeedbackText.String='Enemy Armour Distroyed!';
                        FeedbackText.BackgroundColor='w';
                        signfordamage(s)=1;
                    end
               else
                   FeedbackText.String='That one bounced.';
                   FeedbackText.BackgroundColor='w';
               end
            end
        end
        %装填
        Reload=0;
        start(reloadtimer);
    %未装填好提示
    else
        FeedbackText.String='Loading.';
        FeedbackText.BackgroundColor='y';
    end
end
if data.Character=='1'
    Shell=1;
end
if data.Character=='2'
    Shell=2;
end

    



