using Plots

"""
    Linguagem utilizada: Julia 1.6.2
    Autor : Jorge Ivan Augusto de Oliveira filho 
"""

function newton(f::Function,df::Function,x::Number,ϵ::AbstractFloat,steps::Integer=100)

    """
    Função para encontrar raiz de uma função pelo método de newton-raphson

    Parâmetros

    f : função 
        Função que se deseja encontrar o 0 
    df : função 
        Derivada de f(x)
    x : Número
        Suposição inicial para a solução de f(x) = 0 
    ϵ : Número 
        Tolerância em relação ao valor real 
    steps: Número 
        Número maximo de interações
    """

    xn = x
    for i in 1:steps
        fxn = f(xn)
        if abs(fxn) < ϵ
            return xn 
        end 
        xn = xn - fxn/df(xn)
    end 

    println("Excedeu o número de interações foi exedido, e nem uma raiz com tolerância desejada foi encontrado")
    return xn

end 


function bisection(f::Function, a::Number, b::Number;
                   ϵ::AbstractFloat=1e-5, maxiter::Integer=100)
    """
    Função para encontrar raiz de uma função pelo método da bisseção

    Parâmetros

    f : função 
        Função que se deseja encontrar o 0 
    a : Número 
        Inicio do intervalo 
    b : Número 
        Fim do intervalo
    x : Número
        Suposição inicial para a solução de f(x) = 0 
    ϵ : Número 
        Tolerância em relação ao valor real 
    maxiter: Número 
        Número maximo de interações
    """

    fa = f(a)
    fa*f(b) <= 0 || error("Nem uma raiz entre o intervalo [a,b]")
    i = 0
    local c
    while b-a > ϵ
        i += 1
        i != maxiter || error("Número maximo de interações exedidas")
        c = (a+b)/2
        fc = f(c)
        if fc == 0
            break
        elseif fa*fc > 0
            a = c  .
            fa = fc
        else
            b = c
        end
    end
    return c
end


#Essa função pode apresentar mal funcionamento, a linguagem utilizada não tem função nativa para conseguir input do úsuario
function input(prompt::AbstractString)::String

    """
    Função para extrair input do úsuario 

    Parâmetros 

    prompt: string
        Menssagem que sera exibida ao úsuario
    """
    print(prompt)
    return parse(Float64,chomp(readline()))
end 


# Conseguir dados do úsuario
E = input("Insira a tensão da fonte: ")
R = input("Insira a resistência elétrica do resistor: ")
IS = input("Insira a corrente de saturação do diodo: ")
a = input("Insira o valor do limite inferior: ")
b = input("Insira o valor do limite superior: ")


println("-"^40)

VT = 0.026 


#Dainte a uma serie de testes realizados, o método de bisseção se demonstrou mais eficiente, por isso é utilizado a seguir . 

f(VD) = E - VD - R*IS*(exp(VD/VT) - 1) # Função

# Calcular o 0 da raiz
val = bisection(f,a,b)
println("Valor da tensão elétrica  encontrada: $(val) [V]")
print("Valor da corrente que atravessa o diodo $(ID(val)) [A]")

#Plottar o gráfico de ID com o ponto
x = LinRange(a, b,100)
ID(VD) = IS*(exp(VD/VT)-1)
plot(x,ID.(x))
scatter!([val],[ID(val)])

ID(VD) = IS*(exp(VD/VT)-1)

