-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "05/10/2025 19:48:49"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	integer_divider IS
    PORT (
	Clock : IN std_logic;
	Resetn : IN std_logic;
	s : IN std_logic;
	A : IN std_logic_vector(3 DOWNTO 0);
	B : IN std_logic_vector(3 DOWNTO 0);
	R : BUFFER std_logic_vector(3 DOWNTO 0);
	Q : BUFFER std_logic_vector(3 DOWNTO 0);
	Err : OUT std_logic;
	Done : OUT std_logic
	);
END integer_divider;

-- Design Ports Information
-- R[0]	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R[1]	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R[2]	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R[3]	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[0]	=>  Location: PIN_L11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[1]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[2]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[3]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Err	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Done	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Clock	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Resetn	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_K10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF integer_divider IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Clock : std_logic;
SIGNAL ww_Resetn : std_logic;
SIGNAL ww_s : std_logic;
SIGNAL ww_A : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_R : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Q : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Err : std_logic;
SIGNAL ww_Done : std_logic;
SIGNAL \Resetn~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \Selector2~1_combout\ : std_logic;
SIGNAL \R[0]~output_o\ : std_logic;
SIGNAL \R[1]~output_o\ : std_logic;
SIGNAL \R[2]~output_o\ : std_logic;
SIGNAL \R[3]~output_o\ : std_logic;
SIGNAL \Q[0]~output_o\ : std_logic;
SIGNAL \Q[1]~output_o\ : std_logic;
SIGNAL \Q[2]~output_o\ : std_logic;
SIGNAL \Q[3]~output_o\ : std_logic;
SIGNAL \Err~output_o\ : std_logic;
SIGNAL \Done~output_o\ : std_logic;
SIGNAL \Clock~input_o\ : std_logic;
SIGNAL \Clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \Resetn~input_o\ : std_logic;
SIGNAL \Resetn~inputclkctrl_outclk\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \IsZero|ISZERO~0_combout\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \RegB|Q[0]~feeder_combout\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \RegB|Q[3]~feeder_combout\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \RegA|Q[1]~feeder_combout\ : std_logic;
SIGNAL \RMux|X[1]~1_combout\ : std_logic;
SIGNAL \RMux|X[1]~2_combout\ : std_logic;
SIGNAL \s~input_o\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \y.S0~feeder_combout\ : std_logic;
SIGNAL \y.S0~q\ : std_logic;
SIGNAL \FSM_outputs~0_combout\ : std_logic;
SIGNAL \FSM_outputs~1_combout\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \RegA|Q[3]~feeder_combout\ : std_logic;
SIGNAL \RMux|X[3]~6_combout\ : std_logic;
SIGNAL \RMux|X[3]~7_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \ER~combout\ : std_logic;
SIGNAL \RMux|X[1]~3_combout\ : std_logic;
SIGNAL \RMux|X[2]~4_combout\ : std_logic;
SIGNAL \RMux|X[2]~5_combout\ : std_logic;
SIGNAL \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \Selector2~2_combout\ : std_logic;
SIGNAL \y.S1~q\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \RegA|Q[0]~feeder_combout\ : std_logic;
SIGNAL \RMux|X[0]~0_combout\ : std_logic;
SIGNAL \RegR|Q[0]~feeder_combout\ : std_logic;
SIGNAL \QMux|X[0]~0_combout\ : std_logic;
SIGNAL \QMux|X[1]~1_combout\ : std_logic;
SIGNAL \QMux|X[2]~2_combout\ : std_logic;
SIGNAL \RegQ|Q[2]~feeder_combout\ : std_logic;
SIGNAL \QAdder|FA_array:3:FA|temp_sum[0]~0_combout\ : std_logic;
SIGNAL \QMux|X[3]~3_combout\ : std_logic;
SIGNAL \Err$latch~combout\ : std_logic;
SIGNAL \Selector3~1_combout\ : std_logic;
SIGNAL \y.S2~q\ : std_logic;
SIGNAL \RegA|Q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RegQ|Q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RegR|Q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RegB|Q\ : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_Clock <= Clock;
ww_Resetn <= Resetn;
ww_s <= s;
ww_A <= A;
ww_B <= B;
R <= ww_R;
Q <= ww_Q;
Err <= ww_Err;
Done <= ww_Done;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\Resetn~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \Resetn~input_o\);

\Clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \Clock~input_o\);

