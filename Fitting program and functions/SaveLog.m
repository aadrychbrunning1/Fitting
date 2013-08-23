% A function to write a log file with relevant details
function SaveLog(details, path_to_file)
dlmwrite(path_to_file,details, '\t')