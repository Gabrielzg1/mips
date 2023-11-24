library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
    port (
        clk: in STD_LOGIC; -- Adicionando o sinal de clock
        address: in STD_LOGIC_VECTOR (31 downto 0);
        instruction: out STD_LOGIC_VECTOR (31 downto 0)
    );
end instruction_memory;

architecture behavioral of instruction_memory is

    -- 128 byte instruction memory (32 rows * 4 bytes/row)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := (
        "00100000011000010000000000110101", -- Instrução 0
        "00100000010000010000000000000101", -- Instrução 1
        -- ... mais instruções ...
        others => "00000000000000000000000000000000" 
    );

begin
    -- Processo sincronizado com a borda de subida do clock
    process(clk)
    begin
        if rising_edge(clk) then
            -- Mapeia o endereço de leitura para a instrução correspondente
            instruction <= data_mem(to_integer(unsigned(address(31 downto 2))));
        end if;
    end process;
    
end behavioral;
