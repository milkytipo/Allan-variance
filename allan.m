function [T,sigma2] = allan(omega,fs,pts)
[N,M] = size(omega);             % figure out how big the output data set is
n = 2.^(0:floor(log2(N/2)))';    % determine largest bin size  //保证M<N/2;
maxN = n(end);
endLogInc = log10(maxN);
m =unique (ceil(logspace(0,endLogInc,pts)))';    % create log spaced vector average factor  //logspace 是按照对数等分的，因为随着m增大精度减小，所以缩减较大的m数量
t0 = 1/fs;                                       % t0 = sample interval
T = m*t0;                                        % T = length of time for each cluster
sigma2 = zeros(length(T),M);    % array of dimensions (cluster periods) X (#variables)

theta = cumsum(omega) ;

% for i =  length(m) : -1: 1
for i=1:length( m)     
    for  k= 1:N-2*m(i) 
        sigma2(i,:) = sigma2(i,:) +(   (    (theta(k+2*m(i),:) - 2*theta(k+m(i),:) + theta(k,:)    )/m(i)     ).^2  ) /( 2 * ( N-2*m(i) )  ) ;
    end
end
sigma = sqrt(sigma2);


           
% theta = cumsum(omega)/fs;       % integration of samples over time to obtain output angle θ
% 
% for i=1:length(  m)               % loop over the various cluster sizes
%     for k=1:N-2*m(i)            % implements the summation in the AV equation
%         sigma2(i,:) = sigma2(i,:) + (theta(k+2*m(i),:) - 2*theta(k+m(i),:) + theta(k,:)).^2;
%     end
% end
% sigma2 = sigma2./repmat((2*T.^2.*(N-2*m)),1,M);
% sigma = sqrt(sigma2);
