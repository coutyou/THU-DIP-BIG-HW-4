function out = Filter(img,filter_num)
    if filter_num == 1
        out = Filter_Oil(img);
    end
    if filter_num == 2
        out = Filter_Wall(img);
    end
    if filter_num == 3
        out = Filter_Glass(img);
    end
    if filter_num == 4
        out = Filter_BW(img);
    end
    if filter_num == 5
        out = Filter_Plain(img);
    end
    if filter_num == 6
        out = Filter_Old(img);
    end
end