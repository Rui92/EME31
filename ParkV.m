function [Vd,Vq] =ParkV(Vo1,Vo2,Vo3,wv,t)
%This function conducts the Voltage Park Transform
%Input: Vo1,Vo2,Vo3 are the thrphase voltages
%       wv is the angle velocity of voltage
%       t is the time
%Output: Vd,Vq are the transformed voltages,direct and quadratic 

% First, we write the form of phase
theta1=wv*t;
theta2=theta1-2*pi/3;
theta3=theta1-4*pi/3;


% Now conduct the voltage Park Transform
Vd=sqrt(2/3)*(cos(theta1)*Vo1+cos(theta2)*Vo2+cos(theta3)*Vo3);
Vq=sqrt(2/3)*(-sin(theta1)*Vo1-sin(theta2)*Vo2-sin(theta3)*Vo3);


end

