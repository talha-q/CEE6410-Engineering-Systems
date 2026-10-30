1.Dimensions

&#x09;\*Time (June, July, August)

&#x09;\*Spatial (Network)- Spill, Diversion, Reservior, Storage.

Dimensions are for the decision variables.

&#x09;

&#x20;

2.Decision Variables.

&#x09;\*How much to release to Diversion in time t

&#x09;X(diversion, t)\[acre, feet]



&#x09;\*How much to keep in reservoir storage at the end of time t

&#x09;X(Reservior Storage, t) \[acre, feet]

&#x09;

&#x09;\*How much water to spill in time t (acre-feet)

&#x09;X(spill, t)



3.Maximize Irrigation Benefits ($)

&#x09;Max (Z)= 150\*X(Diversion), June + 170\*X(Diversion), July + 425\*X(Diversion), August



(simplex needs all the decision variables)



\-------------------
1.Dimensions

Suppliers \[Kansas City, Dallas]

Dealers \[New York , Minneapolis, Seattle, San Francisco]



2\. Decision Variable
The number of cars to ship from each supplier to each dealer.

&#x20;(each OD is a decision variable)\[8]

X(supplier, Dealer)





3\. Minimize Shipping cost

&#x09;z=sum c(supplier, dealer).X(suppliers, Dealers) ---all suppliers and all dealers



GAMS Syntax ::: Sum(Suppliers, c(suppliers):X(Suppliers)

Sum((Suppliers, Dealers), C(Supplier, Dealer). X(Supplier, Dealer)]

=Sum(Suppliers, C(Supplier, "New York") + Sum(suppliers, c(supliers, "San Francisco")





It is called directed graph



\---

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

HW4

Dimensions: Manufacturers, Dealerships, Suppliers

* 

Decision Variables:
Volume of vehicle to send from each supplier to each dealer (Xsupplier, dealer)

* Volume of vehicle to send from each manufacturer to each supplier(Xmanufacturer,supplier)
total 10 decision variables.
* Sum of deliveries from each manufacturer have to be less than or equal to manufacturer production.

Objective

Minimize total cost



Constraints

* The sum of deliveries from each supplier has to be less than or equal to the available stock.

Satisfy demand at each dealer, i.e sum of deliveries to each dealer has to be greater than or equal to its demand.

\---

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

\---------------------------------------------------

* \------------------------------
Dual of LP
* Sometimes the primal



binding, non binding, profit coefficients.



Lagrange multipliers.

Decision variables in the dual problem.



adding 1gal of water we will.

Labor does not increase our profit as it is not binding.





\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
Prompt F
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

Give both the problems in mathematical form.
shadow values/lagrange multipliers.





\------------------------

if we increase this k coefficient from 100 to 101 dollars per acre than this is how much our hay will change i.e 2000.





Sensitivity Analysis

Ranging information: range of basis.  we wanna know how much of the value will increase or decrease when the information change.







\--------------Running the edited code

variables will be in the basis or not in the basis just by looking at equation name, lower, current and upper.



if we decrease the eggplants less than 4.66 i.e lower value either eggplant or the tomatoes will come out of the basis



gams also gives the level values if the model fails.

to report.... the water constraint is no longer binding.

shasow values.... the missing lables mean the zero values





interpreting shadow values of parameters

in run 4 the land has shadow value but water has not. Since the land has shadow values, and water did not, the land is the binding in the r4.

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

Mixed Integer Programming
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
OCTOBER 8

Integer Programming.
What the jump represents.
Jump- e.g there is one initial cost of construction of a bus station and then there is another cost that is associated with it, i.e operation cost.
cost is the capital cost x Integer -----
X is a continuous variable, it has to be less than or equal to a very large number times an integer.



Example problems.
Example 5 (modified example 4) in the lecture doc.

Src water source/tp,wc)

Desisions

* I(tp)= To build treatment plant (1=yes, 0=no)
* I(wc)= To enter into the water contract (1=yes, 0=No)
* X(tp)= how much water to take from treatment plant (acf year
* X(wc)= How much water to take from water contract (acf)



Objective:

Minimize Total Cost



Constraints:
We need to use source only if we build it.

We



Solution Algorithm Spreadsheet.

When we say branch or bound we are applying a vertical constraint that divides the decision space in 2.

&#x09;First of all we solve the relaxed problem.





we did integer problem in gams and excel now back to the doc



\------------

Integer version of the problem





\-----------------
Special event parking problem



Dimensions:

* Parking Lot North
* Parking Lot South
* Parking Lot West
* Vendor Purple Rain
* Vendor Blue Sky



Decision Variables

Xpl= Number of buses from Parking Lot PL (integers)

G= Number of grand stands to rent from vendor (Integer)

Ivendor= use vendor (yes=1, No=0) \[Integer Binary]



Objective:
minimize Z= parking spot, buses, vendor , grand stand







\-------------------------------------------------

MultiObjective Problem 29 October 2026

\-----------------------------------------------

In order to solve the multi objective problem we need to run the problem multiple times. If we have 4 variables and 6 objectives, we need to run it for 6times6times6 each. 

There is a conflict in old way of representing the water distribution problem in Colorado river basin. 



