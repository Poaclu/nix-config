{ config, pkgs, lib, ... }: let
username = "poaclu";
in { 
  options = {
    shell = {
      btop = {
        enable = lib.mkOption {
          description = "Enable btop config for user config";
          type = lib.types.bool;
          default = true;
          example = false;
        };
        #refresh = lib.mkOption {
          #description = "Refresh rate in ms for btop";
          #type = lib.types.int;
          #default = 300;
          #example = 1000;
        #};
      };
    };
  };  
  config = lib.mkIf config.shell.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = true;
        force_tty = false;
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        vim_keys = false;
        rounded_corners = true;
        graph_symbol = "braille";
        graph_symbol_cpu = "default";
        graph_symbol_gpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";
        shown_boxes = "cpu mem net proc";
        update_ms = 2000;
        proc_sorting = "memory";
        proc_reversed = false;
        proc_tree = false;
        proc_colors = true;
        proc_gradient = true;
        proc_per_core = true;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = false;
        proc_left = false;
        proc_filter_kernel = false;
        proc_aggregate = false;
        cpu_graph_upper = "total";
        cpu_graph_lower = "total";
        show_gpu_info = "Auto";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_uptime = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        clock_format = "%X";
        background_update = true;
        mem_graphs = false;
        mem_below_net = false;
        zfs_arc_cached = true;
        show_swap = true;
        swap_disk = false;
        show_disks = false;
        only_physical = true;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graph_combined = false;
        net_download = 100;
        net_upload = 100;
        net_auto = true;
        net_sync = true;
        show_battery = true;
        selected_battery = "Auto";
        show_battery_watts = true;
        log_level = "WARNING";
        nvml_measure_pcie_speeds = true;
        gpu_mirror_graph = true;
      };
    };
  };
}
