cd ~/hop/scripts
tar zxvf Xilinx_Vivado_SDK_Lin_2015.2_0626_1.tar.gz
sudo Xilinx_Vivado_SDK_Lin_2015.2_0626_1/xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms -b Install --config install_config.txt --location /opt/Xilinx
sudo cp ~/hop/scripts/init.tcl /opt/Xilinx/Vivado/2015.2/scripts/
/opt/Xilinx/Vivado/2015.2/bin/vivado &