d = 'DATA';
s = load('ASSIGNMENT1.mat',d);
data = s.(d);


training = data(1:2000,:);
testing = data(2001:size(data)(1),:);



function answer = gaussian(v1,v2,sigma)
	b = - (norm(v1-v2)**2) / (2 * sigma * sigma);
	answer = e ** b;
endfunction


tx = linspace(-1,1,1000);


for(i = 1:1000)
	ans = 0;
	for(j = 1:size(training)(1))
		ans += training(j,3) * gaussian(training(j,1:2),[tx(i) tx(i)],0.1);
	endfor
	output(i) = ans;
endfor

plot(output);

pause(15);