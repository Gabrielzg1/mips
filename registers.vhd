library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers is
    Port (
        clk : in std_logic;
        reg_write : in std_logic; -- Sinal para controlar a escrita no registrador
        read_reg1 : in std_logic_vector(4 downto 0); -- Número do primeiro registrador para leitura
        read_reg2 : in std_logic_vector(4 downto 0); -- Número do segundo registrador para leitura
        write_reg : in std_logic_vector(4 downto 0); -- Número do registrador para escrita
        write_data : in std_logic_vector(31 downto 0); -- Dados a serem escritos
        read_data1 : out std_logic_vector(31 downto 0); -- Dados do primeiro registrador lido
        read_data2 : out std_logic_vector(31 downto 0) -- Dados do segundo registrador lido
    );
end registers;

architecture Behavioral of registers is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers: reg_array := (others => (others => '0')); -- Inicializa os registradores com 0
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reg_write = '1' then
                -- Escreve no registrador
                registers(to_integer(unsigned(write_reg))) <= write_data;
            end if;
            -- Lê os registradores
            read_data1 <= registers(to_integer(unsigned(read_reg1)));
            read_data2 <= registers(to_integer(unsigned(read_reg2)));
        end if;
    end process;
end Behavioral;
