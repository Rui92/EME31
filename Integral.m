function [Id,Iq,Phid,Phiq] =Integral(id,iq,we,vd,vq,delta_t)
%This function aims to calcule the evolution of transformed currents and magnetic flux with
%time, typical in the next step

%Input: id,iq are the current transformed currents 
%       we is the electrical velocity
%       vd,vq are the current transformed voltages
%       delta_tau is the time length of one step

% First, we define the parametres the are needed and we have already known
Rs=0.18; %Resistor looked in Park
Ld=1.15*0.001; %Indultance stator of Park direct
Lq=3.31*0.001; %Indultance stator of Park quadratic
Phim=200*0.001; %Magnetic flux 

% Calculate the derivative of Id,Iq
Id_prime=vd/Ld-Rs/Ld*id+we*Lq/Ld*iq;
Iq_prime=(vq-we*Phim)/Lq-we*Ld/Lq*id-Rs/Lq*iq;

% Calculate the currents in the next step
Id=id+Id_prime*delta_t;
Iq=iq+Iq_prime*delta_t;

%Calculate the magnetic flux in the next step
Phid=Ld*Id+Phim;
Phiq=Lq*Iq;


end

