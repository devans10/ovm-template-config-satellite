#!/usr/bin/env bash

file="/root/bootstrap.properties"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "${key}='${value}'"
  done < "$file"

  cmd="/root/bootstrap.py"
  if [ -v ${com_oracle_linux_satellite_server} ]; then
    cmd="${cmd} -s ${com_oracle_linux_satellite_server}"
  fi
  if [ -v ${com_oracle_linux_satellite_login} ]; then
    cmd="${cmd} -l ${com_oracle_linux_satellite}"
  fi
  if [ -v ${com_oracle_linux_satellite_password} ]; then
    cmd="${cmd} -p ${com_oracle_linux_satellite_password}"
  fi
  if [ -v ${com_oracle_linux_satellite_activationkey} ]; then
    cmd="${cmd} -a ${com_oracle_linux_satellite_activationkey}"
  fi
  if [ -v ${com_oracle_linux_satellite_skippuppet} ]; then
    if [ ${com_oracle_linux_satellite_skippuppet} == "True" ]; then
      cmd="${cmd} -P"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_skipforeman} ]; then
    if [ ${com_oracle_linux_satellite_skipforeman} == "True" ]; then
      cmd="${cmd} --skip-foreman"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_group} ]; then
    cmd="${cmd} -g ${com_oracle_linux_satellite_group}"
  fi
  if [ -v ${com_oracle_linux_satellite_location} ]; then
    cmd="${cmd} -L ${com_oracle_linux_satellite_location}"
  fi
  if [ -v ${com_oracle_linux_satellite_operatingsystem} ]; then
    cmd="${cmd} -O ${com_oracle_linux_satellite_operatingsystem}"
  fi
  if [ -v ${com_oracle_linux_satellite_partitiontable} ]; then
    cmd="${cmd} --partitiontable=${com_oracle_linux_satellite_partitiontable}"
  fi
  if [ -v ${com_oracle_linux_satellite_organization} ]; then
    cmd="${cmd} -o ${com_oracle_linux_satellite_organization}"
  fi
  if [ -v ${com_oracle_linux_satellite_args} ]; then
    cmd="${cmd} -S ${com_oracle_linux_satellite_args}"
  fi
  if [ -v ${com_oracle_linux_satellite_update} ]; then
    if [ ${com_oracle_linux_satellite_update} == "True" ]; then
      cmd="${cmd} -u"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_force} ]; then
    if [ ${com_oracle_linux_satellite_force} == "True" ]; then
      cmd="${cmd} -f"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_add_domain} ]; then
    if [ ${com_oracle_linux_satellite_add_domain} == "True" ]; then
      cmd="${cmd} --add-domain"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_release} ]; then
    cmd="${cmd} -r ${com_oracle_linux_satellite_release}"
  fi
  if [ -v ${com_oracle_linux_satellite_unmanaged} ]; then
    if [ ${com_oracle_linux_satellite_unmanaged} == "True" ]; then
      cmd="${cmd} --unmanaged"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_rex} ]; then
    if [ ${com_oracle_linux_satellite_rex} == "True" ]; then
      cmd="${cmd} --rex"
    fi
  fi
  if [ -v ${com_oracle_linux_satellite_rex_user} ]; then
    cmd="${cmd} --rex-user=${com_oracle_linux_satellite_rex_user}"
  fi
  if [ -v ${com_oracle_linux_satellite_enablerepos} ]; then
    cmd="${cmd} --enablerepos=${com_oracle_linux_satellite_enablerepos}"
  fi

  $(cmd)
  ret_code=$?
  if [ $ret_code == 0 ]; the
    rm -f $file
  fi

else
  exit(0)
fi
