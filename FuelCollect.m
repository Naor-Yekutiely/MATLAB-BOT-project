function [move] = FuelCollect(env,indicator)
%this function is responsible for collecting fuel
fuel_pos = env.fuels.fPos;
fuel_Exist = env.fuels.fExist;
mypos=env.info.myPos;
oppos = env.info.opPos;

Quarter1 = zeros(16,2);
counter1 = 1;
Quarter2 = zeros(16,2);
counter2 = 1;
Quarter3 = zeros(16,2);
counter3 = 1;
Quarter4 = zeros(16,2);
counter4 = 1;

for i  = 1:env.fuels.nFuel %%separate the fuels to Quarters Groups
 if((fuel_pos(i,1)<=5&&fuel_pos(i,2)<=5)&&fuel_Exist(i)==1)
     if(indicator == 0)
         Quarter1(counter1,:) = fuel_pos(i,:);
         counter1 = counter1+1;
     end
     if(indicator == 1)
         delta_x1 = abs(mypos(1)-fuel_pos(i,1));
         delta_y1 = abs(mypos(2)-fuel_pos(i,2));
         delta_x2 = abs(oppos(1)-fuel_pos(i,1));
         delta_y2 = abs(oppos(2)-fuel_pos(i,2));
         tmp_close1 = sqrt(delta_x1^2 + delta_y1^2);
         tmp_close2 = sqrt(delta_x2^2 + delta_y2^2);
         if(tmp_close1<tmp_close2)
             Quarter1(counter1,:) = fuel_pos(i,:);
             counter1 = counter1+1;
         end
     end
 end
 
  if((fuel_pos(i,1)<5&&fuel_pos(i,2)>5)&&fuel_Exist(i)==1)
      if(indicator == 0)
         Quarter2(counter2,:) = fuel_pos(i,:);
         counter2 = counter2+1;
      end
      if(indicator == 1)
         delta_x1 = abs(mypos(1)-fuel_pos(i,1));
         delta_y1 = abs(mypos(2)-fuel_pos(i,2));
         delta_x2 = abs(oppos(1)-fuel_pos(i,1));
         delta_y2 = abs(oppos(2)-fuel_pos(i,2));
         tmp_close1 = sqrt(delta_x1^2 + delta_y1^2);
         tmp_close2 = sqrt(delta_x2^2 + delta_y2^2);
         if(tmp_close1<tmp_close2)
             Quarter2(counter2,:) = fuel_pos(i,:);
             counter2 = counter2+1;
         end
     end
  end
  
  if((fuel_pos(i,1)>=5&&fuel_pos(i,2)>=5)&&fuel_Exist(i)==1)
      if(indicator == 0)
         Quarter3(counter3,:) = fuel_pos(i,:);
         counter3 = counter3+1;
      end
      if(indicator == 1)
         delta_x1 = abs(mypos(1)-fuel_pos(i,1));
         delta_y1 = abs(mypos(2)-fuel_pos(i,2));
         delta_x2 = abs(oppos(1)-fuel_pos(i,1));
         delta_y2 = abs(oppos(2)-fuel_pos(i,2));
         tmp_close1 = sqrt(delta_x1^2 + delta_y1^2);
         tmp_close2 = sqrt(delta_x2^2 + delta_y2^2);
         if(tmp_close1<tmp_close2)
             Quarter3(counter3,:) = fuel_pos(i,:);
             counter3 = counter3+1;
         end
     end
  end
  
  if((fuel_pos(i,1)>5&&fuel_pos(i,2)<5)&&fuel_Exist(i)==1)
      if(indicator == 0)
         Quarter4(counter4,:) = fuel_pos(i,:);
         counter4 = counter4+1;
      end
      if(indicator == 1)
         delta_x1 = abs(mypos(1)-fuel_pos(i,1));
         delta_y1 = abs(mypos(2)-fuel_pos(i,2));
         delta_x2 = abs(oppos(1)-fuel_pos(i,1));
         delta_y2 = abs(oppos(2)-fuel_pos(i,2));
         tmp_close1 = sqrt(delta_x1^2 + delta_y1^2);
         tmp_close2 = sqrt(delta_x2^2 + delta_y2^2);
         if(tmp_close1<tmp_close2)
             Quarter4(counter4,:) = fuel_pos(i,:);
             counter4 = counter4+1;
         end
     end
  end
