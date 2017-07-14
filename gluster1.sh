rm /etc/hostname
echo gluster1 >>/etc/hostname

echo 192.168.0.1 gluster1 >>/etc/hosts
echo 192.168.0.2 gluster2 >>/etc/hosts
echo 192.168.0.10 client1 >>/etc/hosts
echo 192.168.0.11 client2 >>/etc/hosts

echo '***** INSTALANDO *****'
echo ' '

apt update
apt install apt-transport-https

wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/rsa.pub | apt-key add -
echo deb http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/Debian/jessie/apt jessie main > /etc/apt/sources.list.d/gluster.list

apt-get update

apt-get install glusterfs-server -y

mkdir /FilesGluster

#permitindo o gluster2 ser gluster
gluster peer probe gluster2

#status do gluster
gluster peer status

#criando volume no diretorio /F...ter e replicando dando acesso a usar a porta tcp e transferir para o gluster2
gluster volume create /FilesGluster replica 2 transport tcp gluster1:/FilesGLuster gluster2:/FileGluster force

#iniciar volume
gluster volume start /FilesGluster

gluster volume status

# verifica a saida e entrada do glusterfs na rede
netstat -tap | grep glusterfsd

#informação do gluster
gluster volume info

#permitindo determinado ip a acessar o volume
gluster volume set /FilesGLuster auth.allow 192.168.*

gluster volume info
