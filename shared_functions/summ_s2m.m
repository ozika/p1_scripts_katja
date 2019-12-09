function [d] = summ_d2m(varargin)

DATA = varargin{1};
r = varargin{2};
type =varargin{3};
time = varargin{4};
contrasts =varargin{5};



pstr = {'acquisition', 'extinction'};
half = {'FirstH', 'SecondH'};
cstr = {'harm', 'safe', 'rev'};
ostr={'shock', 'noshoc'};
d=[];
 switch type
     case 'chp'
        for c = 1:3
            for h = 1:2
                for ph = 1:2
                    id=[];
                    if length(varargin) < 6
                        id = find_multiple_strings_in_cell(contrasts, {time, cstr{c}, half{h}, pstr{ph}});
                    else
                        pmod = varargin{6};
                        id = find_multiple_strings_in_cell(contrasts, {time, pmod, cstr{c}, half{h}, pstr{ph}});
                    end
                        
                    d(:,ph,h,c) = mean(table2array(DATA{2,r}(:,id)),2, 'omitnan');

                end
            end
        end
        
     case 'chpo'
        for c = 1:3
            for h = 1:2
                for ph = 1:2
                    for o = 1:2
                        id=[];
                        if length(varargin) < 6
                            id = find_multiple_strings_in_cell(contrasts, {time, ostr{o}, cstr{c}, half{h}, pstr{ph}});
                        else
                            pmod = varargin{6};
                            id = find_multiple_strings_in_cell(contrasts, {time, pmod, ostr{o}, cstr{c}, half{h}, pstr{ph}});
                        end
                        d(:,o, ph,h,c) = mean(table2array(DATA{2,r}(:,id)),2, 'omitnan');
                    end
                end
            end
        end
        case 'cho'
        for c = 1:3
            for h = 1:2
               
                    for o = 1:2
                        id=[];
                        if length(varargin) < 6
                            id = find_multiple_strings_in_cell(contrasts, {time, cstr{c}, half{h}});
                        else
                            pmod = varargin{6};
                            id = find_multiple_strings_in_cell(contrasts, {time, pmod, ostr{o}, cstr{c}, half{h}});
                        end
                        d(:,o, h,c) = mean(table2array(DATA{2,r}(:,id)),2, 'omitnan');
                    end
                
            end
        end
 end
