transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/hw3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/hw3/reg_file.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/hw3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/hw3/fifo_ctrl.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/hw3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/hw3/fifo.sv}

