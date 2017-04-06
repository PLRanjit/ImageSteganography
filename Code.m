/////loading encrypted image////////////////////////


global encrypted_image backup_encrypted_image
[path,user_canc]=imgetfile();
if user_canc
    msgbox('ERROR','Error','Error');
    return
end
encrypted_image=imread(path);
backup_encrypted_image = encrypted_image;
axes(handles.axes4);
imshow(encrypted_image);


////////////////////saving decrypted image///////////////////


global rs
axes(handles.axes5);
[FileName, PathName] = uiputfile('*.bmp', 'Save As');
Name = fullfile(PathName, FileName);
imwrite(rs, Name, 'bmp');


/////////////////carrier image.//////////////

global carrier_image backup_image
[path,user_canc]=imgetfile();
if user_canc
    msgbox('ERROR','Error','Error');
    return
end
carrier_image=imread(path);
backup_image = carrier_image;
axes(handles.axes1);
imshow(carrier_image);

/////////////////////////message image/////////////////
global message_image backup_message_image
[path,user_canc]=imgetfile();
if user_canc
    msgbox('ERROR','Error','Error');
    return
end
message_image=imread(path);
backup_message_image = message_image;
axes(handles.axes2);
imshow(message_image);

//////////////////////////////encrypting code////////////
global message_image carrier_image
y=rgb2gray(message_image);
global r c
[r1 c1 b1]=size(carrier_image);
[r c b]=size(y);
y=imresize(y,[r1 c1]);

[r c b]=size(y);
for i=1:r
    for j=1:c
       
    nc(i,j)=bitand(carrier_image(i,j),254);
    s(i,j)=bitand(y(i,j),128);
    f(i,j)=s(i,j)/128;
    ns(i,j)=nc(i,j)+f(i,j);
    end;
end
axes(handles.axes3)
imshow(ns);
global ns

////////////////////decryptmessage/////////////////

global r c
global ns
for i=1:r
    for j=1:c
       
    rs(i,j)=bitand(ns(i,j),1);
    rs(i,j)=rs(i,j)*255;
    
    end;
end   
axes(handles.axes3)
imshow(rs)
  
/////////////////////////save encrypted//////////////////
global ns
axes(handles.axes3);
[FileName, PathName] = uiputfile('*.bmp', 'Save As');
Name = fullfile(PathName, FileName);
imwrite(ns, Name, 'bmp');

////////////////decrypt///////////////////

global encrypted_image

[re ce be]=size(encrypted_image);
for i=1:re
    for j=1:ce
       
    rs(i,j)=bitand(encrypted_image(i,j),1);
    rs(i,j)=rs(i,j)*255;
    
    end;
end   
axes(handles.axes5)
imshow(rs)
global rs

///////////////////////reset all//////////
arrayfun(@cla,findall(0,'type','axes'))
clc
clear all
