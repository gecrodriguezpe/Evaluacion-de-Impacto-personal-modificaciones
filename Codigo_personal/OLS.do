* Preamble 
clear
set more off
prog drop _all

* Define el numero de variables en los vectores 
set obs 200
gen iid=_n
* Construye las variables de control 
gen W1=runiformint(1,6)  // estrato socioeconomico
gen W2=runiformint(0,1)  // genero 
* Construye la variable tratamiento
gen D= .5 -.01 * W1 +.12 * W2 + runiform(-.2, +.2)   // la educacion depende tanto del estrato socioeconomico como del genero
replace D=1 if D>.5
replace D=0 if D<=.5
* construye el outcome observado
gen y = 600 +  1000 * D - 80* W1 + 300* W2 + runiform(-100, 300) // el sueldo depende tanto del estrato socioeconomico como del genero

tabstat y if D==1, stat(mean) // promedio del sueldo de las personas que tienen educacion
tabstat y if D==0, stat(mean) // promedio del sueldo de las personas que no tienen educacion

reg y D // regresion por OLS 
