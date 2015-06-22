yum makecache
yum install -y gcc python-devel python-virtualenv libselinux-python
easy_install pip

cd /tmp
virtualenv env --system-site-packages
env/bin/pip install -r /vagrant/requirements.txt
source env/bin/activate

cd /vagrant

if [ ! -f /vagrant/security.yml ]; then
  ./security-setup --enable=false
fi

hostname default

# Hack to make ansible use the right iface for ansible_default_ipv4.address
# In vagrant, this should be the third interface after loopback and nat.
ip route add 8.8.8.8/32 via `hostname -I | cut -d ' ' -f 2` dev `ip link | grep '^3: ' | cut -d ':' -f 2`
ansible-playbook vagrant.yml -e @security.yml -i /vagrant/vagrant/vagrant-inventory
