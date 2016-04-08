%This is the main function of machine synchrone
%In this script, we input thrphase voltage with phase shift of 2*pi/3 among
%each of them
%With the input voltage, we start the calculation beginning with all
%currents, voltages are zeros

%Define all the parameters
E=12; % Amplitude of the triphase voltage 
Wv=70; % Angle viteness of voltage
delta_t=10*10^-6; % step length
T=100*0.001; % Time total of period 
n=floor(T/delta_t); % Number of the loop
t=delta_t*(1:n); % Time correspanding of each step

% Pp=4; %Pole numbers
% J=800*0.0000001; % Inertie entrainee
% k=0.3; % efficience of viscous friction   v
% 
% Rs=0.18; %Resistor looked in Park
% Ld=1.15*0.001; %Indultance stator of Park direct
% Lq=3.31*0.001; %Indultance stator of Park quadratic
% Phim=200*0.001; %Magnetic flux 


% Define the length of all the vectors
Vo1=zeros(1,n);
Vo2=zeros(1,n);
Vo3=zeros(1,n);

Vd=zeros(1,n);
Vq=zeros(1,n);

Phid=zeros(1,n);
Phiq=zeros(1,n);

Id=zeros(1,n);
Iq=zeros(1,n);

I1=zeros(1,n);
I2=zeros(1,n);
I3=zeros(1,n);

C=zeros(1,n);
We=zeros(1,n);
A=zeros(1,n);

% For obten the initial value of we and A for the loop calculation
Vo1(1)=E*sign(sin(Wv*t(1)+pi));
Vo2(1)=E*sign(sin(Wv*t(1)+pi-2*pi/3));
Vo3(1)=E*sign(sin(Wv*t(1)+pi-4*pi/3));
[Vd(1),Vq(1)]=ParkV(Vo1(1),Vo2(1),Vo3(1),Wv,t(1));
[Id(1),Iq(1),Phid(1),Phiq(1)]=Integral(0,0,0,Vd(1),Vq(1),delta_t);
[a,We(1),A(1)]=EvoWe(0,0,0,0,delta_t,0,0);

% Begin the main script
for i=2:n %indice of the loop
    
    % Calculate the valus of input voltages
    Vo1(i)=E*sign(sin(Wv*t(i)+pi));
    Vo2(i)=E*sign(sin(Wv*t(i)+pi-2*pi/3));
    Vo3(i)=E*sign(sin(Wv*t(i)+pi-4*pi/3));
    
    %Calculate the values of Vd,Vq using voltage park voltage
    [Vd(i),Vq(i)]=ParkV(Vo1(i),Vo2(i),Vo3(i),Wv,t(i));
    
    %Calculate the valus of Id,Iq,Phid,Phiq
    [Id(i),Iq(i),Phid(i),Phiq(i)]=Integral(Id(i-1),Iq(i-1),We(i-1),Vd(i-1),Vq(i-1),delta_t);
    
    %Calculta the values of I1,I2,I3
    [I1(i),I2(i),I3(i)]=ParkIInverse(Id(i),Iq(i),A(i));
    
    %Calculate the moment, the electrical viteness and the electrical angle
    [C(i-1),We(i),A(i)]=EvoWe(Id(i-1),Iq(i-1),Phid(i-1),Phiq(i-1),delta_t,We(i-1),A(i-1));
    
end
C(n)=EvoWe(Id(n-1),Iq(n-1),Phid(n-1),Phiq(n-1),delta_t,We(n-1),A(n-1));

%Plot the diagrammes


% subplot(2,1,1)
% plot(t,sum)
% subplot(2,1,2)
% plot(t,Vo1)
% hold on

subplot(4,2,1)
hold on
plot(t,Vo1+1,t,Vo2,t,Vo3-1)
title('Thrphase voltages with +-5V on the 1st and 3rd')
legend('Vo1+1','Vo2','Vo3-1')

subplot(4,2,2)
plot(t,Vd,'--',t,Vq)
title('Vd Vq')
legend('Vd','Vq')

subplot(4,2,4)
plot(t,Id(1:n),'--',t,Iq(1:n))
title('Id Iq')
legend('Id','Iq')

subplot(4,2,3)
plot(t,I1,t,I2,t,I3)
title('I1 I2 I3')
legend('I1','I2','I3')

subplot(4,2,5)
plot(t,Phid(1:n),t,Phiq(1:n))
title('Phid Phiq')
legend('Phid','Phiq')

subplot(4,2,6)
plot(t,C)
title('The moment')

subplot(4,2,7)
plot(t,We(1:n))
title('The electrical viteness')


subplot(4,2,8)
plot(t,A(1:n))
title('electrical angle')


