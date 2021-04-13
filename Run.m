function [move] = Run(env)
%this function is responsible for runing away from the opponent and collect
%fuels on the way if possible
mypos=env.info.myPos;
op_pos = env.info.opPos;
fuel_Exist = env.fuels.fExist;
fuel_pos = env.fuels.fPos;

numberofActive_Fuel = 0;
numof_fuel_quater1 = 0;
numof_fuel_quater2 = 0;
numof_fuel_quater3 = 0;
numof_fuel_quater4 = 0;

delta_x = op_pos(1)-mypos(1);
delta_y = op_pos(2)-mypos(2);
distance = sqrt(delta_x^2+delta_y^2);
%this move run's away from the opponent
move = [-delta_x*10 -delta_y*10];
%avoid the walls
if(mypos(1) > 9.8 || mypos(1) < 0.2 || mypos(2) > 9.8 || mypos(2) < 0.2) %%walls
    x = mypos(1)-op_pos(1);
    y = mypos(2)-op_pos(2);
    [theta,rho] = cart2pol(x,y);
    theta = theta*180/pi;
    
    if(theta>0)
    theta = theta +90;
    end
    if(theta<0)
    theta = theta -90;
    end
   [x,y] = pol2cart(theta*(pi/180),rho);
   move = [x*10 y*10];
   return;

end
%check the current fuel's status
for i = 1:length(fuel_Exist) %run twoards fuels
    if(fuel_Exist(i)==1)
        numberofActive_Fuel = numberofActive_Fuel +1;
    end
        if((fuel_pos(i,1) > 5)&&(fuel_pos(i,2) > 5)&&fuel_Exist(i)==1) %quater1
            numof_fuel_quater1 = numof_fuel_quater1 +1;
        end
        if((fuel_pos(i,1) < 5)&&(fuel_pos(i,2) > 5)&&fuel_Exist(i)==1) %quater2
            numof_fuel_quater2 = numof_fuel_quater2 +1;
        end
        if((fuel_pos(i,1) < 5)&&(fuel_pos(i,2) < 5)&&fuel_Exist(i)==1) %quater3
            numof_fuel_quater3 = numof_fuel_quater3 +1;
        end
        if((fuel_pos(i,1) > 5)&&(fuel_pos(i,2) < 5)&&fuel_Exist(i)==1) %quater4
            numof_fuel_quater4 = numof_fuel_quater4 +1;
        end
end
%make a diction rether to run away or to run twoards a fuel
if numberofActive_Fuel ~= 0
    maxvector = [numof_fuel_quater1,numof_fuel_quater2,numof_fuel_quater3,numof_fuel_quater4];
    Max_val = max(maxvector);
    if((distance > 0.685)) %its worth the try.. ((myfuel + (Max_val+2)*30) > opfuel)&& 0.685
        move = FuelCollect(env,1); 
        return;
    end
    for i = 1:length(fuel_pos)
        if (fuel_Exist(i)==1)&&( sqrt( (mypos(1)-fuel_pos(i,1))^2+(mypos(2)-fuel_pos(i,2))^2 )<0.75)
            move = [(fuel_pos(i,1)-mypos(1))*10 (fuel_pos(i,2)-mypos(2))*10];
        end
    end
end


end