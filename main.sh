
#!/bin/bash

source control

main() 
{

    if [ "$HELP" = "true" ]
    then
        msg -h
        echo -e "$HELP_MSG"
        msg -f
        exit 0
    fi

    check_op


    IDRAC=($(check_oob idrac))
    ILO=($(check_oob ilo))
    

    if [ "$IDRAC" = "true" ]
    then
        msg -h -h1 "Get info hardware from IDRAC"

        if [ "$OVERALL" = "true" ]
        then
            msg -h2 "OVERALL Info:"
            id_overall

        fi
        
        if [ "$CPU" = "true" ]
        then
            msg -h2 "CPU Info:"
            id_cpu

        fi

        if [ "$RAM" = "true" ]
        then
            msg -h2 "RAM Info:"
            id_ram

        fi

        if [ "$DISK" = "true" ]
        then
            msg -h2 "DISK Info:"
            id_disk

        fi

        if [ "$NIC" = "true" ]
        then
            msg -h2 "NIC Info:"
            id_nic

        fi

    elif [ "$ILO" = "true" ]
    then

        msg -h -h1 "Get info hardware from ILO"

        if [ "$OVERALL" = "true" ]
        then
            msg -h2 "OVERALL Info:"
            ilo_overall

        fi

        if [ "$CPU" = "true" ]
        then
            msg -h2 "CPU Info"
            ilo_cpu

        fi

        if [ "$RAM" = "true" ]
        then
            msg -h2 "RAM Info"
            ilo_ram

        fi

        if [ "$DISK" = "true" ]
        then
            msg -h2 "DISK Info:"
            ilo_disk

        fi

        if [ "$NIC" = "true" ]
        then
            msg -h2 "NIC Info:"
            ilo_nic

        fi

    else
        msg -h1 "Sorry, this version just support for IDRAC or ILO. Please check you the community_name or the ipaddress" 
    fi

    msg -f
}



main