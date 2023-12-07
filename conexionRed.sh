# script conexionRed.sh 
Este script permite realizar conexiones de red, se debe de ejecutar son sudo, ya que se realiza la
actalización de los repositorios y la inStalacion de los
servicios necesarios: wireless-tools rfkill wpasupplicant
wireless-tools: proporciona herramientas básicas para la configuración de 
redes inalámbricas en nuestro sistema linux. Incluye utilidades como iwconfig 
y iwlist que permiten visualizar y configurar parámetros de interfaces inalámbrica
rfkill: Es una herramienta que permite habilitar o deshabilitar dispositivos inalámbricos.
wpasupplicant: Es un programa que implementa el estándar WPA (Wi-Fi Protected Access) y
el estándar IEEE 802.1X para la autenticación en redes inalámbricas. 

##Opciones del menú:
opción1: lista las interfaces del equipo
opción2: relaiza una conexión dinamica a la interfaz de ethernet
opción3:  permite asignar estáticamente una ip, se debe de introducir el nombre de la interfaz, la ip 
estatica y el gateway
opción4:muestra las redes inalambricas cercanas y el tipo de encriptación con la que cuentas
Para ejecutar la opcion 5 de wps es verificar si el router cuenta con la opción WPS,un botón físico que, al presionar,
activa WPS y permite a los dispositivos conectarse sin necesidad de introducir una contraseña
opción5: esta opción se divide en dos si el router cuenta con la opción WPS o realizar la conexión de forma
estaticá en la interfaz inalambrica, datos que se solicitan:
    ip estática, gateway y mascara de red
opción6: con esta opcion se realiza una conexión a una red con wpa, se debe introducir el nombre de la interfaz,
el ESSID es decir el nombre de la red a la cual deseamos conectarnos, 'PSK' es el password, 
al tener estos datos el script levanta la interfaz, y se generar una configuración segura para 
WPA o WPA2 a partir del nombre de la red y la contraseña proporcionada.
