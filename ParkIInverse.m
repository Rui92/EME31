function [I1,I2,I3] = ParkIInverse(Id,Iq,a)
%This function conducts the Inverse Current Park Transform
%Input: Id, Iq are the transformed voltage, direct and quadratic
%       a is the current angle of the rotor
%Output: I1,I2,I3 are the real triphase voltage

%First, we write the form of theta to simplify the calculation
theta1=a;
theta2=theta1-2*pi/3;
theta3=theta1-4*pi/3;

% Now conduct the Inverse Current Park Transform
I1=sqrt(2/3)*(cos(theta1)*Id-sin(theta1)*Iq);
I2=sqrt(2/3)*(cos(theta2)*Id-sin(theta2)*Iq);
I3=sqrt(2/3)*(cos(theta3)*Id-sin(theta3)*Iq);

end

