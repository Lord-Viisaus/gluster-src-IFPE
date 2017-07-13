#removendo o arquivo hostname
rm /etc/hostname
#crinado um arquivo hostname com o testo detro client1
echo client1 >>/etc/hostname

#colocando o ip e nome dos rosts e dominio no arquivo hosts
echo 192.168.0.1 gluster1 >>/etc/hosts
echo 192.168.0.2 gluster2 >>/etc/hosts
echo 192.168.0.10  client1 >>/etc/hosts
echo 192.168.0.11  client2 >>/etc/hosts

echo '\nINTALANDO'
echo ' '

apt update
apt install apt-transport-https
apt update

# Baixando a chave publica do gluster
wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/pub.key | apt-key add -
# Adixionando o repositorio http://.../apt no aquivo gluster.list
echo deb http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/Debian/jessie/apt jessie main > /etc/apt/sources.list.d/gluster.list
apt-get update

# Nas máquinas client1 e client2
apt-get install glusterfs-client -y

#Criando diretório /FilesGluster
mkdir /FilesGluster

#chamando o glsuterfs para montar os diretorios dos gluster1..2 no cliente
mount.glusterfs gluster1:/FilesGluster /FilesGLuster

#montando
mount

#volumes montados
df -h

#coloca esse texto no arquivo fstab para montar automaticamente
echo gluster1:/FilesGluster /FilesGluster glusterfs defaults,_netdev 0 0 >>/etc/fstab

#reiniciando
reboot

df -h

mount
