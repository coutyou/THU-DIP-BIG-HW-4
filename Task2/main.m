% 读取源图像
sourceImage = imread('sourceImage.jpg');
src_H = size(sourceImage,1);
src_W = size(sourceImage,2);

% 读取源视频
readObj = VideoReader('targetVideo.MP4');

% 写入视频
writerTrackObj = VideoWriter('Tracking.avi');
writerResObj = VideoWriter('Result.avi');

open(writerTrackObj);
open(writerResObj);

% 初始化参数
frameIndex = 1;
figure(1);
while hasFrame(readObj)
    % 每隔一些帧需要重新手动标注四个角点
    if ((frameIndex==1) || ((frameIndex>=100)&&(mod(frameIndex,30)==0)))
        % 读取当前帧
        frameCur = readFrame(readObj);
        
        % 手工标记四个角点
        imshow(frameCur);
        title('请依次点击左上，右上，左下，右下四个角点');
        axis normal;
        hold on;
        
        [BookX,BookY] = ginput(4);
        BookX([2, 3], :) = BookX([3, 2], :);
        BookX([3, 4], :) = BookX([4, 3], :);
        BookY([2, 3], :) = BookY([3, 2], :);
        BookY([3, 4], :) = BookY([4, 3], :);
        BookPoints = [BookX,BookY,ones(4,1)];
        BookPlotX = [BookPoints(:,1);BookPoints(1,1)];
        BookPlotY = [BookPoints(:,2);BookPoints(1,2)];
        
        plot(BookPlotX,BookPlotY,'y-','LineWidth',5);
        hold off;
        
        % 变换
        trackFrame = getframe;
        resFrame = Transform(sourceImage,frameCur,BookPoints(:,1),BookPoints(:,2));
        writeVideo(writerTrackObj,trackFrame);
        writeVideo(writerResObj,resFrame);
        
        % 显示标记进度
        fprintf('Frame: %d\n', frameIndex);
        
        % 更新参数
        frameLast = frameCur;
        frameIndex = frameIndex+1;
    
    % 不需要标注角点时
    else
        % 读取当前帧
        frameCur = readFrame(readObj);
        
        % 使用SURF算法进行匹配，获得变换矩阵
        transMat = Match(frameLast,frameCur);
        
        % 通过变换矩阵获得角点的对应点
        BookPointsTF = BookPoints * transMat.T;
        BookPlotX = [BookPointsTF(:,1);BookPointsTF(1,1)];
        BookPlotY = [BookPointsTF(:,2);BookPointsTF(1,2)];

        % 刷新结果
        imshow(frameCur);
        axis normal;
        hold on;
        plot(BookPlotX,BookPlotY,'y-','LineWidth',5);
        hold off;

        % 变换并保存结果
        trackFrame = getframe;
        resFrame = Transform(sourceImage,frameCur,BookPointsTF(:,1),BookPointsTF(:,2));
        writeVideo(writerTrackObj,trackFrame);
        writeVideo(writerResObj,resFrame);

        % 显示处理进度
        fprintf('Frame: %d\n', frameIndex);
        
        % 更新参数
        BookPoints = BookPointsTF;
        frameLast = frameCur;
        frameIndex = frameIndex+1;
    end
end

% 结束视频写入，关闭窗口
close(writerTrackObj);
close(writerResObj);
close(figure(1));