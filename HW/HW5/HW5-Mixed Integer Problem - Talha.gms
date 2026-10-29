$ontext
Reservoir Design Problem - Mixed Integer Programming HW5
CEE 6410/5410 by Dr.David Rosenberg

-------------------------------
Problem text from canvas
-------------------------------
Formulate and Solve the mixed integer program for Chapter 7, Problem #1 (a 3rd change, this one final)
Technical portion of the grading rubric:
Integer programming
a) Problem Formulation - Dimensions, Decision Variables (10 pts), Objective Function (10 pts), Constraints (10 pts)
b) Solution Method (20)
c) Results, Recommendations, and New Insights for Management (20)

-------------------------------
Problem Statement 
-------------------------------
A farmer plans to develop water for irrigation. He is considering two possible sources of
water: a gravity diversion from a possible reservoir with two alternative capacities and/or a
pump from a lower river diversion (refer to Figure 7.3). Between the reservoir and pump
site the river base flow increases by 2 acft/day due to groundwater drainage into the river.
Ignore losses from the reservoir. The river flow into the reservoir and the farmer's demand
during each of two six-month seasons of the year are given in Table 7.5. Revenue is estimated
at $300 per year per acre irrigated.


Assume that there are only two possible sizes of reservoir: a high dam that has capacity of
700 acft or a low dam with capacity of 300 acft. The capital costs are $10,000/year and
$6,000/year for the high and low dams, respectively (no operating cost). The pump capacity
is fixed at 2.2 acft/day with a capital cost (if it is built) of $8,000/year and operating cost
of $20/acft.


Table 7.5
Season,t     River Inflow, Qt (acft)    Irrigation Demand (acft/acre)    
1            600                        1.0
2            200                        3.0

Table 7.6
Facility            Capital ($/year)    Operating Cost ($/acft)  Capacity (acft)
Reservior High      10000               0                        700
Reservior Low       6000                0                        300
Pump                8000                20                       2.2acft/day

Full details at https://usu.instructure.com/courses/818402/files/100525844?wrap=1


Author
Talha Quddoos
talha.quddoos@usu.edu
October 19, 2026

$offtext

*------House Keeping------------------------- 
*Number of seasons:     2
*Season Length:         6months
*Pump Capacity/season:  2.2*30*6  =           396 acft/season
*Ground Water Drainage: 2acft/day = 2*30*60 = 360 acft/season


*------1. DEFINE the SETS or Dimensions------- 
SETS
    t Seasons          /1,2/
    src Water Sources  /Dam1, Dam2, Pump/
*    Dam1 is High capacity dam and Dam2 is low capacity dam
                    ;


*------2. DEFINE input data-------

PARAMETERS

    Q(t)           River inflow (acft)               /1 600,2 200/
    Demand(t)      Irrigation Demand (acft per acre) /1 1,2 3/
    Capacity(src)  Source Capacity (acft)            /Dam1 700, Dam2 300, Pump 396/
    Cost(src)      Capital Cost ($)                  /Dam1 10000, Dam2 6000, Pump 8000/
    OpCost(src)    Operational Cost($ per acft)      /Dam1 0, Dam2 0, Pump 20/
    Revenue        Irrigation Revenue ($ per acre)   /300/
    GroundDrainage Ground Water Drainage (per season)/360/;


*------3. DEFINE the variables------- 
Variables
    Z           Profit ($)
    AC          Acres irrigated by water
    R(t)        Water released from reservior in season t (acft per season)
    Sp(t)       Water spill in river from reservior
    P(t)        Water pumped from pump in season t (acft per season)
    S(t)        Reservior storage at the end of season t (acft)
    I(src)      Binary variable for the source choices;
    
Binary Variable I;
Positive Variables Sp,AC,R,P,S;

*------4. COMBINE variables and data in equations-------  
*EQUATIONS
Equations
   Profit          Total Profit ($) and obj. function
   MB1             Mass Balance at the end of season 1
   MB2             Mass Balance at the end of season 2
   StCap1          Storage Capacity in season 1
   StCap2          Storage Capacity in season 2
   Demand1         Water Demand in season 1
   Demand2         Water Demand in season 2
   DamSelect       Dam type choice
   PumpCap1        Pump Capacity in season 1
   PumpCap2        Pump Capacity in season 2
   Pwater1         water pumped in season 1
   Pwater2         water pumped in season 2


;

*------Objective Function -------
*Maximizing Profit = Benefits - Costs
Profit..              Revenue*AC - Cost('Dam1')*I('Dam1') -Cost('Dam2')*I('Dam2') - Cost('Pump')*I('Pump') - OpCost('Pump')*Sum(t,P(t)) =e=  Z ;

*------Constraints -------
MB1..                 S('2') =e= S('1') + Q('1')-Sp('1')-R('1');                                                                                      
MB2..                 S('1') =e= S('2') + Q('2')-Sp('2')-R('2');
StCap1..              S('1') =L= Capacity('Dam1')*I('Dam1') + Capacity('Dam2')*I('Dam2');
StCap2..              S('2') =L= Capacity('Dam1')*I('Dam1') + Capacity('Dam2')*I('Dam2');
Demand1..             R('1')+P('1') =G= 1*AC;
Demand2..             R('2')+P('2') =G= 3*AC;
DamSelect..           I('Dam1')+I('Dam2')=L=1;
PumpCap1..            P('1') =L= Capacity('Pump')*I('Pump');
PumpCap2..            P('2') =L= Capacity('Pump')*I('Pump');
Pwater1..             P('1') =L= Sp('1')+GroundDrainage;
Pwater2..             P('2') =L= Sp('2')+GroundDrainage;


*------5. DEFINE the MODEL from the EQUATIONS -------  
model WaterDistribution /all/;


*------6. Solve the Model as a Mixed Integer Program ------- 
solve WaterDistribution using mip maximize Z;

*------7. Disparklotay the decision variable values in the list file ------- 
display I.L, AC.L, R.L, Sp.L, P.L, S.L, Z.L;
*
* Dump all input data and results to a GAMS gdx file
Execute_Unload "MIP-HW5_Talha.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls MIP-HW5_Talha.gdx"
