function MaxAlpha_NonAdaptive()
    clc
    close all
    
    I = imread('lena.bmp');
    W2D = imread('iut5.bmp');
    a1 = 4;
    B1 = 8;
    a2 = 5;
    B2 = 10;
    a3 = 6;
    B3 = 12;
    K = 19;

    non_adaptive_ro = 0:10:200;
    non_adaptive_ro2 = 0:10:200;
    non_adaptive_ro3 = 0:10:200;

    for alpha = 0:10:200
        [Nonadaptive, naSSIM] = embed_proj(I, B1, a1, W2D, K, alpha);   
        [nanc60, nanc80, nanc100] = attack_proj(Nonadaptive, B1, a1, K, W2D);
        na60 = naSSIM*nanc60;
        na80 = naSSIM*nanc80;
        na100 = naSSIM*nanc100;
        non_adaptive_ro(alpha/10+1) = mean([na60 na80 na100]);
        
        [Nonadaptive, naSSIM] = embed_proj(I, B2, a2, W2D, K, alpha);   
        [nanc60, nanc80, nanc100] = attack_proj(Nonadaptive, B2, a2, K, W2D);
        na60 = naSSIM*nanc60;
        na80 = naSSIM*nanc80;
        na100 = naSSIM*nanc100;
        non_adaptive_ro2(alpha/10+1) = mean([na60 na80 na100]);
        
        [Nonadaptive, naSSIM] = embed_proj(I, B3, a3, W2D, K, alpha);   
        [nanc60, nanc80, nanc100] = attack_proj(Nonadaptive, B3, a3, K, W2D);
        na60 = naSSIM*nanc60;
        na80 = naSSIM*nanc80;
        na100 = naSSIM*nanc100;
        non_adaptive_ro3(alpha/10+1) = mean([na60 na80 na100]);
    end

    figure
    hold on
    alphax = 0:10:200;
    h1 = plot(alphax,non_adaptive_ro,'r','LineWidth',2);
    h2 = plot(alphax,non_adaptive_ro2,'b','LineWidth',2);
    h3= plot(alphax,non_adaptive_ro3,'k','LineWidth',2);
    xlabel('\alpha')
    ylabel('\rho = SSIM \times NC')
    [val,I] = max(non_adaptive_ro);
    text(alphax(I),val,...
    ['\bullet \leftarrow \rho_{MAX} = ' num2str(val) ...
     ' at \alpha = ' num2str(alphax(I))])
    
    [val,I] = max(non_adaptive_ro2);
    text(alphax(I),val,...
    ['\bullet \leftarrow \rho_{MAX} = ' num2str(val) ...
     ' at \alpha = ' num2str(alphax(I))])
 
    [val,I] = max(non_adaptive_ro3);
    text(alphax(I),val,...
    ['\bullet \leftarrow \rho_{MAX} = ' num2str(val) ...
     ' at \alpha = ' num2str(alphax(I))])
 
    legend([h1 h2 h3],{'Blocks : 8 \times 8 , a = 4', ...
                       'Blocks : 10 \times 10 , a = 5', ...
                       'Blocks : 12 \times 12 , a = 6'})
    hold off
end