function parent_folder = getParentFolderName()

parent_folder = 0;

my_pwd = pwd;

if isunix
    delim = '/';
else
    delim = '\';
end

[tok rem] = strtok(my_pwd,delim);
while true
    [tok rem] = strtok(rem,delim);
    if length(tok) > 0
        parent_folder = tok;
    else
        break;
    end
end
