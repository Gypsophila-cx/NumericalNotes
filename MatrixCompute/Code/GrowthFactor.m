n = 0:1e3;
rho_p = 2.^(n-1);
rho_c = sqrt(n).*n.^(log(n)/4);
rho_r = 1.5*n.^(3/4*log(n));

semilogy(n,rho_p,'b:','LineWidth', 1.2)
hold on
semilogy(n,rho_c,'r-','LineWidth', 1.2)
semilogy(n,rho_r,'-.','LineWidth', 1.2)
axis([0,1e3,0, 1e20])
legend('Partial pivoting', 'Complete pivoting', 'Rook pivoting')
xlabel('\bfn')
ylabel('\bfGrowth Factor')