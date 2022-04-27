echo "Welcome to my dope SSH server setup script!"

#Generate SSH Key
echo "Enter a name for the key file"
read keyName
identityFileLocation=$HOME/.ssh/$keyName
ssh-keygen -t rsa -N "" -f $identityFileLocation

#get remote host info
echo "Enter the Username for the remote host"
read remoteUser
echo "Enter the IP Address for the remote host"
read remoteIpAddress


cat $HOME/.ssh/$keyName.pub | ssh $remoteUser@$remoteIpAddress "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

question="What port would you configure the remote server to use? "
verify="" #loop will run at least once
while [[ $verify != 'yes' ]] && [[ $verify != 'y' ]] # While input isn't correct ask again
do
    read -p "$question" remotePort # Ask the user to enter a string
    read -p "Did you type it right? [yes, y] to continue " verify
    echo $verify
done



echo "disabling password login"
echo "Setting remote port to $remotePort"



#-t option uses tty which allows sudo, "| sudo tee -a" substitutes ">>" as the latter can't be used with sudo
ssh -t $remoteUser@$remoteIpAddress "echo PasswordAuthentication no | sudo tee -a /etc/ssh/sshd_config && echo Port $remotePort | sudo tee -a /etc/ssh/sshd_config 
&& echo ChallengeResponseAuthentication no | sudo tee -a /etc/ssh/sshd_config && sudo systemctl restart sshd"

echo the below ssh login attempts will fail if password login is disabled
ssh $remoteUser@$remoteIpAddress "echo WARNING the script faile to disable password login"
ssh -p $remotePort $remoteUser@$remoteIpAddress "echo WARNING the script failed to disable password login"


echo "Setting up local config file"
configFile="$HOME/.ssh/config"
echo "" >> $configFile #empty space
echo "Host $keyName $remoteIpAddress" >> $configFile
echo "\tHostName $remoteIpAddress" >> $configFile
echo "\tPort $remotePort" >> $configFile
echo "\tIdentityFile $identityFileLocation" >> $configFile
echo "\tUser $remoteUser" >> $configFile
echo "" >> $configFile #empty space

ssh $keyName "echo ssh key authentication is successful"

