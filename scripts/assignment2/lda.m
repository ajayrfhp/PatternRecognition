data = csvread('fischer.csv');

data = zscore(data(:,1:4));


l1 = size(data)(1)/3;
l2 = 2*l1;
l3 = 3*l1;
data_c1 = data(1:l1,:);
data_c2 = data(l1+1:l2,:);
data_c3	= data(l2+1:l3,:);

function transformed_data = lda_transformation(data,data_c1,data_c2,data_c3)
	m1 = mean(data_c1(:,:));
	m2 = mean(data_c2(:,:));
	m3 = mean(data_c3(:,:));
	l1 = size(data)(1)/3;
	l2 = 2*l1;
	l3 = 3*l1;

	d = size(data)(2);


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



	[eigen_vectors,eigen_values] = eig(inv(sw)*sb);
	disp(eigen_vectors);
	disp(eigen_values);


	transformation_vector = eigen_vectors(:,1:2);
	transformed_data = data * transformation_vector;
	hold on;
	plot(transformed_data(1:l1,1),transformed_data(1:l1,2),'.','color','r');
	plot(transformed_data(l1+1:l2,1),transformed_data(l1+1:l2,2),'.','color','b');
	plot(transformed_data(l2+1:l3,1),transformed_data(l2+1:l3,2),'.','color','g');

	pause(100);	
	
endfunction


lda_transformation(data,data_c1,data_c2,data_c3);	
