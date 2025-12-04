library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(
        a    : in  std_logic;   -- top-left input
        b    : in  std_logic;   -- top-right input
        cin  : in  std_logic;   -- right input (carry in)
        sum  : out std_logic;   -- bottom output
        cout : out std_logic    -- left output (carry out)
    );
end full_adder;

architecture dataflow of full_adder is
begin
    -- Sum = XOR of all three bits
    sum  <= a xor b xor cin;

    -- Carry out = majority(a, b, cin)
    cout <= (a and b) or
            (a and cin) or
            (b and cin);
end dataflow;
