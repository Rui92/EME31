function [C,We,A] =EvoWe(Id,Iq,Phid,Phiq,delta_t,we,a)
%This function calculte the evolution of electrical velocity

%Input: Id,Iq are the transformed currents
%       Phid,Phiq are the transformed magnetic flux
%       delta_t is the step length of time
%       i represents the number of loop
%       we is current  electrical viteness 

%Output: We is the electrical velocity in the next time step

%First, we define the parameters that we have knewn
Pp=4; %Pole numbers
J=800*10^-6; % Inertie entrainee
k=0.3; % efficience of viscous friction

% Calculate Torque C
C=Pp*(Phid*Iq-Phiq*Id);
C_prime=Pp*(Phid*Iq-Phiq*Id)-k*we;

% Calculate the following electrical viteness 
Wm=C_prime*delta_t/J;
We=Pp*Wm+we;

% Calculate elctrical angle A of the rotor
A=We*delta_t+a;

end

