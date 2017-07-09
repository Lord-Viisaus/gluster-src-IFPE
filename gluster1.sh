echo gluster1 >>/etc/hostname

echo 192.168.20.1 gluster1 >>/etc/hosts
echo 192.168.20.2 gluster2 >>/etc/hosts
echo 192.168.20.10 client1 >>/etc/hosts
echo 192.168.20.11 client2 >>/etc/hosts

echo '***** INTALANDO *****'
echo ' '

wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/pub.key | apt-key add -
echo deb http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/Debian/jessie/apt jessie main > /etc/apt/sources.list.d/gluster.list
apt-get update

apt-get install glusterfs-server -y

gluster peer probe gluster2

service glusterfs-server status

gluster peer status

gluster volume create file replica 2 transport tcp gluster1:/FilesGluster gluster2:/FilesGluster force

gluster volume start file

gluster volume status



