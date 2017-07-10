echo gluster1 >>/etc/hostname

echo 192.168.20.1 gluster1 >>/etc/hosts
echo 192.168.20.2 gluster2 >>/etc/hosts
echo 192.168.20.10 client1 >>/etc/hosts
echo 192.168.20.11 client2 >>/etc/hosts

echo '***** INTALANDO *****'
echo ' '

apt update
apt install apt-transport-https

wget -O - http://download.gluster.org/pub/gluster/glusterfs/LATEST/rsa.pub | sudo apt-key add -
echo deb https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/$(lsb_release -sc)/apt $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/gluster.list

apt-get update

apt-get install glusterfs-server -y

mkdir /FilesGluster

gluster peer probe gluster2

service glusterfs-server status

gluster peer status

gluster volume create file replica 2 transport tcp gluster1:/FilesGluster gluster2:/FilesGluster force

gluster volume start file

gluster volume status



