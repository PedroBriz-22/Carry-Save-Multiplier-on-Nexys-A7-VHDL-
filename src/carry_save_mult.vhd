----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2025 02:29:38 PM
-- Design Name: 
-- Module Name: carry_save_mult - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity carry_save_mult is
    generic (
        n : integer := 8
    );
    port(
        a : in  std_logic_vector(n-1 downto 0);
        b : in  std_logic_vector(n-1 downto 0);
        p : out std_logic_vector(2*n-1 downto 0)
    );
end carry_save_mult;

architecture structural of carry_save_mult is

    --------------------------------------------------------------------
    -- full_adder component
    --------------------------------------------------------------------
    component full_adder is
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            sum  : out std_logic;
            cout : out std_logic
        );
    end component;

    --------------------------------------------------------------------
    -- Types and signals
    --
    -- pp(i)   : partial product row i, 2n bits wide (shifted version
    --           of b when a(i) = '1', otherwise all zeros)
    --
    -- sum_stage(k) / carry_stage(k): intermediate sums/carries for the
    --           ripple adders that accumulate partial products.
    --------------------------------------------------------------------
    type vec_array_pp  is array (0 to n-1) of std_logic_vector(2*n-1 downto 0);
    type vec_array_stg is array (0 to n-2) of std_logic_vector(2*n-1 downto 0);

    signal pp          : vec_array_pp;
    signal sum_stage   : vec_array_stg;
    signal carry_stage : vec_array_stg;

begin

    --------------------------------------------------------------------
    -- Generate partial products:
    --   pp(i)(i+j) = a(i) AND b(j), for j = 0 .. n-1
    --   everything else in pp(i) is '0'
    --------------------------------------------------------------------
    gen_pp_rows : for i in 0 to n-1 generate
        gen_pp_cols : for j in 0 to 2*n-1 generate
        begin
            pp(i)(j) <= '0' when (j < i) or (j > i + (n-1))
                        else (a(i) and b(j - i));
        end generate;
    end generate;

    --------------------------------------------------------------------
    -- Stage 0: add pp(0) and pp(1) using a ripple-carry adder
    --------------------------------------------------------------------

    -- Bit 0 of stage 0 (cin = '0')
    stage0_bit0 : full_adder
        port map(
            a    => pp(0)(0),
            b    => pp(1)(0),
            cin  => '0',
            sum  => sum_stage(0)(0),
            cout => carry_stage(0)(0)
        );

    -- Bits 1 .. 2*n-1 of stage 0
    gen_stage0_bits : for bit_index in 1 to 2*n-1 generate
    begin
        stage0_fa : full_adder
            port map(
                a    => pp(0)(bit_index),
                b    => pp(1)(bit_index),
                cin  => carry_stage(0)(bit_index - 1),
                sum  => sum_stage(0)(bit_index),
                cout => carry_stage(0)(bit_index)
            );
    end generate;

    --------------------------------------------------------------------
    -- Stages 1 .. n-2:
    --   Each stage k adds:
    --      sum_stage(k-1) + pp(k+1)
    --   again using a ripple-carry adder made from full_adders.
    --------------------------------------------------------------------
    gen_stages : for k in 1 to n-2 generate

        -- Bit 0 of stage k (cin = '0')
        stagek_bit0 : full_adder
            port map(
                a    => sum_stage(k-1)(0),
                b    => pp(k+1)(0),
                cin  => '0',
                sum  => sum_stage(k)(0),
                cout => carry_stage(k)(0)
            );

        -- Bits 1 .. 2*n-1 of stage k
        gen_stagek_bits : for bit_index in 1 to 2*n-1 generate
        begin
            stagek_fa : full_adder
                port map(
                    a    => sum_stage(k-1)(bit_index),
                    b    => pp(k+1)(bit_index),
                    cin  => carry_stage(k)(bit_index - 1),
                    sum  => sum_stage(k)(bit_index),
                    cout => carry_stage(k)(bit_index)
                );
        end generate;

    end generate;

    --------------------------------------------------------------------
    -- Final product = sum from the last stage
    --------------------------------------------------------------------
    p <= sum_stage(n-2);

end structural;

