msg()
{ 

  while [[ $# > 0 ]]; do
    key="$1"
    shift
    case $key in
        -h|--head )
        local head="true"
        ;;
        -h1|--head1 )
        local head1="$1"
        shift
        ;;
        -h2|--head2 )
        local head2="$1"
        shift
        ;;
        -m|--msg )
        local msg="$1"
        shift
        ;;
        -f|--foot )
        local foot="true"
        ;;
        *)   
        ;;
    esac
  done

  if [ "$head" = "true" ]
  then
      echo -e " " 
      echo -e "*************************** WELLCOME ***************************" 
      echo -e " " 
  fi

  if [ "$head1" ]
  then 
      echo -e " "
      echo -e ">>>              ${head1^^}               <<<"
      echo -e " "
  fi

  if [ "$head2" ]
  then 
      echo -e " "
      echo -e "-----> ${head2}"
  fi

  if [ "$msg" ]
  then 
      echo -e "${msg^}"
  fi

  if [ "$foot" = "true" ]
  then 
      echo -e " "
      echo -e " "
      echo -e "                   ########################"
      echo -e "_______________________________________________________________"
      echo -e " "
  fi
  

    
    
}