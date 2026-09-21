$ontext
CEE 6410 - Water Resources Systems Analysis
Homework Prompt E. Submit GAMS on Github
Modify the .gms file for corresponding Transportation problem

THE PROBLEM:
How many coups and minivans should a car manufacturer produce in a year?
types of cars:  Coup and Minivan.

Data are as fol-lows:
Resource Input  Vehicle Type    Resource Availability
   
                     Coup           Minivan            Resource Availability
Metal                1,000 lbs      2,000 lbs          4,000,000 lbs
Circuit boards       4 boards       3 boards           12,000 boards
Labor                5 days         2.5 days           17,500 days
Profit per vehicle   $6,000         $7,000

Inputs or Profit        Crops        Resource Availability


THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Talha Quddoos
talha.quddoos@usu.edu
September 21, 2026
$offtext

* 1. DEFINE the SETS
* Sets for decision variables and constrainsts
SETS veh types of cars /Coup, Minivan/
     res resources available /Metal, Circuit, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(veh) Objective function coefficients ($ per vehicle)
         /Coup 6000,
        Minivan 7000 /

   b(res) Right hand constraint values (per resource)
          /Metal 4000000,
           Circuit  12000,
           Labor  17500/;

TABLE A(veh,res) Left hand side constraint coefficients
                 Metal   Circuit   Labor
 Coup           1000      4        5
 Minivan        2000      3       2.5;


* 3. DEFINE the variables
VARIABLES X(veh) vehicles manufactured (Number)
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints;

PROFIT..                 VPROFIT =E= SUM(veh, c(veh)*X(veh));
RES_CONSTRAIN(res) ..    SUM(veh, A(veh,res)*X(veh)) =L= b(res);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL MANUFACTURING /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the Manufacturing model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE MANUFACTURING USING LP MAXIMIZING VPROFIT;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
