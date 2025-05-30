# Inventario máquina Windows

---

> **Notas previas:**  

> Se debe tener la máquina con la red en privado y no en público, se debe cambiar.

> Este ejemplo usa autenticación básica y conexiones no cifradas, que **no es seguro para entornos de producción**. Para producción, debes usar HTTPS y autenticación cifrada.

---

# 1. Habilitar WinRM en la máquina Windows

Puedes ejecutar este script en **PowerShell** como administrador en la máquina Windows:

````markdown
# Habilita WinRM y configura la autenticación básica (sólo para pruebas/lab)
winrm quickconfig -force
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Permite conexiones desde cualquier IP (ajusta según tus necesidades)
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Abre el puerto 5985 en el firewall (HTTP)
netsh advfirewall firewall add rule name="WinRM HTTP" dir=in action=allow protocol=TCP localport=5985

# Crea regla del Firewall para el puerto 5985 (HTTP)
New-NetFirewallRule -Name "WinRM HTTP" -DisplayName "WinRM HTTP" -Enabled True -Direction Inbound -Protocol TCP -Localport 5985 -Action Allow
````
---

# 2. Crear un usuario administrador o usar uno existente

Asegúrate de tener un usuario con privilegios de administrador en la máquina Windows.  
Recuerda la contraseña, la necesitarás para la conexión.

---

# 3. Ejemplo de inventario Ansible para Windows

Tu archivo `hosts` (inventario) podría verse así:

````markdown
[windows]
mi_windows_server ansible_host=192.168.1.100

[windows:vars]
ansible_user=Administrador
ansible_password=TuContraseña
ansible_port=5985
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
````

---

# 4. Ejemplo de playbook Ansible para Windows

Aquí tienes un playbook sencillo para probar la conexión:

````markdown
---																																						
- name: Prueba de conexión a Windows
  hosts: windows
  tasks:
    - name: Hacer ping a la máquina Windows
      ansible.windows.win_ping:
````