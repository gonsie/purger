for i in (seq 0 3)
    echo "Fixing up mcu # $i"
    set -l j (math "$i * 2")
    set -l k (math "$i *2 +1")
    echo "   j=$j  k=$k"

    sed -E -i '' s/"mcu_bscan_ctl\.0\."/"mcu_bscan_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_drif_ctl\.0\."/"mcu_drif_ctl\.$i\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_fbd_dp\.0\."/"mcu_fbd_dp\.$j\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_fbd_dp\.1\."/"mcu_fbd_dp\.$k\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_fbdic_ctl\.0\."/"mcu_fbdic_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_fbdird_dp\.0\."/"mcu_fbdird_dp\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_fdoklu_ctl\.0\."/"mcu_fdoklu_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_fdout_ctl\.0\."/"mcu_fdout_ctl\.$i\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_l2if_ctl\.0\."/"mcu_l2if_ctl\.$j\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_l2if_ctl\.1\."/"mcu_l2if_ctl\.$k\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_l2rdmx_dp\.0\."/"mcu_l2rdmx_dp\.$i\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_lndskw_dp\.0\."/"mcu_lndskw_dp\.$j\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_lndskw_dp\.1\."/"mcu_lndskw_dp\.$k\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_mbist_ctl\.0\."/"mcu_mbist_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_rdata_ctl\.0\."/"mcu_rdata_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_rdpctl_ctl\.0\."/"mcu_rdpctl_ctl\.$i\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_readdp_dp\.0\."/"mcu_readdp_dp\.$j\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_readdp_dp\.1\."/"mcu_readdp_dp\.$k\."/g mcu.vSyn.gates.$i

    sed -E -i '' s/"mcu_ucb_ctl\.0\."/"mcu_ucb_ctl\.$i\."/g mcu.vSyn.gates.$i
    sed -E -i '' s/"mcu_wrdp_dp\.0\."/"mcu_wrdp_dp\.$i\."/g mcu.vSyn.gates.$i
end
