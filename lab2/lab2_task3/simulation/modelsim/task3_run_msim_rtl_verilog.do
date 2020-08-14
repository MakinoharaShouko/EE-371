transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/lab2/lab2_task3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/lab2/lab2_task3/ram32x4.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/lab2/lab2_task3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/lab2/lab2_task3/seg7.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/lab2/lab2_task3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/lab2/lab2_task3/display.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/lab2/lab2_task3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/lab2/lab2_task3/address_display.sv}
vlog -sv -work work +incdir+C:/Users/Jiarong\ Qian/Documents/Course\ Materials/au2019/EE\ 371/lab2/lab2_task3 {C:/Users/Jiarong Qian/Documents/Course Materials/au2019/EE 371/lab2/lab2_task3/task3.sv}

