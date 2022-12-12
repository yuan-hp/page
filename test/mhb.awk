#!/usr/bin/awk -f
#-------------------------------------------------------
#	FileName	: mhb.awk
#	Author		：hpy
#	Date		：2021年08月10日
#	Description	：按第一列为ID，ID相同，则没行数据按列合并，可设置
#                 每列合并的操作方式可以设置
#    主要针对 使用分隔符的csv文件!!!
#-------------------------------------------------------

#------------------------------------------------------------------------------
#                               使用说明
#------------------------------------------------------------------------------
# ID : 代表将多少列作为ID列  cat f.txt | ./mhb.awk -v OFS="|" ID=1
# OFS: 代表输出文件的分隔符,默认空格
# FS : 输入文件的分隔符,默认制表符和空格
# BAR: 代表输入文件前BAR行为固定行,合并时忽律,默认为1
# C1~C10:代表1到10列数据合并时采取的合并策略,若是ID列,该设置无效.默认值为逗号连接
#      合并方式
#         .+ : 加法
#         .- : 减法
#         .* : 乘法
#         ./ : 除法
#         .1 : 直接第一个参数
#         .2 : 直接第二个参数
#         其他: 字符串直接连接,C?为连接符     
# 例如 : 
#     指定输出分隔符为 | ,文件前两行为固定行 ,第3列合并时做加法,其他列除ID列外,默认逗号连接
#     cat f.txt  | ./mhb.awk -v OFS="|" BAR=2 C3=".+"
# 特别说明: 需要保证文件内容中不存在分隔符
#-------------------------------------------------------------------------------

# 在BEGIN块配置参数
BEGIN {
    # FS="|"   #指定输入数据分隔符 , 若屏蔽则默认 制表符和空格分割
    # OFS="|"    #输出数据的列分隔符
    
    LEN=0      #合并后的数据行数

    #可配置参数
    ID= ID ? ID : 1      #主键 ID 的列 ，可设置 ，设置第几列为主键 若未使用 -v ID=X 指定则默认为第1列
    BAR= BAR ? BAR : 1   #指定文件前几行不动
    #每列的合并操作方式
    C1=C1 ? C1 : ","
    C2=C2 ? C2 : ","
    C3=C3 ? C3 : ","
    C4=C4 ? C4 : ","
    C5=C5 ? C5 : ","
    C6=C6 ? C6 : ","
    C7=C7 ? C7 : ","
    C8=C8 ? C8 : ","
    C9=C9 ? C9 : ","
    C10=C10 ? C10 : ","
}

##############################################
# 合并数据的操作, 
# @param1:变量a
# @param2:变量b
# @param3:合并方式
#         .+ : 加法
#         .- : 减法
#         .* : 乘法
#         ./ : 除法
#         .1 : 直接第一个参数
#         .2 : 直接第二个参数
#         其他: 字符串直接连接,param3为连接符
##############################################
function pron(a,b,opera) {
    if( opera==".+" ) return a+b
    else if( opera==".-" ) return a-b 
    else if( opera==".*" ) return a*b 
    else if( opera=="./" ) return a/b 
    else if( opera==".1" ) return a 
    else if( opera==".2" ) return b 
    else  return a""opera""b
}

{
    #设置文件前几行不处理,直接修正分隔符后输出
    if(NR<=BAR) { 
        for(jj=1;jj<NF ; jj++)printf("%s%s",$jj,OFS)  #保证生成文件的分隔符统一
        print $NF
        next 
    }

    #ID优先操作
    SIZE = a[$ID,ID] ? SIZE : SIZE + 1   #统计合并后的数据行数
    a[$ID,ID] = $ID  ; b[$ID]     # 生成ID

    #设置每列的合并方式
    for(i=1;i<=NF;i++){
        if( i == ID) continue  #用于跳过ID列处理

        if( i== 1) a[$ID,i]=a[$ID,i] ? pron(a[$ID,i], $i, C1): $i;  #处理第1列  
        else if( i== 2) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C2): $i ;  #处理第2列 
        else if( i== 3) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C3) : $i     ;  #处理第3列  
        else if( i== 4) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C4) : $i     ;  #处理第4列 
        else if( i== 5) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C5) : $i     ;  #处理第5列 
        else if( i== 6) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C6) : $i     ;  #处理第6列 
        else if( i== 7) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C7) : $i     ;  #处理第7列 
        else if( i== 8) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C8) : $i     ;  #处理第8列 
        else if( i== 9) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C9) : $i     ;  #处理第9列 
        else if( i== 10) a[$ID,i]= a[$ID,i] ? pron(a[$ID,i], $i, C10) : $i     ;  #处理第10列 
    }

}
END{
    for(j in b){
        for(k=1;k<NF;k++) {
            printf("%s%s",a[j,k],OFS);
        }
        print a[j,k]  #最后一个主要显示换行
    }
}