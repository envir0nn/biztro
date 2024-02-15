NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#= " "/usr/local/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "${RB}========================================================${NC}"
echo -e "                 ${WB}Delete Vless Account${NC}               "
echo -e "${RB}========================================================${NC}"
echo -e "  ${YB}You have no existing clients!${NC}"
echo -e "${RB}========================================================${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
vless
fi
clear
echo -e "${RB}========================================================${NC}"
echo -e "                 Delete Vless Account               "
echo -e "${RB}========================================================${NC}"
echo -e " ${YB}User  Expired${NC}  "
echo -e "${RB}========================================================${NC}"
grep -E "^#= " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${YB}tap enter to go back${NC}"
echo -e "${RB}========================================================${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
vless
else
exp=$(grep -wE "^#= $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#= $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -rf /var/www/html/vless/vless-$user.txt
rm -rf /user/log-vless-$user.txt
systemctl restart xray
clear
echo -e "${RB}========================================================${NC}"
echo -e "            ${WB}Vless Account Success Deleted${NC}           "
echo -e "${RB}========================================================${NC}"
echo -e " ${YB}Client Name :${NC} $user"
echo -e " ${YB}Expired On  :${NC} $exp"
echo -e "${RB}========================================================${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
vless
fi
