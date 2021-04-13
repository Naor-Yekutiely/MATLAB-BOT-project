function [Decision] = Make_Decision(env)
%this function is responsible for Making a Decision - Chase,Run,fuels
%collect,no more fuels according to the current state
fuel_Exist = env.fuels.fExist;
mypos=env.info.myPos;
op_pos = env.info.opPos;
myfuel = env.info.fuel;
opfuel = env.info.fuel_op;


fuel_indicator = 0;
not_fuel_collect_indecator = 0;

for i = 1:length(fuel_Exist) 
    if fuel_Exist(i) ~= 0
        fuel_indicator = 1;
    end
end

delta_x = op_pos(1)-mypos(1);
delta_y = op_pos(2)-mypos(2);
delta = sqrt(delta_x^2 + delta_y^2);

if (delta < 2)&&(myfuel > opfuel + 10) %Chase
    Decision = "Chase";
    not_fuel_collect_indecator = 1;
end

if (delta < 2.5)&&(myfuel < opfuel) %Run
    Decision = "Run";
    not_fuel_collect_indecator = 1;
end

if fuel_indicator ~= 1 %no more fuels
    Decision = "NoFuel";
    not_fuel_collect_indecator = 1;
end

if not_fuel_collect_indecator ~= 1 %fuel collect
   Decision = "FuelCollect";
end


end