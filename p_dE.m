function result=p_dE(image,original,type)
    [X_size,Y_size]=size(image(:,:,1));
    dE_max=0;
    dE_p=0;
    dE=0;
    for x=1:X_size
        for y=1:Y_size
            dE_r = double(original(x,y,1) - image(x,y,1));
            dE_g = double(original(x,y,2) - image(x,y,2));
            dE_b = double(original(x,y,3) - image(x,y,3));
            
            dE_p = (dE_r*dE_r) + (dE_g*dE_g) + (dE_b*dE_b);
            dE_p = sqrt(dE_p);
            dE=dE+dE_p;
            if(dE_p>dE_max)
                dE_max=dE_p;
            end
        end
    end
    dE=dE/(X_size*Y_size);
    if(type==1)
        result=dE;
    elseif(type==2)
        result=dE_max;
    end
end
