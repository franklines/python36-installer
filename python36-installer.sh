# Author: Franklin E.
# Website: https://frankescobar.com
# Description: This bash script will automate the installation of Python 3.6 on Redhat/CentOS systems.

OSVersion=$(cat /etc/redhat-release | awk '{ print $4}' | cut -d. -f1);

# 0 = regular user, 1 = wheel user, 2 = root user. 
currentPerms=0;

installOnRhel6()
{
    if [ $currentPerms -eq 2 ];
    then
        yum install https://rhel6.iuscommunity.org/ius-release.rpm -y;
        rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY;
        yum install python36u -y;
        yum install python36u-pip -y;
        exit 0;
    elif [ $currentPerms -eq 1 ];
    then
        sudo yum install https://rhel6.iuscommunity.org/ius-release.rpm -y;
        sudo rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY;
        sudo yum install python36u -y;
        sudo yum install python36u-pip -y;
        exit 0;
    else
        echo "User that executed bash script does not have appropriate permissions to run yum or rpm commands.";
        exit 1;
    fi
}

installOnRhel7()
{
    if [ $currentPerms -eq 2 ];
    then
        yum install https://rhel7.iuscommunity.org/ius-release.rpm -y;
        rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY;
        yum install python36u -y;
        yum install python36u-pip -y;
        exit 0;
    elif [ $currentPerms -eq 1 ];
    then
        sudo yum install https://rhel7.iuscommunity.org/ius-release.rpm -y;
        sudo rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY;
        sudo yum install python36u -y;
        sudo yum install python36u-pip -y;
        exit 0;
    else
        echo "User that executed bash script does not have appropriate permissions to run yum or rpm commands.";
        exit 1;
    fi
}

checkUserAccess()
{
    if [ $(whoami) == 'root' ];
    then
        currentPerms=2;
    elif id | grep -o 'wheel' >> /dev/null;
    then
        currentPerms=1;
    else
        currentPerms=0;
    fi

}

checkUserAccess

case "$OSVersion" in

6)  installOnRhel6
    ;;
7)  installOnRhel7
    ;;
*) echo "Unsupported Linux distribution. This bash script only works on Redhat/CentOS 6 and 7."
   ;;
esac
