disp("Talha 114");
key = [1 0 1 0 0 0 0 0 1 0];
p10 = [3 5 2 7 4 10 1 9 8 6];
p8 = [6 3 7 4 8 5 10 9];
perm1 = key(p10);
left = perm1(1:5);
right = perm1(6:10);
ls_1 = circshift(left,[1 -1]);
lsr_1 = circshift(right,[1 -1]);
combined1 = [ls_1 lsr_1];
key1 = combined1(p8)
ls_2 = circshift(ls_1,[1 -2]);
lsr_2 = circshift(lsr_1,[1 -2]);
combined2 = [ls_2 lsr_2];
key2 = combined2(p8)