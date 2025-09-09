% input values for case 1 or 2
A1 = 2.0; A2 = 2.0
alpha1 = 0.3; alpha2 = 0.3
kappa1 = 1.0; kappa2 = 1.0
gamma1 = 1.0; gamma2 = 1.0
R01 = 0.15; R02 = 0.10
L_total = 10

L1 = linspace(0, L_total, 100) % L1 range
L2 = L_total - L1

%wages
wage1 = A1 * L1.^alpha1
wage2 = A2 * L2.^alpha2

% commuting cost
commuting_cost1 = kappa1 * (L1 / 2).^gamma1
commuting_cost2 = kappa2 * (L2 / 2).^gamma2

% rent + commuting cost
rent1 = R01 + commuting_cost1
rent2 = R02 + commuting_cost2

% net consumption
C1 = wage1 - rent1
C2 = wage2 - rent2

figure;
plot(L1, C1, 'LineWidth', 2, 'DisplayName', 'City 1')
hold on;
plot(L1, C2, 'LineWidth', 2, 'DisplayName', 'City 2')
xlabel('L1 (Population in City 1)')
ylabel('C^* (Consumption)')
title('Consumption in City 1 and City 2 (Case 2)')
legend show
grid on

equilibrium_func = @(L1) (A1 * L1.^alpha1 - (R01 + kappa1 * (L1 / 2).^gamma1)) - (A2 * (L_total - L1).^alpha2 - (R02 + kappa2 * ((L_total - L1) / 2).^gamma2))

% solve where c1 = c2
L1_eq = fsolve(equilibrium_func, L_total / 1.1); 
% choose where you start and it finds closest equ

C_eq = A1 * L1_eq.^alpha1 - (R01 + kappa1 * (L1_eq / 2).^gamma1);

%show results
fprintf('L1 = %.2f, L2 = %.2f\n', L1_eq, L_total - L1_eq);
fprintf('C* = %.2f\n', C_eq);