function [c1,c2] = vad(x)

 

%Amplitude normalization to [-1,1]
x = double(x);
x = x / max(abs(x));

 

%Constant set
FrameLen = 240;%The frame length is 240 points
FrameInc = 80;%Frame shift to 80 points

 

amp1 = 10;%Initial short time high energy threshold
amp2 = 2;%Initial short time low energy threshold
zcr1 = 10;%High threshold value for initial short time zero crossing rate
zcr2 = 5;%Low threshold value initial short time zero crossing rate

 

maxsilence = 8;  % 8*10ms  = 80ms

%If the number of silent frames in the speech segment does not exceed this value, the speech is considered not finished.



minlen  = 15;    % 15*10ms = 150ms

%The shortest length of the speech segment, if the length of the speech segment is less than this value, it is considered as a segment of noise


status  = 0;     %The initial state is silent state
count   = 0;     %The initial speech segment length is 0
silence = 0;     %The initial silent segment length is 0

 

%Calculate the zero crossing rate
tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);

 

%Computing short time energy

amp = sum(abs(enframe(x, FrameLen, FrameInc)), 2);

 

%Adjust the energy threshold
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);

 

%Start endpoint detection
x1 = 0;
x2 = 0;
for n=1:length(zcr)
   goto = 0;
   switch status
   case {0,1}                   
      if amp(n) > amp1         
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... 
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                      
         status  = 0;
         count   = 0;
      end
   case 2,                       
      if amp(n) > amp2 | ...    
         zcr(n) > zcr2
         count = count + 1;
      else                      
         silence = silence+1;
         if silence < maxsilence 
            count  = count + 1;
         elseif count < minlen  
            status  = 0;
            silence = 0;
            count   = 0;
         else                   
            status  = 3;
         end
      end
   case 3,
      break;
   end
end  

count = count-silence/2;
x2 = x1 + count -1;
c1=x1*FrameInc;
c2=x2*FrameInc;

