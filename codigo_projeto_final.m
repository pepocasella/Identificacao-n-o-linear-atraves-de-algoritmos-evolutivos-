
%-------------------------- Projeto Final ---------------------------------
function [resultado, geneVencedor] = codigo_projeto_final(y,u,Ts)

[erro_id_genetico] = erros_id_genetico(y,u,Ts);

end





%---------------------------------fim--------------------------------------




%---------------------------- Funções  ------------------------------------

function selecao()

% função que realiza a seleção e cruzamentos dos individuos 



end


function [erro_id_genetico] = erros_id_genetico(y,u,Ts)

entrada = u; %entrada U
saida = y; % saida Y
DATA = iddata(saida,entrada,Ts);
%na = ordem poli saida
%nb = ordem poli entrada
%nk = começa explicar a partir de que instante passado a entrada (polinomio B)
nk = 1;
modeloIdentificado = arx(DATA,[3,1,nk]) %identificação A(z) e B(z)
fprintf('FPE:')
FPE = modeloIdentificado.report.fit.FPE
fprintf('AIC:')
AIC = modeloIdentificado.report.fit.AIC

%--------------------------------------------------------------------------

X0 = y(1);
[yid,t] = lsim(modeloIdentificado,u,[],X0);
erro_id_arx = sum((y - yid).^2);

%--------------------------------------------------------------------------

% individuos

genes_fi = 0.1*randn(1000,4);           
genes_fi(1,:) = [.3 -.6 -.8 2]; 
%histogram(randn(10000,4))
genes_exp = floor(2*rand(1000,4));
genes_exp(1,:) = [3 1 2 1];
Ysim = zeros(10001,1);

% condiçoes iniciais

Ysim(1) = y(1);
Ysim(2) = y(2);
Ysim(3) = y(3);

%condiçoes do loop

i = 0;
erroMin = erro_id_arx + 1;

while erroMin > erro_id_arx/2

    %calculo dos erros de uma pop
    for j=1 : 1000% varia individuos
    %simulacao de um individuo j
        for i  = 1 : 9998
            Ysim(i+3) = (genes_fi(j,1)*Ysim(i+2)^genes_exp(j,1) +   ... 
            genes_fi(j,2)*Ysim(i+1)^genes_exp(j,2) +                ... 
            genes_fi(j,3)*Ysim(i)^genes_exp(j,3) +                  ...
            genes_fi(j,4)*u(i+2)^genes_exp(j,4));                   ...
        end % termina a simulacao temporal do individuo j 
       erro_id_genetico(j) = sum((y - Ysim).^2)  % calculo do erro quadratico (fittness) do individuo j
    end
    erroMin = min(erro_id_genetico(j)) ; 
    
end


end
