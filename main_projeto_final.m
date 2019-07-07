

%--------------------------- Main -----------------------------------------

load('workspace.mat')                                    %importa os dados y e u

indivi_notas_1  = simula_pop_nota(y,u);                  % 1000 individuos e suas notas
indivi_notas_ordenado_1 = sortrows(indivi_notas_1,9);    % individuos ordenados por nota
pop_1 = indivi_notas_ordenado_1(1:1000,1:8);              % primeira pop 100 melhores individuos

indivi_notas_2  = simula_pop_nota(y,u);                   % 1000 individuos e suas notas
indivi_notas_ordenado_2 = sortrows(indivi_notas_2,9);     % individuos ordenados por nota
pop_2 = indivi_notas_ordenado_2(1:1000,1:8);               % segunda pop 100 melhores individuos


% criação da terceira população 
pop_3 = zeros(3000,8);

a = [1,2,3,4];
b = [5,6,7,8];

for i = 1 : 3000
    
    %gerando coeficiente aleatorios
    pop_3(i,1) = randsample(pop_1(:,randsample(a,1)),1);
    pop_3(i,2) = randsample(pop_2(:,randsample(a,1)),1);
    pop_3(i,3) = randsample(pop_1(:,randsample(a,1)),1);
    pop_3(i,4) = randsample(pop_2(:,randsample(a,1)),1);
    
    %gerando expoentes aleatorios
    pop_3(i,5) = randsample(pop_1(:,randsample(b,1)),1);
    pop_3(i,6) = randsample(pop_2(:,randsample(b,1)),1);
    pop_3(i,7) = randsample(pop_1(:,randsample(b,1)),1);
    pop_3(i,8) = randsample(pop_2(:,randsample(b,1)),1);

end



%----------------------- Simulando novos 300 individuos--------------------
% condiçoes iniciais

Ysim = zeros(10001,1);              % saidas simuladas
erro_id_genetico = zeros(300,1);

Ysim(1) = y(1);
Ysim(2) = y(2);
Ysim(3) = y(3);

%condiçoes do loop
i = 0;
j = 0;

%calculo dos erros de uma pop
for j = 1 : 3000% varia individuos
%simulacao de um individuo j
    for i  = 1 : 9998
            Ysim(i+3) = (pop_3(j,1)*Ysim(i+2)^pop_3(j,5) +   ... 
            pop_3(j,2)*Ysim(i+1)^pop_3(j,6) +                ... 
            pop_3(j,3)*Ysim(i)^pop_3(j,7) +                  ...
            pop_3(j,4)*u(i)^pop_3(j,8));                     ...
    end % termina a simulacao temporal do individuo j
    erro_id_genetico(j) = sum((y - Ysim).^2);  % calculo do erro quadratico (fittness)
    if erro_id_genetico(j) < 1200
        fprintf('Individuo\n');
        pop_3(j,:)
        fprintf('Erro\n');
        erro_id_genetico(j)
    break
    else
  end

end
