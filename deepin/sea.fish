#UFUNCTION=直接打开百度搜索关键字
function sea 
    if test $argv[1] = "-help"
        echo "  Usage: serach key"
        echo "  search -help        显示帮助"
        echo "  search key          百度搜索关键字key"
        return
    end
    open "https://www.baidu.com/s?wd=$argv"
end
