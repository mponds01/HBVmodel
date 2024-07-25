using Plots
using StatsPlots
using DelimitedFiles
using Plots.PlotMeasures
using DocStringExtensions
using Distributed
 using Dates
using DelimitedFiles
using CSV
#@everywhere using Plots
using Statistics
using DocStringExtensions
using DataFrames
using Random
using LaTeXStrings
"""
This function selects the maxima and minima of all WB Sr,def estimates for each catchment
    $SIGNATURES
"""

function loop_ranges_srdef()
    rcps=["rcp45", "rcp85"]
    for (i, rcp) in enumerate(rcps)
    #rcms = readdir(local_path*rcp)
        rcms = ["CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CNRM-ALADIN53_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day",
                                "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_CLMcom-CCLM4-8-17_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_SMHI-RCA4_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_IPSL-INERIS-WRF331F_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day",
                                "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day"]
        for (j,rcm) in enumerate(rcms)
            ranges_srdef(rcp,rcm)
        end
    end
    return
end

function ranges_srdef(rcp, rcm)
    local_path="/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/"
    folder_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Srdef_ranges/"
    catchments = ["Defreggental", "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]
    mode =0
    for (c, catchment_name) in enumerate(catchments)

        mod_past = CSV.read(local_path*catchment_name*"/"*rcp*"/"*rcm*"/1981_GEV_T_total_titled.csv", DataFrame, decimal = '.', delim = ',')
        if rcm[1:4] == "MOHC"
            mod_future = CSV.read(local_path*catchment_name*"/"*rcp*"/"*rcm*"/2066_GEV_T_total_titled.csv",DataFrame, decimal = '.', delim = ',')
        else
            mod_future = CSV.read(local_path*catchment_name*"/"*rcp*"/"*rcm*"/2068_GEV_T_total_titled.csv",DataFrame, decimal = '.', delim = ',')
        end
        obs_past = CSV.read(local_path*catchment_name*"/"*rcp*"/"*rcm*"/Past_GEV_T_total_titled.csv", DataFrame, decimal = '.', delim = ',')

        minima_tw=zeros(4)
        maxima_tw=zeros(4)


        OP_min_grass = minimum(-obs_past[:,2])
        MP_min_grass = minimum(-mod_past[:,2])
        MF_min_grass = minimum(-mod_future[:,2])

        OP_max_grass = maximum(-obs_past[:,2])
        MP_max_grass = maximum(-mod_past[:,2])
        MF_max_grass = maximum(-mod_future[:,2])

        OP_min_forest = minimum(-obs_past[:,3])
        MP_min_forest = minimum(-mod_past[:,3])
        MF_min_forest = minimum(-mod_future[:,3])

        OP_max_forest = maximum(-obs_past[:,3])
        MP_max_forest = maximum(-mod_past[:,3])
        MF_max_forest = maximum(-mod_future[:,3])

        MF_min_grass_ = (OP_min_grass)-MP_min_grass+MF_min_grass
        MF_max_grass_ = MF_min_grass_-MF_min_grass+MF_max_grass
        MF_min_forest_ = (OP_min_forest)-MP_min_forest+MF_min_forest
        MF_max_forest_ = MF_min_forest_-MF_min_forest+MF_max_forest

        minima_tw = [OP_min_grass, MF_min_grass_, OP_min_forest, MF_min_forest_]
        maxima_tw = [OP_max_grass, MF_max_grass_, OP_max_forest, MF_max_forest_]


        index = ["OP_grass", "MF_grass", "OP_forest", "MF_forest"]#, "MF_forest"]
        df = DataFrame(index = index, TW_min = minima_tw, TW_max = maxima_tw)#, HG_min = minima_hg, HG_max = maxima_hg)
        CSV.write(folder_path*"/"*rcp*"/"*rcm*"/"*catchment_name*"_srdef_range.csv", df)
    end
    return
end

#ranges_srdef("rcp85", "CNRM-CERFACS-CNRM-CM5_rcp85_r1i1p1_CLMcom-CCLM4-8-17_v1_day")
#loop_ranges_srdef()



"""
This function illustrates the dependancy of the parameterranges on samples of calibrations used
    $SIGNATURES
    returns a plot
"""


function plot_parameter_runs_vs_range()

    local_path="/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/"
    folder_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Test_#runs/"
    catchments = ["Defreggental"]#, "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]

    vegetationtype = ["Forest", "Grass"]
    samplesize = [50, 100, 300, 500, 3805]
    timeframe = ["OP", "MP", "MF"]
    minmax = ["min", "max"]
    Color = palette(:tab10)
    Markers = [:dtriangle, :circle, :rectangle]
    colours = ["orange", "pink", "royalblue"]
    # labels = [ep_method*" Observed Past", ep_method*" Modelled Past", ep_method*" Modelled Future", "Calibrated"]


    ranges = Plots.plot()
    for (s, sz) in enumerate(samplesize)
        # if sz==300
        #     data = CSV.read(folder_path*"Defreggental_srdef_range.csv", DataFrame, decimal = '.', delim = ',')
        # else
            data = CSV.read(folder_path*"Defreggental_srdef_range_test"*string(sz)*".csv", DataFrame, decimal = '.', delim = ',')
        # end

        for (t,tf) in enumerate(timeframe)
            for (v,vt) in enumerate(vegetationtype)
                for (m,mm) in enumerate(minmax)


                        # if c>1
                        #     setlabel = [false, false, false, false]
                        # elseif c ==1
                        #     setlabel = labels
                        # end
                        # if e==1
                        if s==1
                            legend=tf*vt*mm
                        else
                            legend=false
                        end
                        # println("info for ss x tf",sz, tf, mm)
                        # println(data[t+(v-1)*3,m+1])
                        scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker = Markers[v], markerstrokewidth=0, label=legend, legend=:outerright)
                end
            end
        end
    end
    xaxis!("Samplesize")
    yaxis!("Sr,def,range [m]")
    xticks!([1:5;],["50", "100", "300", "500", "3805"])
    display(ranges)
    Plots.Plots.savefig(folder_path*"Runs_vs_range_comparison.png")
