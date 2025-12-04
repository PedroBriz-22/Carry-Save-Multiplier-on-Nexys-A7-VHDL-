library ieee;
use ieee.std_logic_1164.all;

entity mult is
    port(
        clk : in  std_logic;                       -- clock signal
        a   : in  std_logic_vector(7 downto 0);    -- first operand
        b   : in  std_logic_vector(7 downto 0);    -- second operand
        r   : out std_logic_vector(15 downto 0)    -- registered product
    );
end mult;

architecture structural of mult is

    --------------------------------------------------------------------
    -- Component declaration for carry_save_mult
    --------------------------------------------------------------------
    component carry_save_mult is
        generic(
            n : integer := 8
        );
        port(
            a : in  std_logic_vector(n-1 downto 0);
            b : in  std_logic_vector(n-1 downto 0);
            p : out std_logic_vector(2*n-1 downto 0)
        );
    end component;

    --------------------------------------------------------------------
    -- Internal registers for pipelining
    --------------------------------------------------------------------
    signal a_reg : std_logic_vector(7 downto 0);
    signal b_reg : std_logic_vector(7 downto 0);
    signal p_int : std_logic_vector(15 downto 0);

begin

    --------------------------------------------------------------------
    -- Instantiate carry-save multiplier
    --------------------------------------------------------------------
    U_CSM : carry_save_mult
        generic map(
            n => 8
        )
        port map(
            a => a_reg,
            b => b_reg,
            p => p_int
        );

    --------------------------------------------------------------------
    -- Pipeline registers (input and output)
    -- Triggered on the rising edge of clk
    --------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            a_reg <= a;      -- register input a
            b_reg <= b;      -- register input b
            r     <= p_int;  -- register output p
        end if;
    end process;

end structural;
