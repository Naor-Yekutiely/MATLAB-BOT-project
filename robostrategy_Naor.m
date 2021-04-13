function [move,mem] = robostrategy_Naor(env,mem)
%this function ivocates the correct function according to the current state
key = Make_Decision(env);

if(key == "Chase")
    move = Chase(env);
end

if(key == "Run")
    move = Run(env);
end

if(key == "FuelCollect")
    move = FuelCollect(env,0);
end

if(key == "NoFuel")
     move = NoFuel(env);
end

end