end

function plot_parameter_range_violins_S_NS()

    local_path="/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/"
    folder_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Rootzone/"
    all_plots = []
    legend_plot = []
    legends = []
    catchments = ["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal"]
    Catchment_Height = [917, 1315, 1476, 1776, 2233, 2558]
    vegetationtype = ["forest", "grass"]
    timeframe = ["OP", "MF"]
    Color = [:blue3, :firebrick]

    for (v,vt) in enumerate(vegetationtype)
        cm_plot = []
        for (c,cm) in enumerate(catchments)
            rcps = ["RCP45", "RCP85"]
            nsplot = Plots.plot(fontsize=14)
            for (r,rcp) in enumerate(rcps)
                all_mf= []
                mean_mf =[]
                rcms = ["CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CNRM-ALADIN53_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day",
                     "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_CLMcom-CCLM4-8-17_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_SMHI-RCA4_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_IPSL-INERIS-WRF331F_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day",
                                             "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day"]
                cal_S = CSV.read(local_path*"02 Output: S Calibrations/"*cm*"/Best/Parameterfit_less_dates_snow_redistr_1M_best_300.csv", DataFrame, decimal='.', delim = ',')
                cal_S = cal_S[:,10:29]
                cal_NS_OP = CSV.read(local_path*"02 Output: NS Calibrations/"*cm*"/Samples/"*rcp*"/NS_Parameterset_OP_"*rcp*"_"*rcms[1]*".csv", DataFrame, decimal='.', delim = ',')

                if r==1
                    if vt == "forest"
                        violin!([1], cal_S[:,17], color=:lightgrey, label="Calibrated", legend=false, linewidth=1)
                        violin!([2], cal_NS_OP[:,17], color=:grey, label="Observed Past",legend=false, linewidth=1)
                        # scatter!(ones(length(cal_NS_OP[:,17]))*2, cal_NS_OP[:,17], color=:black, label=false,legend=false,markersize=3)
                        scatter!(ones(length(cal_S[:,17])), [mean(cal_S[:,17])], color=:white, markersize=6, label=false)
                        # scatter!([1], cal_S[:,17], color=:black, label=false, legend=false,markersize=3)
                        scatter!([2], [mean(cal_NS_OP[:,17])], color=:white, markersize=6, label=false)
                    else
                        println(vt)
                        violin!([1], cal_S[:,18], color=:lightgrey, label="Calibrated", legend=false,linewidth=1)
                        violin!([2], cal_NS_OP[:,18], color=:grey, label="Observed Past", legend=false,linewidth=1)
                        # scatter!(ones(length(cal_S[:,18])), cal_S[:,18], color=:black, label=false, legend=false,markersize=3)
                        # scatter!(ones(length(cal_NS_OP[:,18]))*2, cal_NS_OP[:,18], color=:black, label=false,legend=false,markersize=3)
                        scatter!([1], [mean(cal_S[:,18])], color=:white, markersize=6, label=false)
                        scatter!([2], [mean(cal_NS_OP[:,18])], color=:white, markersize=6, label=false)
                    end #close vt loop
                end #close r==1 loop
                #for all rcms load data for srdefs
                for (j,rcm) in enumerate(rcms)
                    cal_NS_MF = CSV.read(local_path*"02 Output: NS Calibrations/"*cm*"/Samples/"*rcp*"/NS_Parameterset_MF_"*rcp*"_"*rcm*".csv", DataFrame, decimal='.', delim = ',')
                    if vt == "forest"
                        parameters_mf = cal_NS_MF[:,17]
                    else
                        parameters_mf = cal_NS_MF[:,18]
                    end
                    if size(parameters_mf)[1] ==5999
                        parameters_mf = parameters_mf[1:2999,:]
                    end
                    all_mf = push!(all_mf, parameters_mf[1])
                    mean_mf = push!(mean_mf,mean(parameters_mf[1]))
                end #ending all rcm loop
                println(length(mean_mf))
                println(2+r)
                violin!([2+r], all_mf, color=Color[r], legendfontsize=20,linewidth=1, label=false, legend=false)
                scatter!(ones(length(mean_mf))*(2+r), mean_mf, color=:black, label=false, legend=false,markersize=3)
                scatter!([2+r], [mean(all_mf)], color=:white, markersize=6, label=false)
            end #ending 2 rcp loop

            if v==1
                title!(cm*" ("*string(Catchment_Height[c])*"m)", titlefontsize=16, bottom_margin=10px)
                ylims!((0,500))
                if c==1
                    yticks!(Array(0:250:500), fontsize=20)
                end
            else
                ylims!((0,300))
            end
            if c == 1
                ylabel!("Sr,"*vt*" [mm]", yguidefontsize=20)
            else
                yticks!(Array(1:2),["",""])
            end

            xticks!(Array(1:4), [ "","", "", ""], fontsize=20)

            push!(cm_plot, nsplot)
        end #ending catchment loop
        total = Plots.plot(cm_plot[1],cm_plot[2],cm_plot[3],cm_plot[4],cm_plot[5],cm_plot[6], size=(2000,960), layout=(1,6), top_margin=20mm, left_margin=[20mm 0mm 0mm 0mm 0mm 0mm], minor_grid=false, grid=false, tickfontsize=20)
        push!(all_plots,total)

    end #ending vt-loop

    total_all = Plots.plot(all_plots[1],all_plots[2],size=(2000,960), layout=(2,1), top_margin=[20mm 0mm], left_margin=[20mm 0mm 0mm 0mm 0mm 0mm], minor_grid=false, grid=false, tickfontsize=20, titlefontsize=20)
    display(total_all)

    Plots.plot()
    scatter!([1],[0],  color=:white, markershape=:rect, markersize=7, markerstrokewidth= 0,label=" ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg1=plot!()
    display(leg1)
    push!(legends, leg1)

    Plots.plot()
    scatter!([2],[0],  color=:lightgrey, markershape=:rect, markersize=7, markerstrokewidth= 0,label=" Sr,cal",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg2=plot!()
    display(leg1)
    push!(legends, leg2)

    Plots.plot()
    scatter!([3], [0], color=:grey,  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" Sr,clim,past",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg3=plot!()
    push!(legends, leg3)

    Plots.plot()
    scatter!([4],[0], color=:blue3, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" Sr,clim,fut,rcp4.5",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg4=plot!()
    push!(legends, leg4)

    Plots.plot()
    scatter!([5],[0], color=:firebrick, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" Sr,clim,fut,rcp8.5",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg5=plot!()
    push!(legends, leg5)

    Plots.plot()
    scatter!([6],[0], color=:white, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg6=plot!()
    push!(legends, leg6)

    legend = Plots.plot(legends[1], legends[2], legends[3], legends[4], legends[5],legends[6], layout=(1,6), xticks=:none, yticks=:none, showaxis=false, grid=false, foreground_color_legend=:white, size=(2000,100), legendfontsize=20, titlefontsize=20, top_margin=0px)

    complete = Plots.plot(total_all, legend, size=(2200,800), layout=@layout([A{1.0w}; B{0.05h}]),top_margin =[10px 0px], left_margin=[20mm 0mm 0mm 0mm 0mm 0mm], minor_grid=false, grid=false, tickfontsize=20)
    display(complete)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/All_Catchments/Sr,def/Overview_plot_mergedmodels_total_L3.png")

    return
    end
# plot_parameter_range_violins_S_NS()


function plot_parameter_range_violins_NS()

    local_path="/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/"
    folder_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Rootzone/"
    all_plots = []
    legend_plot = []
    legends = []
    catchments = ["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal"]
    Catchment_Height = [917, 1315, 1476, 1776, 2233, 2558]
    vegetationtype = ["forest", "grass"]
    timeframe = ["OP", "MF"]
    Color = [:blue3, :firebrick]

    for (v,vt) in enumerate(vegetationtype)
        cm_plot = []
        for (c,cm) in enumerate(catchments)
            rcps = ["RCP45", "RCP85"]
            nsplot = Plots.plot(fontsize=14)
            for (r,rcp) in enumerate(rcps)
                all_mf= []
                mean_mf =[]
                rcms = ["CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CNRM-ALADIN53_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day",
                     "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_CLMcom-CCLM4-8-17_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_SMHI-RCA4_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_IPSL-INERIS-WRF331F_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day",
                                             "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day"]
                cal_S = CSV.read(local_path*"02 Output: S Calibrations/"*cm*"/Best/Parameterfit_less_dates_snow_redistr_1M_best_300.csv", DataFrame, decimal='.', delim = ',')
                cal_S = cal_S[:,10:29]
                cal_NS_OP = CSV.read(local_path*"02 Output: NS Calibrations/"*cm*"/Samples/"*rcp*"/NS_Parameterset_OP_"*rcp*"_"*rcms[1]*".csv", DataFrame, decimal='.', delim = ',')

                if r==1
                    if vt == "forest"
                        violin!([1], cal_NS_OP[:,17], color=:grey, label="Observed Past",legend=false, linewidth=1)
                        # scatter!(ones(length(cal_NS_OP[:,17])), cal_NS_OP[:,17], color=:black, label=false,legend=false,markersize=3)
                        scatter!([1], [mean(cal_NS_OP[:,17])], color=:white, markersize=6, label=false)
                    else
                        println(vt)
                        violin!([1], cal_NS_OP[:,18], color=:grey, label="Observed Past", legend=false,linewidth=1)
                        # scatter!(ones(length(cal_NS_OP[:,18])), cal_NS_OP[:,18], color=:black, label=false,legend=false,markersize=3)
                        scatter!([1], [mean(cal_NS_OP[:,18])], color=:white, markersize=6, label=false)
                    end #close vt loop
                end #close r==1 loop
                #for all rcms load data for srdefs
                for (j,rcm) in enumerate(rcms)
                    cal_NS_MF = CSV.read(local_path*"02 Output: NS Calibrations/"*cm*"/Samples/"*rcp*"/NS_Parameterset_MF_"*rcp*"_"*rcm*".csv", DataFrame, decimal='.', delim = ',')
                    if vt == "forest"
                        parameters_mf = cal_NS_MF[:,17]
                    else
                        parameters_mf = cal_NS_MF[:,18]
                    end
                    if size(parameters_mf)[1] ==5999
                        parameters_mf = parameters_mf[1:2999,:]
                    end
                    all_mf = push!(all_mf, parameters_mf[1])
                    mean_mf = push!(mean_mf,mean(parameters_mf[1]))
                end #ending all rcm loop
                println(length(mean_mf))
                println(1+r)
                violin!([1+r], all_mf, color=Color[r], legendfontsize=20,linewidth=1, label=false, legend=false)
                scatter!(ones(length(mean_mf))*(1+r), mean_mf, color=:black, label=false, legend=false,markersize=3)
                scatter!([1+r], [mean(all_mf)], color=:white, markersize=6, label=false)
            end #ending 2 rcp loop

            if v==1
                title!(cm*" ("*string(Catchment_Height[c])*"m)", titlefontsize=16)
                ylims!((0,350))
                if c==1
                    yticks!(Array(0:100:300), fontsize=20)
                end
            else
                ylims!((0,110))
                if c==1
                    yticks!(Array(0:25:110), fontsize=20)
                end
            end
            if c == 1
                ylabel!("Sr,"*vt*" [mm]", yguidefontsize=20)
            else
                yticks!(Array(1:2),["",""])
            end

            xticks!(Array(1:3), [ "","", ""], fontsize=20)

            push!(cm_plot, nsplot)
        end #ending catchment loop
        total = Plots.plot(cm_plot[1],cm_plot[2],cm_plot[3],cm_plot[4],cm_plot[5],cm_plot[6], size=(2400,800), layout=(1,6), top_margin=20mm, left_margin=[20mm 0mm 0mm 0mm 0mm 0mm], minor_grid=false, grid=false, tickfontsize=20, titlefontsize=20)
        push!(all_plots,total)

    end #ending vt-loop

    total_all = Plots.plot(all_plots[1],all_plots[2],size=(2000,600), layout=(2,1), top_margin=[20mm 0mm], left_margin=20mm, minor_grid=false, grid=false, tickfontsize=20)
    display(total_all)


    Plots.plot()
    scatter!([1], [0], color=:white,  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg1=plot!()
    push!(legends, leg1)

    Plots.plot()
    scatter!([2], [0], color=:grey,  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" Sr,clim,past",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg2=plot!()
    push!(legends, leg2)

    Plots.plot()
    scatter!([3],[0], color=:blue3, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" Sr,clim,fut,rcp4.5",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg3=plot!()
    push!(legends, leg3)

    Plots.plot()
    scatter!([4],[0], color=:firebrick, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" Sr,clim,fut,rcp8.5",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg4=plot!()
    push!(legends, leg4)

    Plots.plot()
    scatter!([5],[0], color=:white, markershape=:rect, markersize=7, markerstrokewidth= 0, label=" ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20))
    xaxis!((-1,0))
    leg5=plot!()
    push!(legends, leg5)

    legend = Plots.plot(legends[1], legends[2], legends[3], legends[4], legends[5], layout= (1,5), legend=:top,xticks=:none, yticks=:none, showaxis=false, grid=false, foreground_color_legend=:white, size=(1000,100), legendfontsize=20, titlefontsize=20, top_margin=0px)

    complete = Plots.plot(total_all,legend, size=(2000,800), layout=@layout([A{1.0w}; B{0.05h}]),top_margin =[10px 0px], left_margin=[20mm 0mm 0mm 0mm 0mm 0mm], minor_grid=false, grid=false, tickfontsize=20)
    display(complete)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/All_Catchments/Sr,def/Overview_plot_mergedmodels_total_NS_L3.png")

    return
    end
plot_parameter_range_violins_NS()
