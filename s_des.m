disp("Talha 114");
ip = [2 6 3 1 4 8 5 7];
ip_inv = [4 1 3 5 7 2 8 6];
ep = [4 1 2 3 2 3 4 1];
p4 = [2 4 3 1];
s0 = [1 0 3 2; 3 2 1 0; 0 2 1 3; 3 1 3 2];
s1 = [0 1 2 3; 2 0 1 3; 3 0 1 0; 2 1 0 3];
pt = [0 1 1 1 0 0 1 0];
k1 = [1 0 1 0 0 1 0 0];
k2 = [0 1 0 0 0 0 1 1];
step1 = pt(ip);
% step 2
left1 = step1(1:4);
right1 = step1(5:8);
% step 3
step3 = right1(ep);
% step 4
step4 = xor(step3,k1);
% step 5
new_s0 = step4(1:4);
new_s1 = step4(5:8);
r_s0 = new_s0([1,4]); 
c_s0 = new_s0([2,3]);
r_s0_str = num2str(r_s0);
r_s0_dec = bin2dec(r_s0_str);
c_s0_str = num2str(c_s0);
c_s0_dec = bin2dec(c_s0_str);
num_r_s0 = uint64(r_s0_dec + 1);
num_c_s0 = uint64(c_s0_dec + 1);
new_s0 = s0(num_r_s0,num_c_s0);
new_s0_bin = dec2bin(new_s0);
% for s1
r_s1 = new_s1([1,4]); 
c_s1 = new_s1([2,3]);
r_s1_str = num2str(r_s1);
r_s1_dec = bin2dec(r_s1_str);
c_s1_str = num2str(c_s1);
c_s1_dec = bin2dec(c_s1_str);
num_r_s1 = uint64(r_s0_dec + 1);
num_c_s1 = uint64(c_s0_dec + 1);
new_s1 = s1(num_r_s1,num_c_s1);
new_s1_bin = dec2bin(new_s1);
% step 6 
s0_s1 = [new_s0_bin new_s1_bin];
step6 = s0_s1(p4);
arr = num2str(step6)-'0'; % coverting int to array
% step 7
step7 = xor(arr, left1);
% step 8
swap_left = right1;
swap_right = step7;
% Step 9
step9 = swap_right(ep);
% Step 10
step10 = xor(step9, k2);
% Step 11
new_s0 = step10(1:4);
new_s1 = step10(5:8)
r_s0 = new_s0([1,4]); 
c_s0 = new_s0([2,3]);
r_s0_str = num2str(r_s0);
r_s0_dec = bin2dec(r_s0_str);
c_s0_str = num2str(c_s0);
c_s0_dec = bin2dec(c_s0_str);
num_r_s0 = uint64(r_s0_dec + 1);
num_c_s0 = uint64(c_s0_dec + 1);
new_s0 = s0(num_r_s0,num_c_s0);
new_s0_bin = dec2bin(new_s0)
% for s1
r_s1 = new_s1([1,4])
c_s1 = new_s1([2,3])
r_s1_str = num2str(r_s1);
r_s1_dec = bin2dec(r_s1_str) + 1 
c_s1_str = num2str(c_s1);
c_s1_dec = bin2dec(c_s1_str) + 1
new_s1 = s1(r_s1_dec,c_s1_dec)
new_s1_bin = dec2bin(new_s1)


