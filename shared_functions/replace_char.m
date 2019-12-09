function [output_string] = replace_char(input_string, orig_char, replace_char)
%old use replace_str
if iscell(input_string)
    pp = input_string;
    input_string = char(input_string{1});
    outcell = 1;
else
    pp2 = input_string;
    outcell = 0;
end
if strfind(input_string, orig_char)
    id = strfind(input_string, orig_char);
    for t = 1:length(id)
        if strcmp(replace_char, '')
            input_string = [input_string(1:id(t)-1) input_string(id(t)+1:end)];
        else
            input_string(id(t)) = replace_char;
        end
    end
        output_string = input_string;
else
    if outcell == 1
        output_string = pp{1};
    else
        output_string = pp2;
    end
end



