$ontext
CEE 6410 - Water Resources Systems Analysis
Homework 3. Vehicle Shipment Problem in GAMS


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


Problem


	Monthly Water Requirement (acft/acre)	
	June	July	August	Return, $/acre
Hay	2	1	1	100
Grain	1	2	0	120




Data are as fol-lows:

Supplier            Shipment cost                                              Resource Availability   
                     Minneapolis    New York      San Francisco     Seattle     Resource Availability
Kansas City          4              12            18                18          1000
Dallas               9              15            17                21          800

Demand
Minneapolis         400
New York            250
San Francisco       450
Seattle             450



THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Talha Quddoos
talha.quddoos@usu.edu
September 28, 2026
$offtext

* 1. DEFINE the SETS
* Setting up sets for supply nodes and demand nodes
SETS
    i suppliers /KansasCity, Dallas/
    j dealerships /Minneapolis,NewYork,SanFrancisco,Seattle/;
    


* 2. * Setting up parameters for available resources at supplier and the demand/sale at the dealerships

PARAMETERS
    supply(i) vehicles in supplier inventory/KansasCity 1000, Dallas 800/
    demand(j) vehicle sales or demand at dealerships  /Minneapolis 400,NewYork 250,SanFrancisco 450,Seattle 450 /;


* Cost matrix from supply to demand
    table costToShip(i,j)
                Minneapolis NewYork SanFrancisco Seattle
    KansasCity  4           12      18           18
    Dallas      9           15      17           21;
    


* 3. DEFINE the variables
VARIABLES
    x(i,j) vehicles to ship from a factory i to dealership j (Number)
    z  shipment cost;
* Non-negativity constraints
POSITIVE VARIABLES x;

* 4. COMBINE variables and data in equations
EQUATIONS
    objective equation representing objective function
    supplyConstraint(i) equation representing supply constraint
    demandConstraint(j) equation representing demand constraint;
    
objective.. sum((i,j),costToShip(i,j)*x(i,j)) =e=z;
supplyConstraint(i).. sum(j, x(i,j))=L=supply(i);
demandConstraint(j).. sum(i, x(i,j))=E=demand(j);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL Shipment /all/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the Manufacturing model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE Shipment USING LP Minimize z;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
