module multiplicand_to_y(m, y); //1 multiplicand_to_y module equals 64 m_to_y modules
	input[63:0] m;
	output[127:0] y;
	
	m_to_y m_to_y_0({m[0],1'b0}, y[1:0]); //special exception of lsb
	m_to_y m_to_y_1(m[1:0], y[3:2]);
	m_to_y m_to_y_2(m[2:1], y[5:4]);
	m_to_y m_to_y_3(m[3:2], y[7:6]);
	m_to_y m_to_y_4(m[4:3], y[9:8]);
	m_to_y m_to_y_5(m[5:4], y[11:10]);
	m_to_y m_to_y_6(m[6:5], y[13:12]);
	m_to_y m_to_y_7(m[7:6], y[15:14]);
	m_to_y m_to_y_8(m[8:7], y[17:16]);
	m_to_y m_to_y_9(m[9:8], y[19:18]);
	
	m_to_y m_to_y_10(m[10:9], y[21:20]);
	m_to_y m_to_y_11(m[11:10], y[23:22]);
	m_to_y m_to_y_12(m[12:11], y[25:24]);
	m_to_y m_to_y_13(m[13:12], y[27:26]);
	m_to_y m_to_y_14(m[14:13], y[29:28]);
	m_to_y m_to_y_15(m[15:14], y[31:30]);
	m_to_y m_to_y_16(m[16:15], y[33:32]);
	m_to_y m_to_y_17(m[17:16], y[35:34]);
	m_to_y m_to_y_18(m[18:17], y[37:36]);
	m_to_y m_to_y_19(m[19:18], y[39:38]);
	
	m_to_y m_to_y_20(m[20:19], y[41:40]);
	m_to_y m_to_y_21(m[21:20], y[43:42]);
	m_to_y m_to_y_22(m[22:21], y[45:44]);
	m_to_y m_to_y_23(m[23:22], y[47:46]);
	m_to_y m_to_y_24(m[24:23], y[49:48]);
	m_to_y m_to_y_25(m[25:24], y[51:50]);
	m_to_y m_to_y_26(m[26:25], y[53:52]);
	m_to_y m_to_y_27(m[27:26], y[55:54]);
	m_to_y m_to_y_28(m[28:27], y[57:56]);
	m_to_y m_to_y_29(m[29:28], y[59:58]);
	
	m_to_y m_to_y_30(m[30:29], y[61:60]);
	m_to_y m_to_y_31(m[31:30], y[63:62]);
	m_to_y m_to_y_32(m[32:31], y[65:64]);
	m_to_y m_to_y_33(m[33:32], y[67:66]);
	m_to_y m_to_y_34(m[34:33], y[69:68]);
	m_to_y m_to_y_35(m[35:34], y[71:70]);
	m_to_y m_to_y_36(m[36:35], y[73:72]);
	m_to_y m_to_y_37(m[37:36], y[75:74]);
	m_to_y m_to_y_38(m[38:37], y[77:76]);
	m_to_y m_to_y_39(m[39:38], y[79:78]);
	
	m_to_y m_to_y_40(m[40:39], y[81:80]);
	m_to_y m_to_y_41(m[41:40], y[83:82]);
	m_to_y m_to_y_42(m[42:41], y[85:84]);
	m_to_y m_to_y_43(m[43:42], y[87:86]);
	m_to_y m_to_y_44(m[44:43], y[89:88]);
	m_to_y m_to_y_45(m[45:44], y[91:90]);
	m_to_y m_to_y_46(m[46:45], y[93:92]);
	m_to_y m_to_y_47(m[47:46], y[95:94]);
	m_to_y m_to_y_48(m[48:47], y[97:96]);
	m_to_y m_to_y_49(m[49:48], y[99:98]);
	
	m_to_y m_to_y_50(m[50:49], y[101:100]);
	m_to_y m_to_y_51(m[51:50], y[103:102]);
	m_to_y m_to_y_52(m[52:51], y[105:104]);
	m_to_y m_to_y_53(m[53:52], y[107:106]);
	m_to_y m_to_y_54(m[54:53], y[109:108]);
	m_to_y m_to_y_55(m[55:54], y[111:110]);
	m_to_y m_to_y_56(m[56:55], y[113:112]);
	m_to_y m_to_y_57(m[57:56], y[115:114]);
	m_to_y m_to_y_58(m[58:57], y[117:116]);
	m_to_y m_to_y_59(m[59:58], y[119:118]);
	
	m_to_y m_to_y_60(m[60:59], y[121:120]);
	m_to_y m_to_y_61(m[61:60], y[123:122]);
	m_to_y m_to_y_62(m[62:61], y[125:124]);
	m_to_y m_to_y_63(m[63:62], y[127:126]);
endmodule 