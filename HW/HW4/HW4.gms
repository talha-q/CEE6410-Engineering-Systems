$ontext
****************************
CEE 6410 - Water Resources Systems Analysis
HW 4 – More Complicated Linear Programs
Reservoir Operation Problem
****************************

THE PROBLEM:
A reservoir is designed to provide hydropower and water for irrigation.
The turbine releases may also be used for irrigation as shown in Figure 1.
At least one unit of water must be kept in the river each month at point A.
The hydropower turbines have a capacity of 4 units of water per month (flows are constant during any single month), and any other releases must bypass the tur¬bines.
The size of farmed area is very large relative to the amount of irrigation water available, so there is no upper limit on usable irrigation water.
The reservoir has a capacity of 9 units, and initial storage is 5 units of water. The ending storage must be equal to or greater than the begin¬ning storage.
The benefits per unit of water, and the estimated average inflows to the reservoir are given in Table 1.

Table 1
Month   Inflow Units    Hydropower Benefits ($/unit)    Irrigation Benefits ($/unit)
1       2               1.6                             1.0
2       2               1.7                             1.2
3       3               1.8                             1.9
4       4               1.9                             2.0
5       3               2.0                             2.2
6       2               2.0                             2.2


A.  Develop and solve an LP model for maximizing the economic benefits of reservoir opera¬tion.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Talha Quddoos
talha.quddoos@usu.edu
October 05, 2026
$offtext

* 1. DEFINE the SETS
* Defining a set for time
SETS
    t months /1, 2,3,4,5,6/
    


* 2. * Setting up dataset

PARAMETERS
    riverInflow      River Inflow /1/
    turbineCapacity   Turbine Capacity /4/
    resviorCapacity    Capacity of Reservior /9/
    ResviorStore       Initial Reservior Storage /5/;


* Input Data Table

    table data(t,*)
                InflowUnits HydroBenefit       IrrigationBenefit 
        1       2           1.6                1.0
        2       2           1.7                1.2
        3       3           1.8                1.9
        4       4           1.9                2.0
        5       3           2.0                2.2
        6       2           2.0                2.2;


* 3. DEFINE the variables
VARIABLES
    s(t)      Storage unit at end of each month
    wTr(t)    Water unit used by turbine each month
    spill(t)  Water units spilled from reservoir bypassing hydropower turbines in each month
    wIr(t)    Water units used for Irrigation in each month
    flowA(t) Water units retained in River at A each month
    B         Total benefits;
    
* Non-negativity constraints
POSITIVE VARIABLES S, wTr, spill, wIr, flowA;

* 4. COMBINE variables and data in equations
EQUATIONS
objective            equation representing objective function
balance1             mass balance eq for 1st month
resMassBalance(t)    water mass balance for month 2 to 6
resCapacity(t)       reservoir capacity constraint
turbCapacity(t)      turbine capacity constraint
irrDiversion(t)      diversion to irrigation
minFlowA(t)          minimum flow constraint at A
sStartEnd            ending storage at least equal to initial storage;

* Objective Function
objective..  B =e= sum(t, data(t,'HydroBenefit')*wTr(t)) + sum(t, data(t,'IrrigationBenefit')*wIr(t));

* Mass balance for month 1, starting from the initial storage
balance1.. s('1') =e= ResviorStore + data('1','InflowUnits') - spill('1') - wTr('1');

* Mass balance for months 2 to 6, starting from the previous month's storage
resMassBalance(t)$(ord(t) > 1).. s(t) =e= s(t-1) + data(t,'InflowUnits') - spill(t) - wTr(t);

* Reservoir capacity constraint
resCapacity(t).. s(t) =l= resviorCapacity;

* Turbine capacity constraint
turbCapacity(t).. wTr(t) =l= turbineCapacity;

* Irrigation diversion: turbine release plus spill, minus the flow left at A, goes to irrigation
irrDiversion(t).. wTr(t) + spill(t) - flowA(t) =e= wIr(t);

* Minimum flow requirement at point A
minFlowA(t).. flowA(t) =g= riverInflow;

* Ending storage at least equal to initial storage
sStartEnd.. s('6') =g= ResviorStore;

* 5. DEFINE the MODEL from the EQUATIONS
MODEL reservoir /all/;


option lp = cplex;
reservoir.optfile = 1;
$onecho > cplex.opt
rhsrng minFlowA
$offecho


* 6. SOLVE the MODEL
SOLVE reservoir USING LP MAXIMIZING B;

* 7. Display results
DISPLAY B.l, wTr.l, spill.l, wIr.l, flowA.l, s.l;


* Ask CPLEX to report ranging for the minimum flow constraint
