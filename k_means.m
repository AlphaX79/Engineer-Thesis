function [result, it_count] = k_means(image, k)
    image=double(image);
    k_centers(k,3)=0; % k_centers(index)=[r g b]
    [X_size, Y_size,~]=size(image);
    result=uint8(zeros(X_size,Y_size,3));
    im_range(3,2)=0;
    it_count=0;
    for i=1:3
        im_range(i,1)=min(min(image(:,:,i)));
        im_range(i,2)=max(max(image(:,:,i)));
    end

    %random start for the program
    for i=1:k
        for j=1:3
            k_centers(i,j)=randi([im_range(j,1) im_range(j,2)]);
        end
    end
    pix_assignment(X_size,Y_size)=0;
    k_centers_old=k_centers+1;

    %main loop
    while(~isequal(k_centers_old, k_centers) && it_count<2000)  
        sums=zeros(k,3);
        counters=zeros(k,1);
        k_centers_old=k_centers;
        prev_dist=0;
        for x=1:X_size
            for y=1:Y_size
                %Assigning pixels to the centers        
                for i=1:k
                    %distance (no sqrt)
                    r_dist=abs(image(x,y,1)-k_centers(i,1));
                    g_dist=abs(image(x,y,2)-k_centers(i,2));
                    b_dist=abs(image(x,y,3)-k_centers(i,3));
                    pix_dist=r_dist * r_dist + g_dist * g_dist + b_dist * b_dist;
                    if(i==1)
                        prev_dist=pix_dist;
                        pix_assignment(x,y)=i;
                    elseif(pix_dist<=prev_dist)
                        pix_assignment(x,y)=i;
                        prev_dist=pix_dist;
                    end
                end
            end
        end
        %Counting new centers
        for x=1:X_size
            for y=1:Y_size
                for i=1:3
                    sums(pix_assignment(x,y),i) = sums(pix_assignment(x,y),i) + image(x,y,i);
                end
                counters(pix_assignment(x,y))=counters(pix_assignment(x,y))+1;
            end
        end
        for i=1:k
            if(sums(i,1)~=0)
                sums(i,1)=sums(i,1)/counters(i);
                sums(i,2)=sums(i,2)/counters(i);
                sums(i,3)=sums(i,3)/counters(i);   
            end
        end
        for i=1:k
            for j=1:3
                k_centers(i,j)=sums(i,j);
            end
        end
        it_count=it_count+1;
    end
    %displaying     
    for x=1:X_size
        for y=1:Y_size
            for i=1:k
                if(pix_assignment(x,y)==i)
                    result(x,y,1)=uint8(k_centers(i,1));
                    result(x,y,2)=uint8(k_centers(i,2));
                    result(x,y,3)=uint8(k_centers(i,3));
                end
            end
        end
    end
end