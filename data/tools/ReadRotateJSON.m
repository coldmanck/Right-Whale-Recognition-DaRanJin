fname = 'whale_rotate_info.json';
fid = fopen(fname);
raw = fread(fid,inf);
str = char(raw');
fclose(fid);

data = JSON.parse(str);