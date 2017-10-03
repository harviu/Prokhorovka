function [hitang,hitpos]=ifhit(ang,x,tarx,tary)
dis=tary-95;
rad=ang*pi/180;
deltax=dis/tan(rad);
if x-deltax>tarx&&x-deltax<tarx+50
    hitpos=1;
    if ang<90
        hitang=ang;
    else
        hitang=180-ang;
    end
end
if x-deltax<tarx
deltaxside=tarx-x;
disside=deltaxside*tan(rad);
    if 95-disside<tary+100&&95-disside>tary
        hitpos=2;
        hitang=ang-90;
    else
        hitpos=0;
        hitang=0;
    end
end
if x-deltax>tarx+50
deltaxside=tarx+50-x;
disside=deltaxside*tan(rad);
    if 95-disside<tary+100&&95-disside>tary
        hitpos=2;
        hitang=90-ang;
    else
        hitpos=0;
        hitang=0;
    end
end




