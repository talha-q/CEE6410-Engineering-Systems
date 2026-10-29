$ontext
CEE 6410 - Water Resources Systems Analysis
Homework Prompt F. Dual Problem in GAMS


THE PROBLEM:
Dual formulation of problem from HW2

Irrigation Problem (from Chapter 2, Problem #3 in Bishop et. al (1999))
An aqueduct constructed to supply water to industrial users has an excess capacity in the months of June,
July, and August of 14,000 acft, 18,000 acft, and 6,000 acft, respectively.
It is proposed to develop not more than 10,000 acres of new land by utilizing the excess aqueduct capacity for irrigation water deliveries.
Two crops, hay and grain, are to be grown.  Their monthly water requirements and expected net returns are given in the fol-lowing table:


	   Monthly Water Requirement (acft/acre)	
	       June	 July	August	Return, $/acre
Hay	       2	 1	    1	    100
Grain	   1	 2	    0	    120


It is a profit maximization problem in which we are to maximize profits. 



To Submit
1) Primal and Dual model formulations--include: dimensions, decision variables,
    objective function, constraints, and all parameters and variables defined with units of measurements
2) Primal and Dual model solutions [objective function, decision variable, shadow value, and reduced cost values]
3) Compare and interpret solutions, and share new insights for management


THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Talha Quddoos
talha.quddoos@usu.edu
October 02, 2026
$offtext

* 1. DEFINE the SETS
* Setting up sets for supply nodes and demand nodes

SETS
    crop crops /hay, grain/
    resource resources /waterjune,waterjuly,wateraug,land/;
    


* 2. * Setting up parameters for available resources at supplier and the demand/sale at the dealerships

PARAMETERS

   c(crop) Objective function coefficients ($ return per acre)
         /hay 100, grain 120/
         
   b(resource) resource availability
          /waterjune 14000,waterjuly 18000,wateraug 6000,land 10000/;
          



TABLE A(crop,resource) Left hand side constraint coefficients
            waterjune   waterjuly  wateraug land     
 hay        2           1          1        1        
 grain      1           2          0        1;     

    

* 3. DEFINE the variables
VARIABLES
    x(crop) acre of crop planted
    VPROFIT total profit ($)
    y(resource) value of the resource used
    VREDCOST total reduced cost ($);
    
* Non-negativity constraints
POSITIVE VARIABLES x,y;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT_PRIMAL Total profit ($) and objective function value
   RES_CONS_PRIMAL(resource) Resource constraints
   REDCOST_DUAL Reduced Cost ($) associated with using resources
   RES_CONS_DUAL(crop) Profit levels ;





*Primal Equations
PROFIT_PRIMAL..                 VPROFIT =E= SUM(crop,c(crop)*x(crop));
RES_CONS_PRIMAL(resource) ..    SUM(crop,A(crop,resource)*x(crop)) =L= b(resource);

*Dual Equations
REDCOST_DUAL..                 VREDCOST =E= SUM(resource,b(resource)*Y(resource));
RES_CONS_DUAL(crop)..          sum(resource,A(crop,resource)*y(resource)) =G= c(crop);


* 5. DEFINE the MODEL from the EQUATIONS
*Primal Model
MODEL PLANT_PRIMAL /PROFIT_PRIMAL, RES_CONS_PRIMAL/;
*Dual Model
MODEL PLANT_DUAL / REDCOST_DUAL, RES_CONS_DUAL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANT_PRIMAL USING LP MAXIMIZING VPROFIT;
SOLVE PLANT_DUAL USING LP MINIMIZING VREDCOST;



* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
