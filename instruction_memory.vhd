library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
    port (
       -- clk: in STD_LOGIC; -- Adicionando o sinal de clock
        address: in STD_LOGIC_VECTOR (31 downto 0);
        instruction: out STD_LOGIC_VECTOR (31 downto 0)
    );
end instruction_memory;

architecture behavioral of instruction_memory is

    type mem_array is array(0 to 63) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := ( 		  
		  "00100000000000010000000000010000",  -- addi $t1, $0, 16       # Armazena 16 em $t0 para contar 16 números de Fibonacci
		  "00100000000000110000000000000001",  -- addi $t3, $0, 1        # Segundo número de Fibonacci (F1 = 1) o primeiro é 0 e ja é valor padrao 
		  "10101100100000100000000000000000",  -- sw $t2, 0($t4)         # Armazena F0 no início do array
		  "00100000100001000000000000000100",  -- addi $t4, $t4, 4       # Incrementa o endereço do array 
		  "10101100100000110000000000000000",  -- sw $t3, 0($t4)         # Armazena F1 no array 
		  "00100000100001000000000000000100",  -- addi $t4, $t4, 4       # Incrementa o endereço do array 
        "00100000001000011111111111111110",	-- addi $t1, $t1, -2      # Decrementa o contador em 2 (já que já armazenamos 2 números)
																
														   -- fib_loop: 
		  "00010000000000010000000000010000",  -- beq $t1, $0, end       # Se o contador é zero então termina	 -- TROCAR O ENDERECO DE FIM 
		  "00000000010000110010100000100000",  -- add $t5, $t2, $t3      # Calcula o próximo número de Fibonacci (F(n) = F(n-1) + F(n-2))
		  "10101100100001010000000000000000",  -- sw $t5, 0($t4)         # Armazena o novo número de Fibonacci no array
		  "00000000011000000001000000100000",  -- add $t2, $t3, $zero    # Move F(n-1) para F(n-2) para a próxima iteração
		  "00000000101000000001100000100000",  -- add $t3, $t5, $zero    # Move F(n) para F(n-1) para a próxima iteração
		  "00100000100001000000000000000100",  -- addi $t4, $t4, 4       # Incrementa o endereço do array 
		  "00100000001000011111111111111111",  -- addi $t1, $t1, -1      # Decrementa o contador
		  "00001000000000000000000000001000",	-- j fib_loop             # Volta ao início do loop
		  
		  
        -- ... mais instruções ...
        others => "00000000000000000000000000000000" 
    );

begin
 
            -- Mapeia o endereço de leitura para a instrução correspondente
            instruction <= data_mem(to_integer(unsigned(address(31 downto 2))));
   
    
end behavioral;
