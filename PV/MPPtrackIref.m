% ECEN2060 DM 2/19/08
% Simple MPP "perturb and observe" tracking algorithm 
% using Boost DC-DC input current Iref as the control variable
% Pold, Iref and Increment are initialized in InitializeMPPtrackIref.m
%
% Input: power P to be maximized
% Output: reference current
function y = MPPtrackIref(P)

global Pold;
global Iref;
global Increment;

IrefH = 5; % upper limit for the reference current
IrefL = 0; % lower limit for the reference current
DeltaI = 0.02; % reference current increment

if (P < Pold)
    Increment = -Increment; % change direction if P decreased
end

% increment current reference
Iref=Iref+Increment*DeltaI;

% check for upper limit
if (Iref > IrefH)
    Iref = IrefH;
end

% check for lower limit
if (Iref < IrefL)
    Iref = IrefL;
end

% save power value
Pold = P;
% output current reference
y = Iref;