function result = p_mse(image, original)
    [M,N]=size(image(:,:,1));
    image=double(image);
    original=double(original);
    result=0;
    for i=1:M
        for j=1:N
            for k=1:3
            result=result + (original(i,j,k)-image(i,j,k))^2;
            end
        end
    end
    result=result*(1/(3*M*N));
end