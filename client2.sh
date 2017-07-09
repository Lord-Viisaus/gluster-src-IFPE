echo client1 >>/etc/hostname

echo 192.168.20.1 gluster1 >>/etc/hosts
echo 192.168.20.2 gluster2 >>/etc/hosts
echo 192.168.20.10 client1 >>/etc/hosts
echo 192.168.20.11 client2 >>/etc/hosts

echo '***** INTALANDO ******'
echo ' '

apt update
apt install apt-transport-https

wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/pub.key | apt-key add -
echo deb http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/Debian/jessie/apt jessie main > /etc/apt/sources.list.d/gluster.list
apt-get update

# Nas máquinas client1 e client2
apt-get install glusterfs-client -y

mkdir /files

echo gluster1:/file /glusterfs glusterfs defaults,_netdev,backupvolfile-server=gluster2 0 0 >>/etc/fstab
mount -a
