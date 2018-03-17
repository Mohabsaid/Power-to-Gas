% 
% ECEN2060
% Initialize MPPtrackIref
%
global Iref;
global Increment;
global Pold;
Pold = 0; % initial value for the sensed power
Iref = 4; % initial value for the current reference
Increment = -1; % initial direction: decrease reference current