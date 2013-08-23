function global_demo1(num)
global globalvar

if nargin>0
    globalvar=num
end
fprintf('Global variable in function %s is %d\n',...
    mfilename, globalvar);
