% ��ȡԴͼ��
sourceImage = imread('sourceImage.jpg');
src_H = size(sourceImage,1);
src_W = size(sourceImage,2);

% ��ȡԴ��Ƶ
readObj = VideoReader('targetVideo.MP4');

% д����Ƶ
writerTrackObj = VideoWriter('Tracking.avi');
writerResObj = VideoWriter('Result.avi');

open(writerTrackObj);
open(writerResObj);

% ��ʼ������
frameIndex = 1;
figure(1);
while hasFrame(readObj)
    % ÿ��һЩ֡��Ҫ�����ֶ���ע�ĸ��ǵ�
    if ((frameIndex==1) || ((frameIndex>=100)&&(mod(frameIndex,30)==0)))
        % ��ȡ��ǰ֡
        frameCur = readFrame(readObj);
        
        % �ֹ�����ĸ��ǵ�
        imshow(frameCur);
        title('�����ε�����ϣ����ϣ����£������ĸ��ǵ�');
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
        
        % �任
        trackFrame = getframe;
        resFrame = Transform(sourceImage,frameCur,BookPoints(:,1),BookPoints(:,2));
        writeVideo(writerTrackObj,trackFrame);
        writeVideo(writerResObj,resFrame);
        
        % ��ʾ��ǽ���
        fprintf('Frame: %d\n', frameIndex);
        
        % ���²���
        frameLast = frameCur;
        frameIndex = frameIndex+1;
    
    % ����Ҫ��ע�ǵ�ʱ
    else
        % ��ȡ��ǰ֡
        frameCur = readFrame(readObj);
        
        % ʹ��SURF�㷨����ƥ�䣬��ñ任����
        transMat = Match(frameLast,frameCur);
        
        % ͨ���任�����ýǵ�Ķ�Ӧ��
        BookPointsTF = BookPoints * transMat.T;
        BookPlotX = [BookPointsTF(:,1);BookPointsTF(1,1)];
        BookPlotY = [BookPointsTF(:,2);BookPointsTF(1,2)];

        % ˢ�½��
        imshow(frameCur);
        axis normal;
        hold on;
        plot(BookPlotX,BookPlotY,'y-','LineWidth',5);
        hold off;

        % �任��������
        trackFrame = getframe;
        resFrame = Transform(sourceImage,frameCur,BookPointsTF(:,1),BookPointsTF(:,2));
        writeVideo(writerTrackObj,trackFrame);
        writeVideo(writerResObj,resFrame);

        % ��ʾ�������
        fprintf('Frame: %d\n', frameIndex);
        
        % ���²���
        BookPoints = BookPointsTF;
        frameLast = frameCur;
        frameIndex = frameIndex+1;
    end
end

% ������Ƶд�룬�رմ���
close(writerTrackObj);
close(writerResObj);
close(figure(1));