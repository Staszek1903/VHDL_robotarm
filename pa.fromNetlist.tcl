
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name project_SW -dir "E:/programowanie/xilinx_projects/project_SW/planAhead_run_2" -part xc3s50atq144-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/programowanie/xilinx_projects/project_SW/top_level.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/programowanie/xilinx_projects/project_SW} }
set_property target_constrs_file "top_level.ucf" [current_fileset -constrset]
add_files [list {top_level.ucf}] -fileset [get_property constrset [current_run]]
link_design
