function [ X ] = readFile( fileName )
text = sprintf('data/%s',fileName);
file= fopen(text);
filedata = textscan(file,'%f %f %f');
X=[filedata{1} filedata{2} filedata{3}];


end
