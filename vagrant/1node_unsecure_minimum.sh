# Config
export MAPR_VERSION=6.1.0
export MEP_VERSION=6.2.0

# Deploy MapR repo file
cat <<EOF > /etc/yum.repos.d/mapr.repo
[maprtech]
name=MapR Technologies
baseurl=http://package.mapr.com/releases/v$MAPR_VERSION/redhat/
enabled=1
gpgcheck=1
protect=1

[maprecosystem]
name=MapR Technologies
baseurl=http://package.mapr.com/releases/MEP/MEP-$MEP_VERSION/redhat
enabled=1
gpgcheck=1
protect=1
EOF

# Create the mapr user and group
groupadd -g 5000 mapr
useradd -u 5000 -g 5000 mapr
usermod -a -G root mapr
echo -e "mapr\nmapr" | passwd mapr

# Install Open JDK
yum install -y java-1.8.0-openjdk

# Install the mapr gpg key
rpm --import http://package.mapr.com/releases/pub/maprgpg.key

# Install dependencies for MapR NFSv3
yum install -y nfs-utils rpcbind

# Install MapR
yum install -y mapr-core mapr-cldb mapr-zookeeper mapr-nfs mapr-fileserver
systemctl daemon-reload

# Create the /mapr mountpoint
mkdir /mapr
echo "127.0.0.1:/mapr /mapr hard,nolock" > /opt/mapr/conf/mapr_fstab

# Run configure.sh
/opt/mapr/server/configure.sh -C $(hostname) -Z $(hostname) -N demo.mapr.com

# Start MapR
systemctl start rpcbind
systemctl start mapr-zookeeper
systemctl start mapr-warden

