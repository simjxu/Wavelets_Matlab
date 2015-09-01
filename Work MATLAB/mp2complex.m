function cmplx = mp2complex(mag,phase)

phase = phase*pi/180;

for k = 1:length(mag)
    cmplx(k) = mag(k)*exp(phase(k)*1i);
end