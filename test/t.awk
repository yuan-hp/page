#!/usr/bin/awk -f 
#UFUNCTION=最小二乘法拟合一次函数

# Use: mfit filename 
BEGIN{
	mean_x = 0
	mean_y = 0 
	len = 0
	idx = 0
}

{
	if ( ($1 ~ /^[-0-9.]/) && ($2 ~ /^[-0-9.]/)) {
		x[idx] = $1
		y[idx] = $2
		mean_x = mean_x + $1 
		mean_y = mean_y + $2
		idx = idx +1
	}
}

END{
	len = idx 
	#求平均值
	mean_x = mean_x/len 
	mean_y = mean_y/len 
	num1 = 0
	num2 = 0
	for (i=0;i<len;i=i+1){
		num1 = num1 + (x[i] - mean_x) * (y[i] - mean_y)
		num2 = num2 + (x[i] - mean_x) * (x[i] - mean_x)
	}
	b = num1/num2 
	a = mean_y - b*mean_x 
	print "y=",b,"*x+",a

}
