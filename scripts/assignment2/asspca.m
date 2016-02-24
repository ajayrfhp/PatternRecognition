data_c1 = load('TRAINTEST2D.mat','TRAIN').('TRAIN'){1,4}{1,1}';
%'
data_c2 = load('TRAINTEST2D.mat','TRAIN').('TRAIN'){1,4}{1,2}';
%'
data_c3 = load('TRAINTEST2D.mat','TRAIN').('TRAIN'){1,4}{1,3}';
%'
test_c1 = load('TRAINTEST2D.mat','TEST').('TEST'){1,4}{1,1}';
%'
test_c2 = load('TRAINTEST2D.mat','TEST').('TEST'){1,4}{1,2}';
%'
test_c3 = load('TRAINTEST2D.mat','TEST').('TEST'){1,4}{1,3}';
%'


data = [data_c1;data_c2;data_c3];
test = [test_c1;test_c2;test_c3];


function transformed_data =  pca(data)
	l = size(data)(1)/3;
	m = mean(data(:,:));
	for i = 1:size(data)(1)
		data(i,:) -= m;
	endfor
	c = cov(data);
	[eigen_vectors,eigen_values] = eig(c);
	transformation_vector = eigen_vectors(:,2);
	hold on;
	%plot(data(:,1),data(:,2),'.','color','r');
	%disp(transformation_vector(1));
	%disp(transformation_vector(2));

	transformed_data = data * transformation_vector; 

	plot(transformed_data(1:l),0,'.','color','g');
	plot(transformed_data(l+1:2*l),0,'.','color','r');
	plot(transformed_data((2*l+1):3*l),0,'.','color','b');
	pause(5);


endfunction


pca(data);
pca(test);


