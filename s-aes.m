disp("Talha 114");
pt = [1 10 2 3];
key = [2 4 7 5];
s_box = [9 4 10 11; 13 1 8 5; 6 2 0 3; 12 14 15 7];
w = 0;
temp1 = key(1:2);
temp1_bin = dec2bin(temp1,8);
temp1_arr = num2str(temp1_bin)-'0' ;% coverting int to array
w = 1;
temp2 = key(3:4);
shift_rot = fliplr(temp2);
shift_rot_bin = dec2bin(shift_rot,8);
r1 = shift_rot_bin(1, 5:6) ;
c1 = shift_rot_bin(1, 7:8) ;
r2 = shift_rot_bin(2, 5:6)  ;
c2 = shift_rot_bin(2, 7:8) ;
r1_dec = bin2dec(r1) + 1 ;
c1_dec = bin2dec(c1) + 1;
r2_dec = bin2dec(r2) + 1 ;
c2_dec = bin2dec(c2) + 1;
sw_for_1 = s_box(r1_dec,c1_dec);
sw_for_2 = s_box(r2_dec,c2_dec);

sw1 = [sw_for_1 sw_for_2];
sw1_bin = dec2bin(sw1,8);
r_con = [8 0];
r_con_bin = dec2bin(r_con,8);
x1 = num2str(r_con_bin)-'0' ;
x2 = num2str(sw1_bin)-'0'; 
t1 = xor(x1, x2);
word2 = xor(t1, temp1_arr);
type = class(word2);
word2_dec = bin2dec(word2)
word2_dec = dec2hex(word2_dec)

