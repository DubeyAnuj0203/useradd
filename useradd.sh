#!/bin/bash
check='\033[0;36m'
checkcomp='\033[1;36m'
red='\033[1;31m'
green='\033[1;32m'
endcolor='\033[0m'
Yellow='\033[1;33m'

function file_user_check(){
        passwd='your-passwd'
        userfile="/root/userfile"
        echo -e "${check}checking userfile in current directory."
        if [ -e $userfile ];then
                sleep 1
                echo -e "${checkcomp}userfile found"

                sleep 1
                for user in $(cat $userfile)
                do
                        id $user >/dev/null 2>&1
                        if [ $? -eq 0 ];then
                                echo -e "${green}$user\t:Present"
                                echo "------"
                        else
                                echo -e "${Yellow}$user\t:Not-Present..adding $user in system ${endcolor}"
                                useradd $user
                                if [ $? -eq 0 ];then
                                        echo -e "${green}$user \t:Added${endcolor}"
                                        echo "$user:$passwd"|chpasswd
                                        echo "-------"
                                else
                                        echo -e "${red}can't add $user maybe already is in system${endcolor}"
                                fi
                                sleep 2
                        fi
                        sleep 2
                done
        else
                echo -e "${red}userfile not found!"
        fi
}
file_user_check
