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

gluster peer probe gluster2

gluster peer status

gluster volume create /FilesGluster replica 2 transport tcp server1:/FilesGLuster server2.example.com:/FileGluster force

gluster volume start /FilesGluster

gluster volume status

netstat -tap | grep glusterfsd

gluster volume info

gluster volume set /FilesGLuster auth.allow 192.168.*

gluster volume info
