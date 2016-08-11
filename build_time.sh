#!/bin/sh
#generate random values
function random()
{
  min=$1;
  max=$2
  randomval=$((RANDOM%$max+$min))
  echo $randomval
}

#generate time values
function build_conn_time()
{
  rm -rf ./output.log
  touch ./output.log
  cat /dev/null > ./output.log

  tflag=0
  nextsecond=0
  while :
  do
  if [[ $tflag -eq 0 ]];then
  tcurtime=`date "+%F %T"`
  echo "xtcurtime="$tcurtime
  tflag=1
  else
  #时间戳转化为时间
  tcurtime=`date -d @$nextsecond "+%F %T"`
  echo "next tcurtime="$tcurtime
  fi

  #时间格式化 为时间戳
  scurtime=`date -d "$tcurtime" +%s`

  #产生2-50之间的随机数
  cyccnt=$(random 2 50);
  if [[ -z $cyccnt ]]; then
  cyccnt=10
  fi
  echo "cyccnt="$cyccnt
  i=0
  while (( $i<$cyccnt))
  do
  echo $tcurtime >> output.log
  i=$(($i+1))
  done

  #更新下一秒 ，时间戳可以求和操作
  nextsecond=$(($scurtime+1))
  sleep 1
  done
}

build_conn_time;
