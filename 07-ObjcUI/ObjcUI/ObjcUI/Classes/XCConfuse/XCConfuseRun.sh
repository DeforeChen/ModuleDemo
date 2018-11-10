#!/bin/sh

#  XCConfuseRun.sh
#  ObjcUI
#
#  Created by Alexcai on 2018/11/8.
#  Copyright © 2018 dongjiu. All rights reserved.
#  编译执行脚本文件  Builds Phases  -- > Run Script  -- > 添加此角本的路径信息 $PROJECT_DIR/+ 脚本在项目中的路径
#  以下角本命令会在编译时执行
echo "<<<< XCConfuseRun.sh >>>>"
path=$(pwd)
echo $path
date_01=`date`
echo $date_01
echo "=======ls -l==========="

LS1=`ls -l`
echo $LS1

echo "======================="
echo "$LS1"


#cat ./ObjcUI/Classes/XCConfuse/XCConfuseFunc.plist
#cat ${SRCROOT}/ObjcUI/Classes/XCConfuse/XCConfuseFunc.plist
#echo "=================="
#cat ./ObjcUI/SupportFiles/Info.plist
#echo "=================="

#a=100
#echo $a

#function myTest(){
# 函数内容定义的变量默认是全局变量
#b=23
# 函数内部定义局部变量 需要使用local
#local c=33
#echo $c
# $* 表示所有参数
#echo $*
# $# 表示参数个数
#echo "args count = $#"
# $0 表示当前脚本的文件名
#echo "current fun name $0"
#}
#echo "current script name = $0"
#myTest 'hello' 'good' 'alex'
#echo $b
#echo $c



##  ================ TODO FIXMI
KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

