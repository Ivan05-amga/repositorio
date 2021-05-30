import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
 
# b = R/L ou 1/RC c = 1/LC e d valor da fonte 
def model(x, t, b, c,d):
    y, dy = x[0], x[1] #Condições iniciais
    dydx = [dy,- b * dy - c * y + d*c]  #Equação diferencial
    return dydx
 
def main(): 
 
  #Tipo do circuito 
  while True: 
    tipo = input("Qual o tipo de circuito[série/paralelo]?: ")
    if tipo.lower() == "série" or tipo.lower() == "paralelo": 
      break 
  
  # Parametros 
  print('Digite os valores de R[\u03A9], C[F] e L[H].')
  R = float(eval(input("R: ")))
  C =  float(eval(input("C: ")))
  L = float(eval(input("L: ")))
 
  #Para se o circuito estiver em série 
  if tipo.lower() == "série":
    alpha = R/(2*L)
  elif tipo.lower() == "paralelo": 
    alpha = 1/(2*R*C)
  omega = 1/np.sqrt(L*C)
 
 
  omegad = 0 
 
  #Determinar a solução que está relacionada aos valores alpha e omega  e modificar o valor de omegad caso esse seja 𝑠𝑢𝑏𝑎𝑚𝑜𝑟𝑡𝑒𝑐𝑖𝑑o
  if alpha > omega: 
    cond = '𝐴𝑚𝑜𝑟𝑡𝑒𝑐𝑖𝑚𝑒𝑛𝑡𝑜 𝑆𝑢𝑝𝑒𝑟𝑐𝑟í𝑡𝑖𝑐𝑜 𝑜𝑢 𝑟𝑒𝑠𝑝𝑜𝑠𝑡𝑎 𝑆𝑢𝑝𝑒𝑟𝑎𝑚𝑜𝑟𝑡𝑒𝑐𝑖𝑑o.'
  elif alpha < omega: 
    cond = "𝑅𝑒𝑠𝑝𝑜𝑠𝑡𝑎 𝑠𝑢𝑏𝑎𝑚𝑜𝑟𝑡𝑒𝑐𝑖𝑑𝑎."
    omegad = np.sqrt(omega**2-alpha**2)
  else: 
    cond = "𝐴𝑚𝑜𝑟𝑡𝑒𝑐𝑖𝑚𝑒𝑛𝑡𝑜 𝑐𝑟í𝑡𝑖𝑐𝑜 𝑜𝑢 𝑟𝑒𝑠𝑝𝑜𝑠𝑡𝑎 𝑐𝑟í𝑡𝑖𝑐a."
 
  #Condições inicias do circuito
  print("Digite os valores da corrente inicial I0[A] no indutor e da tensão inicial V0[V] no capacitor?")
  V0 = float(input("V0: "))
  I0 = float(input("I0: "))
 
  #Tempo de 0 a 10 segundos com 1000 intervalos
  tf = float(input("Digite o tempo final[s]: "))
  N = int(input("Digite o número de passos: "))
  t = np.linspace(0, tf, N)
  
  print("Digite os valores da fonte de corrente If[A] ou da fonte tensão Vf[V], caso estejam presentes:")
  Vf = float(input("Vf: "))
  If = float(input("If: "))
 
  #Calcular a V(t) e I(t)
  if tipo.lower() == "série": 
    Vt = odeint(model, [V0,(I0/C)], t, args=(2*alpha,omega**2,Vf))
    It = odeint(model, [I0,(Vf-V0-R*I0)/L], t, args=(2*alpha,omega**2,If))
  elif tipo.lower() == "paralelo":
    Vt = odeint(model, [V0,(Vt-1*((V0+I0*R)/(R*C)))], t, args=(2*alpha,omega**2,Vf))
    It = odeint(model, [I0,V0/L], t, args=(2*alpha,omega**2,If))


  #Plot da tensão e corrente no mesmo gráfico 
  plt.subplot(3,1,1)
  plt.plot(t,Vt[:,0],'b',label="Tensão")
  plt.plot(t,It[:,0],'r',label="Corrente")
  plt.xlabel('Tempo(s)')
  plt.legend(loc='lower right')
 
  #Plot da corrente
  plt.subplot(3,1,2)
  plt.plot(t,It[:,0],'r',label="Corrente")
  plt.ylabel('I(t)')
  plt.legend(loc='lower right')
 
  #Plot da tensão
  plt.subplot(3,1,3)
  plt.plot(t,Vt[:,0],'b',label="Tensão")
  plt.ylabel('V(t)')
  plt.xlabel('Tempo(s)')
  plt.legend(loc='upper right')
 
  plt.show()
 
  #Exibir valores ao úsuario
  print("\nValores encontrados:")
  print(f"\u03C9 = {omega}[rad/s] \u03B1 = {alpha}[Np/s] \u03C9\u1D05 = {omegad} [rad/s]")
  print(cond)
 
if __name__ == "__main__":
  main()
