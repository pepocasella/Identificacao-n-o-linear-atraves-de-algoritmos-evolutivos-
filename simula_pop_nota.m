function [indivi_notas] = simula_pop_nota(y,u)
%-----------------------------Criação dos Individuos-----------------------
% individuos - [fi_1, fi_2, fi_3, fi_4, alph1, alph2, alph3, alph4]

genes_fi = 0.5*randn(10001,4);           
%genes_fi(1,:) = [.3 -.6 -.8 2]; 
%histogram(0.1*randn(10000,4))

genes_exp = zeros(10001,1);
g_exp = [1, 2, 3, 4, 5];            % genes de expoentes variam 1 -> 5
count = 1;
while count < 10001
    genes_exp(count,1) = randsample(g_exp, 1);
    genes_exp(count,2) = randsample(g_exp, 1);
    genes_exp(count,3) = randsample(g_exp, 1);
    genes_exp(count,4) = randsample(g_exp, 1);
    count = count + 1;
end
%histogram(genes_exp)
%genes_exp(1,:) = [3 1 2 1];

Ysim = zeros(10001,1);              % saidas simuladas
melhores_genes = zeros(1000,8);
indivi_notas = zeros(1000,9);
erro_id_genetico = zeros(1000,1);

%------------------------- Simulando 1000 individuos-----------------------
% condiçoes iniciais

Ysim(1) = y(1);
Ysim(2) = y(2);
Ysim(3) = y(3);

%condiçoes do loop
i = 0;
j = 0;

    %calculo dos erros de uma pop
    for j = 1 : 10000% varia individuos
    %simulacao de um individuo j
        for i  = 1 : 9998
            Ysim(i+3) = (genes_fi(j,1)*Ysim(i+2)^genes_exp(j,1) +   ... 
            genes_fi(j,2)*Ysim(i+1)^genes_exp(j,2) +                ... 
            genes_fi(j,3)*Ysim(i)^genes_exp(j,3) +                  ...
            genes_fi(j,4)*u(i)^genes_exp(j,4));                     ...
        end % termina a simulacao temporal do individuo j
    
       erro_id_genetico(j) = sum((y - Ysim).^2);  % calculo do erro quadratico (fittness) do individuo j
       
       %matriz dos individuos simulados com as notas respectivas
       indivi_notas(j,1) = genes_fi(j,1);
       indivi_notas(j,2) = genes_fi(j,2);
       indivi_notas(j,3) = genes_fi(j,3);
       indivi_notas(j,4) = genes_fi(j,4);
       indivi_notas(j,5) = genes_exp(j,1);
       indivi_notas(j,6) = genes_exp(j,2);
       indivi_notas(j,7) = genes_exp(j,3);
       indivi_notas(j,8) = genes_exp(j,4);
       indivi_notas(j,9) = erro_id_genetico(j);
    end

end