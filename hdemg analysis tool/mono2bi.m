function y = mono2bi(x_filtered)

Temp(:,1)=x_filtered(:,5)-x_filtered(:,4);
Temp(:,2)=x_filtered(:,11)-x_filtered(:,5);
Temp(:,3)=x_filtered(:,10)-x_filtered(:,11);
Temp(:,4)=x_filtered(:,24)-x_filtered(:,10);
Temp(:,5)=x_filtered(:,32)-x_filtered(:,24);
Temp(:,6)=x_filtered(:,34)-x_filtered(:,32);
Temp(:,7)=x_filtered(:,39)-x_filtered(:,34);
Temp(:,8)=x_filtered(:,40)-x_filtered(:,39);
Temp(:,9)=x_filtered(:,49)-x_filtered(:,40);
Temp(:,10)=x_filtered(:,50)-x_filtered(:,49);
Temp(:,11)=x_filtered(:,62)-x_filtered(:,50);
Temp(:,12)=x_filtered(:,61)-x_filtered(:,62);

Temp(:,1+12)=x_filtered(:,6)-x_filtered(:,3);
Temp(:,2+12)=x_filtered(:,12)-x_filtered(:,6);
Temp(:,3+12)=x_filtered(:,9)-x_filtered(:,12);
Temp(:,4+12)=x_filtered(:,23)-x_filtered(:,9);
Temp(:,5+12)=x_filtered(:,31)-x_filtered(:,23);
Temp(:,6+12)=x_filtered(:,33)-x_filtered(:,31);
Temp(:,7+12)=x_filtered(:,38)-x_filtered(:,33);
Temp(:,8+12)=x_filtered(:,48)-x_filtered(:,38);
Temp(:,9+12)=x_filtered(:,41)-x_filtered(:,48);
Temp(:,10+12)=x_filtered(:,51)-x_filtered(:,41);
Temp(:,11+12)=x_filtered(:,63)-x_filtered(:,51);
Temp(:,12+12)=x_filtered(:,60)-x_filtered(:,63);

Temp(:,1+24)=x_filtered(:,7)-x_filtered(:,2);
Temp(:,2+24)=x_filtered(:,13)-x_filtered(:,7);
Temp(:,3+24)=x_filtered(:,17)-x_filtered(:,13);
Temp(:,4+24)=x_filtered(:,22)-x_filtered(:,17);
Temp(:,5+24)=x_filtered(:,30)-x_filtered(:,22);
Temp(:,6+24)=x_filtered(:,27)-x_filtered(:,30);
Temp(:,7+24)=x_filtered(:,37)-x_filtered(:,27);
Temp(:,8+24)=x_filtered(:,47)-x_filtered(:,37);
Temp(:,9+24)=x_filtered(:,42)-x_filtered(:,47);
Temp(:,10+24)=x_filtered(:,52)-x_filtered(:,42);
Temp(:,11+24)=x_filtered(:,64)-x_filtered(:,52);
Temp(:,12+24)=x_filtered(:,59)-x_filtered(:,64);

Temp(:,1+36)=x_filtered(:,8)-x_filtered(:,1);
Temp(:,2+36)=x_filtered(:,14)-x_filtered(:,8);
Temp(:,3+36)=x_filtered(:,18)-x_filtered(:,14);
Temp(:,4+36)=x_filtered(:,21)-x_filtered(:,18);
Temp(:,5+36)=x_filtered(:,29)-x_filtered(:,21);
Temp(:,6+36)=x_filtered(:,26)-x_filtered(:,29);
Temp(:,7+36)=x_filtered(:,36)-x_filtered(:,26);
Temp(:,8+36)=x_filtered(:,46)-x_filtered(:,36);
Temp(:,9+36)=x_filtered(:,43)-x_filtered(:,46);
Temp(:,10+36)=x_filtered(:,53)-x_filtered(:,43);
Temp(:,11+36)=x_filtered(:,56)-x_filtered(:,53);
Temp(:,12+36)=x_filtered(:,58)-x_filtered(:,56);

Temp(:,1+48)=x_filtered(:,15)-x_filtered(:,16);
Temp(:,2+48)=x_filtered(:,19)-x_filtered(:,15);
Temp(:,3+48)=x_filtered(:,20)-x_filtered(:,19);
Temp(:,4+48)=x_filtered(:,28)-x_filtered(:,20);
Temp(:,5+48)=x_filtered(:,25)-x_filtered(:,28);
Temp(:,6+48)=x_filtered(:,35)-x_filtered(:,25);
Temp(:,7+48)=x_filtered(:,45)-x_filtered(:,35);
Temp(:,8+48)=x_filtered(:,44)-x_filtered(:,45);
Temp(:,9+48)=x_filtered(:,54)-x_filtered(:,44);
Temp(:,10+48)=x_filtered(:,55)-x_filtered(:,54);
Temp(:,11+48)=x_filtered(:,57)-x_filtered(:,55);


y=Temp;

end

