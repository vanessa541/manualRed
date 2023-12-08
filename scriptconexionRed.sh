#!/usr/bin/env bash

# instalacion de programas necesarios
sudo apt-get update
sudo apt-get install -y wireless-tools rfkill wpasupplicant

#listar interfaces de red
listar_interfaces() {
    echo "Interfaces de red disponibles:"
    ip link show
}

# conectarse a una red cableada de forma dinámica
conectar_cableada_dinamica() {
	echo "Introduce el nombre de la interfaz (eje: eth0):"
    read interfaz
    echo "Conectándose a una red cableada de forma dinámica..."
    dhclient $interfaz
}

# conectarse a una red cableada de forma estática
conectar_cableada_estatica() {
    # Configurar manualmente la interfaz y la dirección IP
    echo "Introduce el nombre de la interfaz (eje: eth0):"
    read interfaz
    echo "Introduce la dirección IP estática (eje: 192.168.1.2):"
    read ip_estatica

    ip addr add $ip_estatica dev $interfaz
    # config puerta de enlace predeterminada
     echo "Introduce la puerta de enlace predeterminada (eje: 192.168.1.1):"
     read gateway
     ip route add $gateway via $interfaz
}

# listar redes inalámbricas cercanas y su tipo de cifrado
listar_redes_inalambricas() {
    echo "Redes inalámbricas cercanas:"
    iwlist scan | grep -E "ESSID|Encryption|WPA2|WPA"
}

# conectarse a una red inalámbrica de forma dinámica o estática
conectar_inalambrica() {
    echo "Introduce el nombre de la interfaz inalámbrica (eje: wlan0):"
    read interfaz_inalambrica

    echo "¿Deseas configurar la conexión de forma wps o estática? (w/e)"
    read tipo_conexion

    if [ "$tipo_conexion" == "w" ]; then
	     # Asegúrate de que la interfaz esté activada
	     ifconfig $interfaz_inalambrica up
	echo "Recuerda que el router debe tener la funcion WPS."
	  echo "Conectándose mediante WPS..."
        wpa_cli -i $interfaz_inalambrica wps_pbc
	     
    elif [ "$tipo_conexion" == "e" ]; then
        echo "Introduce la dirección IP estática (eje: 192.168.1.2):"
        read ip_estatica
        echo "Introduce la puerta de enlace (eje: 192.168.1.1):"
        read puerta_enlace
        echo "Introduce la máscara de red (eje:24):"
        read mascara_red

        ip addr add $ip_estatica/$mascara_red dev $interfaz_inalambrica
        ip route add default via $puerta_enlace
    else
        echo "Opción no válida. Saliendo..."
        exit 1
    fi
}

# conectarse a una red inalámbrica con WPS
conectar_wpa() {
    echo "Introduce el nombre de la interfaz inalámbrica (eje: wlan0):"
    read interfaz_inalambrica
    echo "Introduce el nombre de la red (eSSID):"
    read essid
    echo "Introduce la contraseña (PSK):"
    read psk
		ifconfig $interfaz_inalambrica up
	wpa_passphrase "$essid" "$psk" > "$essid".conf
  
    #conectar utilizando wpa_supplicant
   wpa_supplicant -B -D wext -i $interfaz_inalambrica -c "$essid".conf

     dhclient $interfaz_inalambrica -v
    echo "Conexión exitosa."
}


# Menú principal
while true; do
    echo "----------- MENU -----------"
    echo "1. Listar interfaces de red"
    echo "2. Conectar a red cableada dinámica"
    echo "3. Conectar a red cableada estática"
    echo "4. Listar redes inalámbricas y cifrado"
    echo "5. Conectar a red inalámbrica"
    echo "6. Conectar a red inalámbrica con WPA"
    echo "7. Salir"
    echo "---------------------------"

    read opcion

    case $opcion in
        1) listar_interfaces ;;
        2) conectar_cableada_dinamica ;;
        3) conectar_cableada_estatica ;;
        4) listar_redes_inalambricas ;;
        5) conectar_inalambrica ;;
        6) conectar_wpa ;;
        7) echo "Saliendo..."; exit ;;
        *) echo "Opción no válida";;
    esac
done