end

 closest1 = sqrt(200);
 closest2 = sqrt(200);
 closest3 = sqrt(200);
 closest4 = sqrt(200);
 closest1_Point = [0 0];
 closest2_Point = [0 0];
 closest3_Point = [0 0];
 closest4_Point = [0 0];
 
 
for i  = 1:counter1-1 %%find the closest fuel in Quarter1
    if(Quarter1(i,1) == 0 && Quarter1(i,2) == 0)
        break; 
    end
    delta_x = abs(mypos(1)-Quarter1(i,1));
    delta_y = abs(mypos(2)-Quarter1(i,2));
    tmp_close = sqrt(delta_x^2 + delta_y^2);
    if(tmp_close < closest1)
        closest1 = tmp_close;
        closest1_Point(1) = Quarter1(i,1);
        closest1_Point(2) = Quarter1(i,2);
    end
end

for i  = 1:counter2-1 %%find the closest fuel in Quarter2
    if(Quarter2(i,1) == 0 && Quarter2(i,2) == 0)
        break;
    end
    delta_x = abs(mypos(1)-Quarter2(i,1));
    delta_y = abs(mypos(2)-Quarter2(i,2));
    tmp_close = sqrt(delta_x^2 + delta_y^2);
    if(tmp_close < closest2)
        closest2 = tmp_close;
        closest2_Point(1) = Quarter2(i,1);
        closest2_Point(2) = Quarter2(i,2);
    end
end
for i  = 1:counter3-1 %%find the closest fuel in Quarter3
    if(Quarter3(i,1) == 0 && Quarter3(i,2) == 0)
        break;
    end
    delta_x = abs(mypos(1)-Quarter3(i,1));
    delta_y = abs(mypos(2)-Quarter3(i,2));
    tmp_close = sqrt(delta_x^2 + delta_y^2);
    if(tmp_close < closest3)
        closest3 = tmp_close;
        closest3_Point(1) = Quarter3(i,1);
        closest3_Point(2) = Quarter3(i,2);
    end
end

for i  = 1:counter4-1 %%find the closest fuel in Quarter4
    if(Quarter4(i,1) == 0 && Quarter4(i,2) == 0)
        break;
    end
    delta_x = abs(mypos(1)-Quarter4(i,1));
    delta_y = abs(mypos(2)-Quarter4(i,2));
    tmp_close = sqrt(delta_x^2 + delta_y^2);
    if(tmp_close < closest4)
        closest4 = tmp_close;
        closest4_Point(1) = Quarter4(i,1);
        closest4_Point(2) = Quarter4(i,2);
    end
end
 
number_of_fuels = counter1 + counter2 + counter3 + counter4 -4;

factor1 = (number_of_fuels/counter1-1)*(closest1);
factor2 = (number_of_fuels/counter2-1)*(closest2);
factor3 = (number_of_fuels/counter3-1)*(closest3);
factor4 = (number_of_fuels/counter4-1)*(closest4);
%make a move
tmporary_min = [factor1,factor2,factor3,factor4];
result = min(tmporary_min);
if factor1 == result
    delta_x =  closest1_Point(1) -mypos(1);
    delta_y =  closest1_Point(2)-mypos(2);
    move = [delta_x*10 delta_y*10];
     move = dodge(env,closest1_Point,move);
end
if factor2 == result
    delta_x =  closest2_Point(1)- mypos(1);
    delta_y = closest2_Point(2)-mypos(2);
    move = [delta_x*10 delta_y*10];
    move = dodge(env,closest2_Point,move);
end
if factor3 == result
    delta_x =  closest3_Point(1)-mypos(1);
    delta_y = closest3_Point(2)-mypos(2);
    move = [delta_x*10 delta_y*10];
    move = dodge(env,closest3_Point,move);
end
if factor4 == result
    delta_x =  closest4_Point(1)-mypos(1);
    delta_y =  closest4_Point(2)-mypos(2);
    move = [delta_x*10 delta_y*10];
    move = dodge(env,closest4_Point,move);
end

end