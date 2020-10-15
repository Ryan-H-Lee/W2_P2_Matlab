%BY Ryan Lee, this function 
function output = countUp( nDigits, baseNum)
output = zeros(nDigits, baseNum^nDigits);
counter = 0;
for digit = 1:baseNum^nDigits
   for die = 1:nDigits
       dVal = mod( floor(counter/baseNum^(die-1)),baseNum); 
    output(die, digit) = dVal;
   end
   counter = counter + 1;
end
end