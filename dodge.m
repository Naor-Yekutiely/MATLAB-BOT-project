function [move_dodge] = dodge(env,target_point,curr_move)
%this function is responsible for dodging abstacles and changing the
%current move is neccsery
move_dodge = curr_move;
mine_pos = env.mines.mPos;
numberof_Mine = env.mines.nMine;
numberofActive_Mine = 0;
Mine_Exist = env.mines.mExist;
mypos=env.info.myPos;

if(abs((abs(mypos(1))-10))< 0.5 || abs((abs(mypos(2))-10))< 0.5)
    return;
end
x = target_point(1)-mypos(1);
y = target_point(2)-mypos(2);
[theta,rho] = cart2pol(x,y);
theta = theta*180/pi;
%find all the mine's that migth Interapt in the way
MineThat_migthInterapt = zeros(numberofActive_Mine,2);
Mine_cordineties = zeros(numberofActive_Mine,2);
j = 1;
for i = 1:numberof_Mine
    if(Mine_Exist(i) == 1)
        x_tmp = mine_pos(i,1)-mypos(1);
        y_tmp = mine_pos(i,2)-mypos(2);
        [theta_tmp,rho_tmp] = cart2pol(x_tmp,y_tmp);
        theta_tmp = theta_tmp*180/pi;
        if((~(abs(theta_tmp-theta)>90))&&rho_tmp<rho)
        MineThat_migthInterapt(j,1) = theta_tmp;
        MineThat_migthInterapt(j,2) = rho_tmp;
        Mine_cordineties(j,1) = mine_pos(i,1);
        Mine_cordineties(j,2) = mine_pos(i,2);
        j = j+1;
        end
    end
end

[rows columns] = size(MineThat_migthInterapt);
index = 0;
triangle_higth_min = 10;
%find the index of the mine that Interapt's using imagenary triangles
if(rows>0)
for i = 1:rows
   triangle_area = abs(mypos(1)*(target_point(2)-Mine_cordineties(i,2))+target_point(1)*(Mine_cordineties(i,2)-mypos(2))+Mine_cordineties(i,1)*(mypos(2)-target_point(2)))/2;
   triangle_higth_tmp = (2*triangle_area)/rho;
       if((triangle_higth_tmp<triangle_higth_min)&& triangle_higth_tmp<0.5)
           triangle_higth_min = triangle_higth_tmp;
           index = i;
      end
end
end
%make a move
if(index~=0)
    distance = MineThat_migthInterapt(index,2);
   if(MineThat_migthInterapt(index,1)>theta)
        if distance<0.3 %very close
            theta = theta - 110;
        end
        if distance<0.5&&distance>0.3 %close
            theta = theta - 70;
        end
        
        if distance<0.8&&distance>0.5 %not so close
            theta = theta - 58;
        end
         [x,y] = pol2cart(theta*(pi/180),rho);
         move_dodge = [x*10 y*10];
    end
   
    if(MineThat_migthInterapt(index,1)<theta)
        if distance<0.3 %very close
            theta = theta - 110; 
        end
       if distance<0.5&&distance>0.3 %close
            theta = theta - 70;
       end
        if distance<0.8&&distance>0.5 %not so close
            theta = theta + 58;
        end
         [x,y] = pol2cart(theta*(pi/180),rho);
         move_dodge = [x*10 y*10];
    end

end

end
