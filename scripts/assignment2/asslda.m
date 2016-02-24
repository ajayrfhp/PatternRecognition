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

data = zscore(data(:,:));



l1 = size(data)(1)/3;
l2 = 2*l1;
l3 = 3*l1;


function answer = gaussian_kernel(v1,v2,sigma)
	b = - (norm(v1-v2)**2) / (2 * sigma * sigma);
	answer = e ** b;
endfunction




function transformed_data = lda_transformation(data,data_c1,data_c2,data_c3)
	m1 = mean(data_c1(:,:));
	m2 = mean(data_c2(:,:));
	m3 = mean(data_c3(:,:));
	l1 = size(data)(1)/3;
	l2 = 2*l1;
	l3 = 3*l1;

	d = size(data)(2);

	disp(size(m1));

	sw = zeros(d,d);
	s1 = zeros(d,d);
	s2 = zeros(d,d);
	s3 = zeros(d,d);
	for i = 1:l1
		s1 += (data_c1(i,:) - m1)' * (data_c1(i,:) - m1);
		%'
		s2 += (data_c2(i,:) - m2)' * (data_c2(i,:) - m2);	
		%'
		s3 += (data_c3(i,:) - m3)' * (data_c3(i,:) - m3); 
		%'
	endfor
	sw = s1 + s2 + s3;
	
	m = (m1 + m2 + m3)/3;
	sb = l1 * ( m1 - m)' * ( m1 - m) + l1 * ( m2 - m)' * ( m2 - m) + l1 * ( m3 - m)' * ( m3 - m);
	
	%'



	[eigen_vectors,eigen_values] = eig(pinv(sw)*(sb));



	transformation_vector = real(eigen_vectors(:,2));
	transformed_data = data * transformation_vector;
	disp(transformed_data);
	hold on;

	plot((10**-10)*transformed_data(1:l1,1),0,'.','color','r');
	plot((10**-10)*transformed_data(l1+1:l2,1),0,'.','color','b');
	plot((10**-10)*transformed_data(l2+1:l3,1),0,'.','color','g');

	pause(100);	
	
endfunction


for i = 1:size(data)(1)
	for j = 1:size(data)(1)
		kernel_data(i,j) = gaussian_kernel(data(i,:),data(j,:),0.01);
	endfor
endfor

%kernel_data = zscore(kernel_data(:,:));

data_c1 = kernel_data(1:l1,:);
data_c2 = kernel_data(l1+1:l2,:);
data_c3	= kernel_data(l2+1:l3,:);



lda_transformation(kernel_data,data_c1,data_c2,data_c3);	



