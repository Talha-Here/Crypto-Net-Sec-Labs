disp("Talha 114");
pt = [1 2;10 3];
k0 = [2 7;4 5];
disp('S-AES ALGORITHM');
disp('Plain Text: ');
disp(pt);
disp('Key: ');
disp(k0);
rCon = [8 0];
rCon2 = [3 0];
w(1,:) = [k0(1,1) k0(2,1)];
w(2,:) = [k0(1,2) k0(2,2)];
w = SAES_keyGen(w, 2, rCon);
w = SAES_keyGen(w, 3, 0);
w = SAES_keyGen(w, 4, rCon2);
w = SAES_keyGen(w, 5, 0);
w = w';
k0_bin = [de2bi((w(1,1)),'left-msb',4) , de2bi((w(1,2)),'left-msb',4) ; 
 de2bi((w(2,1)),'left-msb',4) , de2bi((w(2,2)),'left-msb',4)];
pt_bin = [de2bi(pt(1,1),'left-msb',4) , de2bi(pt(1,2),'left-msb',4); 
 de2bi(pt(2,1),'left-msb',4) , de2bi(pt(2,2),'left-msb',4)];
rk_transformation = xor(k0_bin, pt_bin);
add_rk = Transform(rk_transformation, 1, w(1,3), w(1,4), w(2,3), w(2,4));
add_rk2 = Transform(add_rk, 2, w(1,5), w(1,6), w(2,5), w(2,6));
ct_matrix_dec = [bi2de(add_rk2(1,1:4),'left-msb') bi2de(add_rk2(1,5:8),'left-msb');
 bi2de(add_rk2(2,1:4),'left-msb') bi2de(add_rk2(2,5:8),'left-msb')];
ct_matrix_hex = [' ', dec2hex(ct_matrix_dec(1,1)), ' ' ,dec2hex(ct_matrix_dec(1,2));
 ' ', dec2hex(ct_matrix_dec(2,1)), ' ' ,dec2hex(ct_matrix_dec(2,2))];
disp('Encryption Cipher Text: ');
disp(ct_matrix_hex)
function [ add_r_K ] = Transform( rkt, rnd, w1, w2, w3, w4 )
 S_Box = [9 4 10 11; 13 1 8 5; 6 2 0 3; 12 14 15 7];
 c_m = [1 4; 4 1];
 mct = [2 4 6 8 10 12 14 3 1 7 5 11 9 15 13;
 4 8 12 3 7 11 15 6 2 14 10 5 1 13 9
 9 1 8 2 11 3 10 4 13 5 12 6 15 7 14];
 k = 1;
 for i = 1:2
 k = 1;
 t = rkt(i,1:4);
 row = t(1:2);
 col = t(3:4);
 row_dec = bi2de(row,'left-msb');
 col_dec = bi2de(col,'left-msb');
 n_s(i,k) = S_Box(row_dec+1, col_dec+1);
 k = k + 1;
 t = rkt(i,5:8);
 row = t(1:2);
 col = t(3:4);
 row_dec = bi2de(row,'left-msb');
 col_dec = bi2de(col,'left-msb');
 n_s(i,k) = S_Box(row_dec+1, col_dec+1);
 k = k + 1;
 end
 ns_shift = [n_s(1,1) n_s(1,2);
 n_s(2,2) n_s(2,1)];
 nmb = [de2bi(ns_shift(1,1),'left-msb',4) , de2bi(ns_shift(1,2),'left-msb',4); 
 de2bi(ns_shift(2,1),'left-msb',4) , de2bi(ns_shift(2,2),'left-msb',4)];
 if(rnd == 1)
 for i = 1:2
 for j = 1:2
 if c_m(i,j) == 1
 el(j) = c_m(i,j) * ns_shift(j,1);
 else
 if (c_m(i,j) == 2)
 row = 1;
 col = ns_shift(j,i);
 elseif(c_m(i,j) == 4 || c_m(i,j) == 9)
 row = sqrt(c_m(i,j));
 col = ns_shift(j,1);
 end
 el(j) = mct(row,col);
 end
 end
 e1_bin = de2bi(el(1),'left-msb',4);
 e2_bin = de2bi(el(2),'left-msb',4);
 xor_r = xor(e1_bin,e2_bin);
mcm(i,1) = bi2de(xor_r,'left-msb');
 for j = 1:2
 if c_m(i,j) == 1
 el(j) = c_m(i,j) * ns_shift(j,2);
 else
 if (c_m(i,j) == 2)
 row = 1;
 col = ns_shift(j,2);
 elseif(c_m(i,j) == 4 || c_m(i,j) == 9)
 row = sqrt(c_m(i,j));
 col = ns_shift(j,2);
 end
 el(j) = mct(row,col);
 end
 end
 e1_bin = de2bi(el(1),'left-msb',4);
 e2_bin = de2bi(el(2),'left-msb',4);
 xor_r = xor(e1_bin,e2_bin);
 mcm(i,2) = bi2de(xor_r,'left-msb'); 
 end
 new_matrix = mcm;
 nmb = [de2bi(new_matrix(1,1),'left-msb',4) , de2bi(new_matrix(1,2),'left-msb',4); 
 de2bi(new_matrix(2,1),'left-msb',4) , de2bi(new_matrix(2,2),'left-msb',4)];
 end 
 kb = [de2bi(w1,'left-msb',4) , de2bi(w2,'left-msb',4); 
 de2bi(w3,'left-msb',4) , de2bi(w4,'left-msb',4)]; 
 add_r_K = xor(kb, nmb);
end