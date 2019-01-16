function write_parallel(portaddress,mask);
%   Usage of write_parallel()
%   copy inpout32.dll to c:\windows\system32\
%   include parallel_out.dll in matlab path
%   usage(4 forms):
% write_parallel(888,1): portaddress-decimal(888),mask-value to write(1)
% write_parallel('378',1): portaddress-hexadecimal(x378),mask-value to write(1)
% write_parallel(1) : mask-value to write(1) to default address:888
%% write_parallel : default value to write(0) to default address:888

if (nargin == 0)
    portaddress=0378;
    mask=0;
elseif (nargin == 1)
    mask=portaddress;
    portaddress=0378;
elseif (nargin == 2)
    if ischar(portaddress)
        portaddress=hex2dec(portaddress);
    end
end
parallel_out(portaddress,mask);