-- Location: LCCOMB_X19_Y1_N20
\Selector3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (\y.S0~q\ & (\s~input_o\ & !\y.S1~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S0~q\,
	datab => \s~input_o\,
	datad => \y.S1~q\,
	combout => \Selector3~0_combout\);

-- Location: LCCOMB_X19_Y1_N16
\Selector2~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector2~1_combout\ = (!\y.S0~q\ & \s~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S0~q\,
	datab => \s~input_o\,
	combout => \Selector2~1_combout\);

-- Location: IOOBUF_X20_Y0_N2
\R[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegR|Q\(0),
	devoe => ww_devoe,
	o => \R[0]~output_o\);

-- Location: IOOBUF_X22_Y0_N2
\R[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegR|Q\(1),
	devoe => ww_devoe,
	o => \R[1]~output_o\);

-- Location: IOOBUF_X14_Y0_N9
\R[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegR|Q\(2),
	devoe => ww_devoe,
	o => \R[2]~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\R[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegR|Q\(3),
	devoe => ww_devoe,
	o => \R[3]~output_o\);

-- Location: IOOBUF_X31_Y0_N2
\Q[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegQ|Q\(0),
	devoe => ww_devoe,
	o => \Q[0]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\Q[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegQ|Q\(1),
	devoe => ww_devoe,
	o => \Q[1]~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\Q[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegQ|Q\(2),
	devoe => ww_devoe,
	o => \Q[2]~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\Q[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RegQ|Q\(3),
	devoe => ww_devoe,
	o => \Q[3]~output_o\);

-- Location: IOOBUF_X10_Y0_N9
\Err~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Err$latch~combout\,
	devoe => ww_devoe,
	o => \Err~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\Done~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \y.S2~q\,
	devoe => ww_devoe,
	o => \Done~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\Clock~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Clock,
	o => \Clock~input_o\);

-- Location: CLKCTRL_G17
\Clock~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Clock~inputclkctrl_outclk\);

-- Location: IOIBUF_X12_Y0_N8
\B[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: IOIBUF_X16_Y0_N22
\Resetn~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Resetn,
	o => \Resetn~input_o\);

-- Location: CLKCTRL_G19
\Resetn~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Resetn~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Resetn~inputclkctrl_outclk\);

-- Location: FF_X19_Y1_N21
\RegB|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~input_o\,
	asdata => \B[2]~input_o\,
	clrn => \Resetn~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegB|Q\(2));

-- Location: IOIBUF_X22_Y0_N8
\B[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: FF_X19_Y1_N17
\RegB|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~input_o\,
	asdata => \B[1]~input_o\,
	clrn => \Resetn~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegB|Q\(1));

-- Location: LCCOMB_X19_Y1_N4
\IsZero|ISZERO~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \IsZero|ISZERO~0_combout\ = (!\RegB|Q\(3) & (!\RegB|Q\(2) & (\Resetn~input_o\ & !\RegB|Q\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegB|Q\(3),
	datab => \RegB|Q\(2),
	datac => \Resetn~input_o\,
	datad => \RegB|Q\(1),
	combout => \IsZero|ISZERO~0_combout\);

-- Location: IOIBUF_X24_Y0_N1
\B[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: LCCOMB_X20_Y1_N12
\RegB|Q[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegB|Q[0]~feeder_combout\ = \B[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \B[0]~input_o\,
	combout => \RegB|Q[0]~feeder_combout\);

-- Location: FF_X20_Y1_N13
\RegB|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~input_o\,
	d => \RegB|Q[0]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegB|Q\(0));

-- Location: IOIBUF_X12_Y0_N1
\B[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: LCCOMB_X19_Y1_N6
\RegB|Q[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegB|Q[3]~feeder_combout\ = \B[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \B[3]~input_o\,
	combout => \RegB|Q[3]~feeder_combout\);

-- Location: FF_X19_Y1_N7
\RegB|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~input_o\,
	d => \RegB|Q[3]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegB|Q\(3));

-- Location: IOIBUF_X29_Y0_N1
\A[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: FF_X21_Y1_N21
\RegA|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \A[2]~input_o\,
	clrn => \Resetn~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|Q\(2));

-- Location: IOIBUF_X29_Y0_N8
\A[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: LCCOMB_X21_Y1_N30
\RegA|Q[1]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegA|Q[1]~feeder_combout\ = \A[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \A[1]~input_o\,
	combout => \RegA|Q[1]~feeder_combout\);

-- Location: FF_X21_Y1_N31
\RegA|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RegA|Q[1]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|Q\(1));

-- Location: LCCOMB_X20_Y1_N4
\RMux|X[1]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[1]~1_combout\ = \RegB|Q\(1) $ (\RegR|Q\(1) $ (((!\RegR|Q\(0) & \RegB|Q\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegB|Q\(1),
	datab => \RegR|Q\(1),
	datac => \RegR|Q\(0),
	datad => \RegB|Q\(0),
	combout => \RMux|X[1]~1_combout\);

-- Location: LCCOMB_X20_Y1_N28
\RMux|X[1]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[1]~2_combout\ = (\y.S1~q\ & ((\RMux|X[1]~1_combout\))) # (!\y.S1~q\ & (\RegA|Q\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datac => \RegA|Q\(1),
	datad => \RMux|X[1]~1_combout\,
	combout => \RMux|X[1]~2_combout\);

-- Location: IOIBUF_X33_Y16_N8
\s~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s,
	o => \s~input_o\);

-- Location: LCCOMB_X19_Y1_N18
\Selector1~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\y.S1~q\) # (\s~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \y.S1~q\,
	datad => \s~input_o\,
	combout => \Selector1~0_combout\);

-- Location: LCCOMB_X19_Y1_N26
\y.S0~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \y.S0~feeder_combout\ = \Selector1~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Selector1~0_combout\,
	combout => \y.S0~feeder_combout\);

-- Location: FF_X19_Y1_N27
\y.S0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \y.S0~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y.S0~q\);

-- Location: LCCOMB_X19_Y1_N24
\FSM_outputs~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \FSM_outputs~0_combout\ = (\s~input_o\ & (\Resetn~input_o\ & !\RegB|Q\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \s~input_o\,
	datac => \Resetn~input_o\,
	datad => \RegB|Q\(2),
	combout => \FSM_outputs~0_combout\);

-- Location: LCCOMB_X19_Y1_N28
\FSM_outputs~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \FSM_outputs~1_combout\ = (!\RegB|Q\(3) & (!\RegB|Q\(0) & (!\RegB|Q\(1) & \FSM_outputs~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegB|Q\(3),
	datab => \RegB|Q\(0),
	datac => \RegB|Q\(1),
	datad => \FSM_outputs~0_combout\,
	combout => \FSM_outputs~1_combout\);

-- Location: LCCOMB_X19_Y1_N0
\Selector5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector5~0_combout\ = (\y.S1~q\) # ((!\y.S0~q\ & !\FSM_outputs~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datac => \y.S0~q\,
	datad => \FSM_outputs~1_combout\,
	combout => \Selector5~0_combout\);

-- Location: IOIBUF_X31_Y0_N8
\A[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LCCOMB_X24_Y1_N8
\RegA|Q[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegA|Q[3]~feeder_combout\ = \A[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \A[3]~input_o\,
	combout => \RegA|Q[3]~feeder_combout\);

-- Location: FF_X24_Y1_N9
\RegA|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RegA|Q[3]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|Q\(3));

-- Location: LCCOMB_X20_Y1_N10
\RMux|X[3]~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[3]~6_combout\ = \RegB|Q\(3) $ (\RegR|Q\(3) $ (\Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegB|Q\(3),
	datac => \RegR|Q\(3),
	datad => \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\,
	combout => \RMux|X[3]~6_combout\);

-- Location: LCCOMB_X20_Y1_N26
\RMux|X[3]~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[3]~7_combout\ = (\y.S1~q\ & ((\RMux|X[3]~6_combout\))) # (!\y.S1~q\ & (\RegA|Q\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegA|Q\(3),
	datac => \y.S1~q\,
	datad => \RMux|X[3]~6_combout\,
	combout => \RMux|X[3]~7_combout\);

-- Location: FF_X20_Y1_N27
\RegR|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RMux|X[3]~7_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegR|Q\(3));

-- Location: LCCOMB_X20_Y1_N18
\Selector4~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = ((\RegB|Q\(3) & (\RegR|Q\(3) & !\Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\)) # (!\RegB|Q\(3) & ((\RegR|Q\(3)) # (!\Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\)))) # (!\y.S1~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datab => \RegB|Q\(3),
	datac => \RegR|Q\(3),
	datad => \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\,
	combout => \Selector4~0_combout\);

-- Location: LCCOMB_X20_Y1_N30
ER : cycloneiv_lcell_comb
-- Equation(s):
-- \ER~combout\ = (\Selector5~0_combout\ & ((\Selector4~0_combout\))) # (!\Selector5~0_combout\ & (\ER~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ER~combout\,
	datac => \Selector5~0_combout\,
	datad => \Selector4~0_combout\,
	combout => \ER~combout\);

-- Location: FF_X20_Y1_N29
\RegR|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RMux|X[1]~2_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegR|Q\(1));

-- Location: LCCOMB_X20_Y1_N24
\RMux|X[1]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[1]~3_combout\ = (\RegB|Q\(1) & (\RegR|Q\(1) & ((\RegR|Q\(0)) # (!\RegB|Q\(0))))) # (!\RegB|Q\(1) & (((\RegR|Q\(0)) # (\RegR|Q\(1))) # (!\RegB|Q\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegB|Q\(1),
	datab => \RegB|Q\(0),
	datac => \RegR|Q\(0),
	datad => \RegR|Q\(1),
	combout => \RMux|X[1]~3_combout\);

-- Location: LCCOMB_X20_Y1_N22
\RMux|X[2]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[2]~4_combout\ = (\y.S1~q\ & (\RegB|Q\(2) $ (\RegR|Q\(2) $ (!\RMux|X[1]~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datab => \RegB|Q\(2),
	datac => \RegR|Q\(2),
	datad => \RMux|X[1]~3_combout\,
	combout => \RMux|X[2]~4_combout\);

-- Location: LCCOMB_X20_Y1_N14
\RMux|X[2]~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[2]~5_combout\ = (\RMux|X[2]~4_combout\) # ((!\y.S1~q\ & \RegA|Q\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datac => \RegA|Q\(2),
	datad => \RMux|X[2]~4_combout\,
	combout => \RMux|X[2]~5_combout\);

-- Location: FF_X20_Y1_N15
\RegR|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RMux|X[2]~5_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegR|Q\(2));

-- Location: LCCOMB_X20_Y1_N6
\Subtractor|FA_array:2:FA|temp_sum[1]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\ = (\RegB|Q\(2) & ((!\RMux|X[1]~3_combout\) # (!\RegR|Q\(2)))) # (!\RegB|Q\(2) & (!\RegR|Q\(2) & !\RMux|X[1]~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegB|Q\(2),
	datac => \RegR|Q\(2),
	datad => \RMux|X[1]~3_combout\,
	combout => \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\);

-- Location: LCCOMB_X20_Y1_N0
\Selector2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (\y.S1~q\ & ((\RegR|Q\(3) & ((!\Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\) # (!\RegB|Q\(3)))) # (!\RegR|Q\(3) & (!\RegB|Q\(3) & !\Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegR|Q\(3),
	datab => \RegB|Q\(3),
	datac => \y.S1~q\,
	datad => \Subtractor|FA_array:2:FA|temp_sum[1]~0_combout\,
	combout => \Selector2~0_combout\);

-- Location: LCCOMB_X20_Y1_N20
\Selector2~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector2~2_combout\ = (\Selector2~0_combout\) # ((\Selector2~1_combout\ & ((\RegB|Q\(0)) # (!\IsZero|ISZERO~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector2~1_combout\,
	datab => \IsZero|ISZERO~0_combout\,
	datac => \RegB|Q\(0),
	datad => \Selector2~0_combout\,
	combout => \Selector2~2_combout\);

-- Location: FF_X20_Y1_N21
\y.S1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~input_o\,
	d => \Selector2~2_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y.S1~q\);

-- Location: IOIBUF_X33_Y16_N1
\A[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: LCCOMB_X21_Y1_N24
\RegA|Q[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegA|Q[0]~feeder_combout\ = \A[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \A[0]~input_o\,
	combout => \RegA|Q[0]~feeder_combout\);

-- Location: FF_X21_Y1_N25
\RegA|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RegA|Q[0]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|Q\(0));

-- Location: LCCOMB_X20_Y1_N2
\RMux|X[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RMux|X[0]~0_combout\ = (\y.S1~q\ & (\RegB|Q\(0) $ ((\RegR|Q\(0))))) # (!\y.S1~q\ & (((\RegA|Q\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110111101100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegB|Q\(0),
	datab => \RegR|Q\(0),
	datac => \y.S1~q\,
	datad => \RegA|Q\(0),
	combout => \RMux|X[0]~0_combout\);

-- Location: LCCOMB_X20_Y1_N8
\RegR|Q[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegR|Q[0]~feeder_combout\ = \RMux|X[0]~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \RMux|X[0]~0_combout\,
	combout => \RegR|Q[0]~feeder_combout\);

-- Location: FF_X20_Y1_N9
\RegR|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RegR|Q[0]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegR|Q\(0));

-- Location: LCCOMB_X21_Y1_N26
\QMux|X[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \QMux|X[0]~0_combout\ = (\y.S1~q\ & !\RegQ|Q\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \y.S1~q\,
	datad => \RegQ|Q\(0),
	combout => \QMux|X[0]~0_combout\);

-- Location: FF_X21_Y1_N17
\RegQ|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \QMux|X[0]~0_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegQ|Q\(0));

-- Location: LCCOMB_X21_Y1_N16
\QMux|X[1]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \QMux|X[1]~1_combout\ = (\y.S1~q\ & (\RegQ|Q\(0) $ (\RegQ|Q\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \y.S1~q\,
	datac => \RegQ|Q\(0),
	datad => \RegQ|Q\(1),
	combout => \QMux|X[1]~1_combout\);

-- Location: FF_X21_Y1_N27
\RegQ|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \QMux|X[1]~1_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegQ|Q\(1));

-- Location: LCCOMB_X21_Y1_N18
\QMux|X[2]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \QMux|X[2]~2_combout\ = (\y.S1~q\ & (\RegQ|Q\(2) $ (((\RegQ|Q\(0) & \RegQ|Q\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y.S1~q\,
	datab => \RegQ|Q\(0),
	datac => \RegQ|Q\(2),
	datad => \RegQ|Q\(1),
	combout => \QMux|X[2]~2_combout\);

-- Location: LCCOMB_X21_Y1_N8
\RegQ|Q[2]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RegQ|Q[2]~feeder_combout\ = \QMux|X[2]~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \QMux|X[2]~2_combout\,
	combout => \RegQ|Q[2]~feeder_combout\);

-- Location: FF_X21_Y1_N9
\RegQ|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \RegQ|Q[2]~feeder_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegQ|Q\(2));

-- Location: LCCOMB_X21_Y1_N28
\QAdder|FA_array:3:FA|temp_sum[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \QAdder|FA_array:3:FA|temp_sum[0]~0_combout\ = \RegQ|Q\(3) $ (((\RegQ|Q\(0) & (\RegQ|Q\(2) & \RegQ|Q\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegQ|Q\(3),
	datab => \RegQ|Q\(0),
	datac => \RegQ|Q\(2),
	datad => \RegQ|Q\(1),
	combout => \QAdder|FA_array:3:FA|temp_sum[0]~0_combout\);

-- Location: LCCOMB_X21_Y1_N22
\QMux|X[3]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \QMux|X[3]~3_combout\ = (\y.S1~q\ & \QAdder|FA_array:3:FA|temp_sum[0]~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \y.S1~q\,
	datad => \QAdder|FA_array:3:FA|temp_sum[0]~0_combout\,
	combout => \QMux|X[3]~3_combout\);

-- Location: FF_X21_Y1_N23
\RegQ|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \QMux|X[3]~3_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	ena => \ER~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegQ|Q\(3));

-- Location: LCCOMB_X19_Y1_N30
\Err$latch\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Err$latch~combout\ = (\y.S0~q\ & (\Err$latch~combout\)) # (!\y.S0~q\ & ((\FSM_outputs~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \y.S0~q\,
	datac => \Err$latch~combout\,
	datad => \FSM_outputs~1_combout\,
	combout => \Err$latch~combout\);

-- Location: LCCOMB_X19_Y1_N22
\Selector3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector3~1_combout\ = (\Selector3~0_combout\) # ((\y.S0~q\ & ((!\Selector4~0_combout\))) # (!\y.S0~q\ & (\FSM_outputs~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector3~0_combout\,
	datab => \FSM_outputs~1_combout\,
	datac => \y.S0~q\,
	datad => \Selector4~0_combout\,
	combout => \Selector3~1_combout\);

-- Location: FF_X19_Y1_N23
\y.S2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	d => \Selector3~1_combout\,
	clrn => \Resetn~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y.S2~q\);

ww_R(0) <= \R[0]~output_o\;

ww_R(1) <= \R[1]~output_o\;

ww_R(2) <= \R[2]~output_o\;

ww_R(3) <= \R[3]~output_o\;

ww_Q(0) <= \Q[0]~output_o\;

ww_Q(1) <= \Q[1]~output_o\;

ww_Q(2) <= \Q[2]~output_o\;

ww_Q(3) <= \Q[3]~output_o\;

ww_Err <= \Err~output_o\;

ww_Done <= \Done~output_o\;
END structure;


