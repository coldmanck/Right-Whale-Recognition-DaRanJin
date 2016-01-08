#!/bin/sh

#----------------------------------------------------
#文件存放形式為
#	dir/subdir1/files...
#	dir/subdir2/files...
#	dir/subdir3/files...
#	dir/subdirX/files...

#用法：
#1.$ sh mklabel.sh dir startlabel ;dir 為目標文件夾名稱
#2.$ chmod a+x mklabel.sh ；然後可以直接用文件名運行
#3.默認label信息顯示在終端，請使用轉向符'>'生成文本，例：
#		$ sh ./mklabel.sh  data/faces94/male  > label.txt
#4.確保文件夾下除了圖片不含其他文件(若含有則需自行添加判斷語句)
#-----------------------------------------------------

#DIR=~/codes/mklabel.sh		#命令位置（無用）
DIR=~/kaggle/mklabel.sh
label=1					#label起始編號(為數字，根據自己需要修改)
testnum=0				#保留的測試集大小

if test $# -eq 0;then	#無參數，默認為當前文件夾下，label=1
	$DIR . 0 $label
else
	if test $# -eq 1;then	#僅有位置參數，默認testnum=0,label=1
		$DIR $1 0 $label
	else
		if test $# -eq 2;then	#兩個參數時,label=1
			$DIR $1 $2 $label
		else
			testnum=$2			#每個類別保留測試集大小
			label=$3			#自定義label起始
			
			cd $1				#轉到目標文件夾
		
			if test $testnum -ne 0;then
				mkdir "testdata"	#建立測試集
			fi
		
			for i in * ; do
				exist=`expr "$i" != "testdata"`
				if test -d $i && test $exist -eq 1;then	#文件夾存在
					#echo 
					#echo 'DIR:' $i
				
					cd $i			#進入文件夾
						num=1		#圖片數目
						for j in *
						do
							if test $num -gt $testnum;then
								echo  $j  $label
								mv $j ../
							fi
							num=`expr $num + 1`
						done
					cd ..			#回到上層目錄
				
					if test $testnum -eq 0;then
						rmdir $i
					else
						mv $i ./testdata
					fi
				
					label=`expr $label + 1`
									#計算label
				fi	
			done
		fi
	fi
fi
