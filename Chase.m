function [move] = Chase(env)
%this function is responsible for chasing the opponent
mypos=env.info.myPos;
op_pos = env.info.opPos;

delta_x = op_pos(1)-mypos(1);
delta_y = op_pos(2)-mypos(2);

move = [delta_x*10 delta_y*10]; %go after the opponent
move = dodge(env,op_pos,move); %check for mines
end