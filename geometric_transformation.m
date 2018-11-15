function return_value = geometric_transformation(gameNr, roundNr, corners)
    f = filename(gameNr, roundNr);
    
    return_value = corners;
    
    img = im2double(imread(['assets/threshold/T' f]));
    name = 'check2';
    msgid = 'Images:initSize:adjustingMag';
    warning('off',msgid);
    imshow(img);
    
    %[c r p] = impixel;
    c = [ 476 2444 2668 308 ]';
    r = [ 808  724  2816 2832 ]';
    base = [0 11; 11 11; 11 0; 0 0];
    tf = fitgeotrans([c r],base*80,'projective');
    disp('tf = ');
    disp(tf)
    
    T = tf.T;
    disp('T =');
    format short g
    disp(T);
    format

    imshow(img);
    hold on;
    plot([c;c(1)],[r;r(1)],'r','Linewidth',2);
    text(c(1),r(1)-80,'0, 11','Color','y');
    text(c(2),r(2)-80,'11, 11','Color','y');
    text(c(3),r(3)+80,'11, 0','Color','y');
    text(c(4),r(4)+80,'0, 0','Color','y');
    hold off;
    F = getframe();
    g = frame2im(F);
    imwrite(g, fullfile('assets/geometric_transformation/', ['overlay_', f]));

    [xf1, xf1_ref] = imwarp(img,tf);
    imshow(xf1)
    xf1_ref
    imwrite(xf1, fullfile('assets/geometric_transformation/', ['registered_', f]));

    bdi = [1 1; 1280 1; 1280 960; 1 960];
    fill(bdi(:,1),bdi(:,2),'b');
    axis ij;
    hold on
    fill(c,r,'r');
    hold off
    axis equal

    % show the transformed simplified image
    rd = transformPointsForward(tf,[c r]);
    bds = transformPointsForward(tf,bdi);
    fill(bds(:,1),bds(:,2),'b')
    axis ij
    hold on
    fill(rd(:,1),rd(:,2),'r')
    axis equal
    hold off

    % show that the control points map to the target points
    prd = [c r ones(4,1)]*T;
    % B = repmat(A,M,N) creates a large matrix B consisting of an M-by-N
    %     tiling of copies of A.
    %  This is used to produce two copies of the the third, homogeneous
    %  variable. The end result is to convert homogeneous to normal variables.
    uv = prd(:,1:2)./repmat(prd(:,3),1,2);
    disp('uv/80 = ');
    disp(uv/80)

    xf1_ref.XWorldLimits = [-500 1500];
    xf1_ref.YWorldLimits = [-800 1200];
    xf1_ref.ImageSize = [2000 2000];
    [xf2 xf2_ref] = imwarp(img,tf,'OutputView',xf1_ref);
    xf2_ref
    imshow(xf2)
    imwrite(xf2, fullfile('assets/geometric_transformation/', ['truncated_', f]));
    warning('on',msgid);
end