function [move,mem] = robostrategy_Other(env,mem)
%Strategy for robot tournament game.
%
%Environment Struct
% field:
% info,  STRUCT{team, fuel, fuel_op,myPos, opPos,turn}
% basic, STRUCT{walls, rRbt, rMF, lmax}
% mines, STRUCT{nMine, mPos, mineScr, mineExist}
% fuels, STRUCT{nFuel, fPos, fuelScr, fuelExist}
%
%Memory Struct
% field:
% path, STRUCT{start, dest, pathpt, nPt, proc, lv}

factor = 10;

mypos=env.info.myPos;
enpos=env.info.opPos;
myFuel=env.info.fuel;
enFuel=env.info.fuel_op;
fuelPos=env.fuels.fPos;
lmax=env.basic.lmax;
disBetweenOp = sqrt((mypos(1) - enpos(1)).^2 +(mypos(2) - enpos(2)).^2); %distant from enemy

if (isempty(find(env.fuels.fExist,1))) %if there are no more fuel on the board, don't move!
    move = [0,0];
    return;
end

if (myFuel - (disBetweenOp^2 + 2) - factor) > enFuel %attack!!  
    neededDelta = enpos - mypos;
    normDelta = (neededDelta/sqrt(neededDelta(1).^2 + neededDelta(2).^2)).*lmax;
    newPos = mypos + normDelta;
    
    flag=1;
    while flag == 1
        flag = 0;
        for j=1:env.mines.nMine
            tmpDeltaFromMine = sqrt((newPos(1)- env.mines.mPos(j,1)).^2 + (newPos(2)- env.mines.mPos(j,2)).^2);
            if (tmpDeltaFromMine < 0.495 && env.mines.mExist(j)==1)%
                theta = 20;
                th = atan(normDelta(2)/normDelta(1));
                [normDelta(1),normDelta(2)] = pol2cart(theta+th,2.2*lmax);
                newPos = mypos + normDelta;
                flag = 1;
                break;
            end
        end
    end
    move = normDelta;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else %if has lower amout of fuel, go get more
    nearestFuelIdx = find(env.fuels.fExist==1,1);
    for i=nearestFuelIdx:env.fuels.nFuel
        if ((sqrt((mypos(1) - fuelPos(i,1)).^2 +(mypos(2) - fuelPos(i,2)).^2)) < (sqrt((mypos(1) - fuelPos(nearestFuelIdx,1)).^2 +(mypos(2) - fuelPos(nearestFuelIdx,2)).^2))) && (env.fuels.fExist(i) == 1)
            nearestFuelIdx = i;
        end
    end
    nearestFuelPos=[fuelPos(nearestFuelIdx,1),fuelPos(nearestFuelIdx,2)]; %(x,y) of nearest
    
    neededDelta = nearestFuelPos - mypos;
    normDelta = (neededDelta/sqrt(neededDelta(1).^2 + neededDelta(2).^2)).*lmax;
    newPos = mypos + normDelta;
      
    flag=1;
    while flag == 1
        flag = 0;
        tmpDeltaFromEnemy = sqrt((newPos(1)- enpos(1)).^2 + (newPos(2)- enpos(2)).^2);
        for j=1:env.mines.nMine
            tmpDeltaFromMine = sqrt((newPos(1)- env.mines.mPos(j,1)).^2 + (newPos(2)- env.mines.mPos(j,2)).^2);
            if ((tmpDeltaFromMine < 0.495 && env.mines.mExist(j)==1)|| (tmpDeltaFromEnemy < disBetweenOp && disBetweenOp < 1.4))%
                theta = 20;
                th = atan(normDelta(2)/normDelta(1));
                [normDelta(1),normDelta(2)] = pol2cart(theta+th,2.2*lmax);
                newPos = mypos + normDelta;
                flag = 1;
                break;
            end
        end
    end
    move = normDelta;
end
end