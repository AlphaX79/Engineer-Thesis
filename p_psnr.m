function result = p_psnr(image,original);
    max=255;
    mse=p_mse(image,original);
    result = 10*log10((max*max)/mse);
end
