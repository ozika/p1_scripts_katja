function [output_string] = replace_str(input_string, orig_str, replace_str, varargin)


if strfind(input_string, orig_str)
    if ~isempty(varargin)
        noloops = varargin{1};
    else
        noloops = length(strfind(input_string, orig_str));
    end
    orig_str_len = length(orig_str);
    id = strfind(input_string, orig_str);
    for t = 1:noloops
            str = strfind(input_string, orig_str);
            strid =str(1);
            if strid+orig_str_len-1 < length(input_string)
                post_chunk = input_string((strid+orig_str_len):end);
            elseif strid+orig_str_len-1 == length(input_string)
                post_chunk = '';
            end
            
            if strid == 1
                pre_chunk = '';
            else
                pre_chunk = input_string(1:strid-1);
            end
            
            input_string = [pre_chunk replace_str post_chunk];
      
    end
end
output_string = input_string;





