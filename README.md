# MATLAB-BOT-project
Implementing a Bot game algorithm. The main function of the project receives two different BOT algorithms and uses them to make a dual battle between the BOTs.

## How the robot competition works:
In the robot competition, two robots compete head to head on a virtual map containing fuel tanks
And bombs(mines).The game ends when the two robots reach a range of five units from each other:
at this point the robot that has more fuel will be declared as the winner.
- At each step of the game, the robot must decide which direction to move and which distance.
- In each turn, the robot loses fuel as a function of the distance it moves.
- If the robot has reached a fuel tank, the amount of fuel in the robot increases according to the amount of fuel in the tank.
- If the robot has reached a bomb(mine), the amount of fuel of the robot decreases.

### Battle between two robots:
![Screenshot 2021-04-13 185041](https://user-images.githubusercontent.com/82441934/114582399-3941d380-9c89-11eb-99d0-8d1a8ebe2b1c.png)
<br/>Figure 1. Battle between two robots (filled circles), the dotted lines show the robots' path when they avoid bombs
(Asterisks) and looking for fuel tanks (circles with the amount of fuel in them).

The robot (robostrategy function) has full access to all the information about the game mode; that is, the robot knows:
- The location and size of each bomb(mine) and fuel tank
- Fuel condition of each fuel tank(if it still exsist or not)
- The opponent's current position and the opponent's current fuel condition
- Its own current fuel level

Each function (robot) is called in turn's and it must return a 2x1 vector that describes the movement that the robot wants to perform Next: 
that is, the vector contains the values ​​of Δ𝑥 and Δ𝑦. The robot uses fuel for its movement:
the cost of fuel per step depends on the step size - Δ𝑥<sup>2</sup> + Δ𝑦<sup>2</sup> + 2

## Constraints:
The function (robot) is not allowed to maintain the previous state of the game. That is, all decisions about the direction and size of the movement are based on
current game status.

### Algorithm flowchart:
![Flowchart](https://user-images.githubusercontent.com/82441934/114581774-ac971580-9c88-11eb-9d54-d0c3208a6261.png)
<br/>Figure 2. robostrategy_Naor Algorithm's flowchart - the flowchart shows the decision making process for a single move(step). There for, the process repeat's 
itself until the battle is over.