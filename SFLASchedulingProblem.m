%% Simple Scheduling Problem by Shuffled Frog Leaping Algorithm (SFLA)

% There are 10 jobs or tasks which should be finished in time. 
% In "CreateModel.m" file:
% p is process time for jobs 
% s is setup time matrix (spaces between boxes in plot)
% d is jobs due 
% You can change them.
% q is order of jobs
% ST is start time
% FT is finish time
% z is final cost and Cmax must be equal with it or it is a violation. 

%%------------------------------------------------------------------
clc;
clear;
close all;

%% Problem 
model=CreateModel();
CostFunction=@(s) MyCost(s,model);        % Cost Function
nVar=model.n;             % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
VarMin=0;         % Lower Bound of Variables
VarMax=1;         % Upper Bound of Variables

%% SFLA Parameters

MaxIt = 100;        % Maximum Number of Iterations
nPopMemeplex = 5;                          % Memeplex Size
nPopMemeplex = max(nPopMemeplex, nVar+1);   % Nelder-Mead Standard
nMemeplex = 5;                  % Number of Memeplexes
nPop = nMemeplex*nPopMemeplex;	% Population Size
I = reshape(1:nPop, nMemeplex, []);

% FLA Parameters
fla_params.q = max(round(0.3*nPopMemeplex), 2);   % Number of Parents
fla_params.alpha = 3;   % Number of Offsprings
fla_params.beta = 5;    % Maximum Number of Iterations
fla_params.sigma = 2;   % Step Size
fla_params.CostFunction = CostFunction;
fla_params.VarMin = VarMin;
fla_params.VarMax = VarMax;

%% Initialization

% Empty Individual Template
empty_individual.Position = [];
empty_individual.Cost = [];
empty_individual.Sol = [];

% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);

% Initialize Population Members
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost pop(i).Sol] = CostFunction(pop(i).Position);
end

% Sort Population
pop = SortPopulation(pop);

% Update Best Solution Ever Found
BestSol = pop(1);

% Initialize Best Costs Record Array
BestCosts = nan(MaxIt, 1);

%% SFLA Main Loop

for it = 1:MaxIt

fla_params.BestSol = BestSol;

% Initialize Memeplexes Array
Memeplex = cell(nMemeplex, 1);

% Form Memeplexes and Run FLA
for j = 1:nMemeplex
% Memeplex Formation
Memeplex{j} = pop(I(j, :));

% Run FLA
Memeplex{j} = RunFLA(Memeplex{j}, fla_params);

% Insert Updated Memeplex into Population
pop(I(j, :)) = Memeplex{j};
end

% Sort Population
pop = SortPopulation(pop);

% Update Best Solution Ever Found
BestSol = pop(1);

% Store Best Cost Ever Found
BestCosts(it) = BestSol.Cost;

% Show Iteration Information
disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
% Plot Best Solution
figure(1);
PlotSolution(BestSol.Sol,model);
end

%% Results

figure;
plot(BestCosts,'k', 'LineWidth', 2);
xlabel('ITR');
ylabel('Cost Value');
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','[0.9 0.8 0.7]')
grid on;

%
BestSol.Sol
