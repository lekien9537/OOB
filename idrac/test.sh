
#!/bin/bash

#IDRAC Map Values

declare -A idrac=(["check"]="1.3.6.1.4.1.674" ["cpu"]="1.3.6.1.4.1.674.10892.5.4.1100.30.1" ["ram"]="1.3.6.1.4.1.674.10892.5.4.1100.50.1" ["disk"]="1.3.6.1.4.1.674.10892.5.5.1.20.130.4.1" ["raid"]="1.3.6.1.4.1.674.10892.5.5.1.20.140.1.1" ["net"]="1.3.6.1.4.1.674.10892.5.4.1100.90.1")

declare -A id_cpu=(["status"]="5")

declare -A id_cpu_status=(["0"]="CPU_status" ["1"]="other" ["2"]="unknown" ["3"]="ok" ["4"]="nonCritical" ["5"]="critical" ["6"]="nonRecoverable")

get_info()
{

    while [[ $# > 0 ]]; do
        key="$1"
        shift
        case $key in
            -c|--community)
            local community="$1"
            shift
            ;;
            -ip|--ipaddress )
            local ip="$1"
            shift
            ;;
            -oid|--oid )
            local oid="$1"
            shift
            ;;
            -ck|--check )
            local ck="true"
            ;;
            *)   
            ;;
        esac
    done

    local rs="N/A"
    local check=""


    if [ "$ck" = "true" ]
    then

        rs=""
        rs=`snmpwalk -v1 -c $community $ip $oid | head -n 2`
        check=`echo ${rs[@]} | grep "$oid.*="`


        if [ -z "$check" ]
        then
            msg -m "${rs[@]}"
            echo "false"
        else
            echo "true"
        fi

        

    else

        rs=($(snmpwalk -v1 -c $community $ip $oid | cut -d ":" -f 2))

        if [[ ${rs[@]} == *'"'* ]]; then
            IFS=$'\n' read -ra rs <<< "${rs[@]}"
            rs=${rs// /}
            IFS=$'\"' read -ra rs <<< "${rs[@]}"
            
        else
            IFS=$' ' read -ra rs <<< "${rs[@]}"
        fi

        local num=1
        for i in "${!rs[@]}"; do

            local tmp=${rs[$i]}

            if [ "$tmp" = "" ]
            then
                continue
            fi

            if [[ ${#tmp} -lt 3 ]] ; then
                echo -e "${id_cpu_status[0]} (s$num): ${id_cpu_status[$tmp]}"
            else
                echo -e "${id_cpu_status[0]} (s$num): $tmp"
            fi

            num=$((num+1))

        done

        

    fi


}



get_info -c Mi725005d1 -ip 10.70.85.161  -oid ${idrac["cpu"]}.${id_cpu["status"]} 

get_info -c Mi725005d1 -ip 10.70.85.161  -oid 1.3.6.1.4.1.674.10892.5.4.1100.30.1.23.1