function transMat = Match(frameLast,frameCur)
grayFrameLast = rgb2gray(frameLast);
grayFrameCur=rgb2gray(frameCur);

points1 = detectSURFFeatures(grayFrameLast);
points2 = detectSURFFeatures(grayFrameCur); 

[f1, vpts1] = extractFeatures(grayFrameLast, points1);
[f2, vpts2] = extractFeatures(grayFrameCur, points2);

indexPairs = matchFeatures(f1, f2, 'Prenormalized', true, 'MaxRatio', 0.5, 'Unique', true, 'MatchThreshold', 0.5);

matched_pts1 = vpts1(indexPairs(:, 1));
matched_pts2 = vpts2(indexPairs(:, 2));

pts1 = matched_pts1.Location;
pts2 = matched_pts2.Location;

transMat = fitgeotrans(pts1,pts2,'similarity');
end