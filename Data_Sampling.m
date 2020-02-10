%% Data_Sampling
%-----------------------------------------------------Signal Generator V1.5
% - 데이터 혹은 코드를 샘플링 주파수에 맞는 크기로 생성하는 함수
% - Input
%   Input_Data : 데이터 혹은 코드
%   Div : 분주비, ex) 1*12의 데이터를 Div=2로 샘플링하면 1*24의 데이터
%
% - Output
%   Sampled_Data : 샘플링된 데이터 혹은 코드
%------------------------------------------------------------13.06.28 박귀우

function Sampled_Data = Data_Sampling(Input_Data, Div)

Data_len = length(Input_Data);

if Data_len >2
    Div_int = ceil(Div);
    Temp_len = Data_len * Div_int;
    Real_len = round(Data_len * Div);
    Extra_bit = Temp_len - Real_len;
    Temp_Sampled_Data = zeros(1, Temp_len);
    Sampled_Data = zeros(1, Real_len);
    for i = 1:Div_int
        Temp_Sampled_Data(i:Div_int:Temp_len) = Input_Data;
    end
    
    if Extra_bit > 0
        Extra_f = fix(Temp_len/Extra_bit) - 1;
        for i = 1:Extra_bit
            Sampled_Data(1+((i-1)*Extra_f):Extra_f*i) = Temp_Sampled_Data(1+((i-1)*Extra_f)+(i-1):(Extra_f*i)+(i-1));
        end
        rem = Real_len - (Extra_f * i);
        Sampled_Data((end-(rem+1)):end) = Temp_Sampled_Data((end-(rem+1)):end);
    else
        Sampled_Data = Temp_Sampled_Data;
    end
else
    Sampled_Data = ones(1,Div)*Input_Data;
end


end