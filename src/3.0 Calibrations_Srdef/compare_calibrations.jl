using Plots
using ColorSchemes
using Statistics
# using Plotly
using DelimitedFiles
# using StatsPlots
# using PlotlyJS
using DataFrames
using Plots.PlotMeasures
using CSV
# using Colors
#using ColorBrewer
using LaTeXStrings
using GR

Farben_85= [palette(:reds)[1], :firebrick]
Farben_45= [palette(:blues)[1], :blue3]

function compare_calibrations()
    Catchments = ["Defreggental", "Feistritz", "Gailtal", "Pitztal", "Palten", "Silbertal"]
    obj_title = ["DEtot", "ENSE,Q","ENSE,logQ", "Eve,Q", "ENSE,FDC", "E,RE,AC1", "ENSE,AC,90", "ENSE,RC", "EAE,SC"]
    s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/"
    nr = 0
    cal_performance = zeros(6,9)
    val_performance = zeros(6,9)
    for (c,cm) in enumerate(Catchments)
        if cm =="Defreggental" || cm == "Pitztal"
            nr = 10
        elseif cm == "Feistritz"
            nr = 5
        elseif cm =="Gailtal" || cm == "Palten" || cm == "Silbertal"
            nr = 8
        end
        s_calibrations = readdlm(s_calibrations_path*cm*"/Best/Parameterfit_less_dates_snow_redistr_1M_best_300.csv", ',')[:,1:9]
        s_validations = readdlm(s_calibrations_path*cm*"/Validation/Parameterfit_1M_best_300_validation_"*string(nr)*"years.csv", ',')[:,1:9]

        for (o,ob) in enumerate(obj_title)
            if o ==1
                cal_performance[c,o] = 1- mean(s_calibrations[:,o])
                val_performance[c,o] = 1- mean(s_validations[:,o])
            else
                cal_performance[c,o] = mean(s_calibrations[:,o])
                val_performance[c,o] = mean(s_validations[:,o])
            end

        end
    end
    #cal_performace = DataFrame(cal_performance)
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Calibration_statistics", cal_performance, ',')
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Validation_statistics", val_performance, ',')

    hm = Plots.plot()
    hm_c = Plots.heatmap(cal_performance, c=:blues, title="Validation S", )
    for y in 1:1:6
        for x in 1:1:9
            t = string(cal_performance[y,x])[1:4]
            annotate!(x,y,t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45)
    yticks!([1:6;], Catchments )

    hm_v = Plots.heatmap(val_performance, c=:blues, title="Evaluation S")
    for y in 1:1:6
        for x in 1:1:9
            t = string(val_performance[y,x])[1:4]
            annotate!(x,y,t, :white, annotationfontsize=20)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45)
    yticks!([1:6;], Catchments)
    # Plots.plot(plots_obj[2], plots_obj[3], plots_obj[4], plots_obj[5], plots_obj[6], plots_obj[7], plots_obj[8], plots_obj[9], layout= (2,4), legend = false, size=(1800,1000), left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
    # Plots.savefig(path_to_save * "obj_Calibration_Validation_violin.png")

    total = Plots.plot(hm_c, hm_v, layout=(1,2), size=(1500,800))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Cal_Val_statistics")
    display(total)

    return
end

#compare_calibrations()

function compare_ns_calibrations()
    Catchments = ["Defreggental", "Feistritz", "Gailtal", "Pitztal", "Palten", "Silbertal"]
    obj_title = ["DEtot", "ENSE,Q","ENSE,logQ", "Eve,Q", "ENSE,FDC", "E,RE,AC1", "ENSE,AC,90", "ENSE,RC", "EAE,SC"]
    ns_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations_Srdef/"
    nr = 0
    cal_performance = zeros(6,9)
    val_performance = zeros(6,9)

    for (c,cm) in enumerate(Catchments)

        println(cm)
        if cm =="Defreggental" || cm == "Pitztal"
            nr = 10
        elseif cm == "Feistritz"
            nr = 5
        elseif cm =="Gailtal" || cm == "Palten" || cm == "Silbertal"
            nr = 8
        end
        if cm == "Pitztal"
            println("in loop")
            all_calibrations = zeros((1,30))
            all_validations = zeros((1,30))
        else
            all_calibrations = zeros((1,29))
            all_validations = zeros((1,29))
        end

        rcps=["rcp45", "rcp85"]#["rcp45", "rcp85"]

        for (i, rcp) in enumerate(rcps)
        #rcms = readdir(local_path*rcp)
                rcms = ["CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CNRM-ALADIN53_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day","ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day",
                 "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_CLMcom-CCLM4-8-17_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_SMHI-RCA4_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_IPSL-INERIS-WRF331F_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day",
                                         "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day"]
                for (j,rcm) in enumerate(rcms)


                    ns_calibrations = readdlm(ns_calibrations_path*cm*"/Calibrated/"*rcp*"/"*rcm*"/NS_Parameterfit_srdef_calibrated_combined.csv", ',')
                    ns_validations = readdlm(ns_calibrations_path*cm*"/Validation/"*rcp*"/"*rcm*"/NS_Parameterfit_srdef_validated.csv", ',')
                    # if length(ns_calibrations)>length(ns_validations)
                    #     ns_calibrations= ns_calibrations[1:length(ns_validations)]
                    # else
                    #     ns_validations= ns_validations[1:length(ns_calibrations)]
                    # end
                    for i in length(ns_calibrations)
                        all_calibrations = vcat(all_calibrations, ns_calibrations)
                        all_validations = vcat(all_validations, ns_validations)
                    end
                end
            end
            all_calibrations_d=DataFrame(all_calibrations, :auto)
            display(all_calibrations_d)
                println(size(all_calibrations_d))
                for (o, ob) in enumerate(obj_title)
                        if o ==1
                            cal_performance[c,o] = 1-mean(all_calibrations_d[:,o])
                            val_performance[c,o] = 1-mean(all_validations[:,o])
                        else
                            cal_performance[c,o] = mean(all_calibrations[:,o])
                            val_performance[c,o] = mean(all_validations[:,o])
                        end
                end
    end



    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Calibration_statistics", cal_performance, ',')
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Validation_statistics", val_performance, ',')

    hm = Plots.plot()
    hm_c = Plots.heatmap(cal_performance, c=:blues, title="Validation NS")
    for y in 1:1:6
        for x in 1:1:9
            t = string(cal_performance[y,x])[1:4]
            annotate!(x,y,t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45, )
    yticks!([1:6;], Catchments )

    hm_v = Plots.heatmap(val_performance, c=:blues, title="Evaluation NS")
    for y in 1:1:6
        for x in 1:1:9
            t = string(val_performance[y,x])[1:4]
            println(t)
            annotate!(x,y, t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45)
    yticks!([1:6;], Catchments)
    # Plots.plot(plots_obj[2], plots_obj[3], plots_obj[4], plots_obj[5], plots_obj[6], plots_obj[7], plots_obj[8], plots_obj[9], layout= (2,4), legend = false, size=(1800,1000), left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
    # Plots.savefig(path_to_save * "obj_Calibration_Validation_violin.png")

    total = Plots.plot(hm_c, hm_v, layout=(1,2), size=(2500,1000))
    display(total)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Cal_Val_statistics")



    return
end

#compare_ns_calibrations()

function plot_total()
    Catchments=["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal" ]
    Catchments_n=["Feistritztal", "Paltental *", "Gailtal°",  "Silbertal"*L"^*", "Defreggental", "Pitztal" ]

    #Catchments = ["Defreggental", "Feistritz", "Gailtal", "Pitztal", "Palten", "Silbertal"]
    obj_title = ["DEtot", "ENSE,Q","ENSE,logQ", "Eve,Q", "ENSE,FDC", "E,RE,AC1", "ENSE,AC,90", "ENSE,RC", "EAE,SC"]
    s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/02 Output: S Calibrations/"

    nr = 0
    cal_performance_s = zeros(6,9)
    val_performance_s = zeros(6,9)
    for (c,cm) in enumerate(Catchments)
        if cm =="Defreggental" || cm == "Pitztal"
            nr = 10
        elseif cm == "Feistritz"
            nr = 5
        elseif cm =="Gailtal" || cm == "Palten" || cm == "Silbertal"
            nr = 8
        end
        s_calibrations = readdlm(s_calibrations_path*cm*"/Best/Parameterfit_less_dates_snow_redistr_1M_best_300.csv", ',')[:,1:9]
        s_validations = readdlm(s_calibrations_path*cm*"/Validation/Parameterfit_1M_best_300_validation_"*string(nr)*"years.csv", ',')[:,1:9]

        for (o,ob) in enumerate(obj_title)
            if o ==1
                cal_performance_s[c,o] = 1- mean(s_calibrations[:,o])
                val_performance_s[c,o] = 1- mean(s_validations[:,o])
            else
                cal_performance_s[c,o] = mean(s_calibrations[:,o])
                val_performance_s[c,o] = mean(s_validations[:,o])
            end

        end
    end
    #cal_performace = DataFrame(cal_performance)
    #writedlm("/Volumes/Macintosh HD - Gegevens 1/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Calibration_statistics", cal_performance_s, ',')
    #writedlm("/Volumes/Macintosh HD - Gegevens 1/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Validation_statistics", val_performance_s, ',')

    hm = Plots.plot()
    hm_c_s = Plots.heatmap(cal_performance_s, c=:blues, title="Calibration S")
    for y in 1:1:6
        for x in 1:1:9
            t = string(cal_performance_s[y,x])[1:4]
            annotate!(x,y,t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45 )
    yticks!([1:6;], Catchments_n )

    hm_v_s = Plots.heatmap(val_performance_s, c=:blues, title="Evaluation S")
    for y in 1:1:6
        for x in 1:1:9
            t = string(val_performance_s[y,x])[1:4]
            annotate!(x,y,t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45)
    yticks!([1:6;], Catchments_n)
    # Plots.plot(plots_obj[2], plots_obj[3], plots_obj[4], plots_obj[5], plots_obj[6], plots_obj[7], plots_obj[8], plots_obj[9], layout= (2,4), legend = false, size=(1800,1000), left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
    # Plots.savefig(path_to_save * "obj_Calibration_Validation_violin.png")

    total_s = Plots.plot(hm_c_s, hm_v_s, layout=(1,2), size=(2500,1000))
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/S_Cal_Val_statistics")
    display(total_s)

    Catchments = ["Defreggental", "Feistritz", "Gailtal", "Pitztal", "Palten", "Silbertal"]
    obj_title = ["DEtot", "ENSE,Q","ENSE,logQ", "Eve,Q", "ENSE,FDC", "E,RE,AC1", "ENSE,AC,90", "ENSE,RC", "EAE,SC"]
    ns_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations_Srdef/"
    nr = 0
    cal_performance_ns = zeros(6,9)
    val_performance_ns = zeros(6,9)

    for (c,cm) in enumerate(Catchments)

        println(cm)
        if cm =="Defreggental" || cm == "Pitztal"
            nr = 10
        elseif cm == "Feistritz"
            nr = 5
        elseif cm =="Gailtal" || cm == "Palten" || cm == "Silbertal"
            nr = 8
        end
        if cm == "Pitztal"
            println("in loop")
            all_calibrations = zeros((1,30))
            all_validations = zeros((1,30))
        else
            all_calibrations = zeros((1,29))
            all_validations = zeros((1,29))
        end

        rcps=["rcp45", "rcp85"]#["rcp45", "rcp85"]

        for (i, rcp) in enumerate(rcps)
        #rcms = readdir(local_path*rcp)
                rcms = ["CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_CNRM-ALADIN53_v1_day", "CNRM-CERFACS-CNRM-CM5_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day","ICHEC-EC-EARTH_"*rcp*"_r3i1p1_DMI-HIRHAM5_v1_day",
                 "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_CLMcom-CCLM4-8-17_v1_day", "ICHEC-EC-EARTH_"*rcp*"_r12i1p1_SMHI-RCA4_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_IPSL-INERIS-WRF331F_v1_day", "IPSL-IPSL-CM5A-MR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_KNMI-RACMO22E_v1_day",
                                         "MOHC-HadGEM2-ES_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_CLMcom-CCLM4-8-17_v1_day", "MPI-M-MPI-ESM-LR_"*rcp*"_r1i1p1_SMHI-RCA4_v1_day"]
                for (j,rcm) in enumerate(rcms)


                    ns_calibrations = readdlm(ns_calibrations_path*cm*"/Calibrated/"*rcp*"/"*rcm*"/NS_Parameterfit_srdef_calibrated_combined.csv", ',')
                    ns_validations = readdlm(ns_calibrations_path*cm*"/Validation/"*rcp*"/"*rcm*"/NS_Parameterfit_srdef_validated.csv", ',')
                    # if length(ns_calibrations)>length(ns_validations)
                    #     ns_calibrations= ns_calibrations[1:length(ns_validations)]
                    # else
                    #     ns_validations= ns_validations[1:length(ns_calibrations)]
                    # end
                    for i in length(ns_calibrations)
                        all_calibrations = vcat(all_calibrations, ns_calibrations)
                        all_validations = vcat(all_validations, ns_validations)
                    end
                end
            end
            all_calibrations_d=DataFrame(all_calibrations, :auto)
            display(all_calibrations_d)
                println(size(all_calibrations_d))
                for (o, ob) in enumerate(obj_title)
                        if o ==1
                            cal_performance_ns[c,o] = 1-mean(all_calibrations_d[:,o])
                            val_performance_ns[c,o] = 1-mean(all_validations[:,o])
                        else
                            cal_performance_ns[c,o] = mean(all_calibrations[:,o])
                            val_performance_ns[c,o] = mean(all_validations[:,o])
                        end
                end
    end



    #writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Calibration_statistics", cal_performance_ns, ',')
    #writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Validation_statistics", val_performance_ns, ',')

    hm_ns = Plots.plot()
    hm_c_ns = Plots.heatmap(cal_performance_ns, c=:blues, title="Calibration NS")
    for y in 1:1:6
        for x in 1:1:9
            t = string(cal_performance_ns[y,x])[1:4]
            annotate!(x,y,t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45, )
    yticks!([1:6;], Catchments_n )

    hm_v_ns = Plots.heatmap(val_performance_ns, c=:blues, title="Evaluation NS")
    for y in 1:1:6
        for x in 1:1:9
            t = string(val_performance_ns[y,x])[1:4]
            annotate!(x,y, t, :white)
        end
    end
    xticks!([1:9;], obj_title, xrotation=45)
    yticks!([1:6;], Catchments_n)
    # Plots.plot(plots_obj[2], plots_obj[3], plots_obj[4], plots_obj[5], plots_obj[6], plots_obj[7], plots_obj[8], plots_obj[9], layout= (2,4), legend = false, size=(1800,1000), left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
    # Plots.savefig(path_to_save * "obj_Calibration_Validation_violin.png")

    total_ns = Plots.plot(hm_c_ns, hm_v_ns, layout=(1,2), size=(2500,1000))
    display(total_ns)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/NS_Cal_Val_statistics")

    total_both = Plots.plot(hm_c_s, hm_v_s, hm_c_ns, hm_v_ns,layout=(2,2), size=(2500,1500), legend=:bottom, bottommargin=10mm, top_margin=1mm)

    #total_both = Plots.plot(Plots.heatmap(cal_performance_s, c=:blues, title="Calibration S"), Plots.heatmap(val_performance_s, c=:blues, title="Evaluation S"), Plots.heatmap(cal_performance_ns, c=:blues, title="Calibration NS"), Plots.heatmap(val_performance_ns, c=:blues, title="Evaluation NS"), layout=(2,2), size=(2500,2000), legend=:bottom, margin=10mm)
    display(total_both)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/Total_Cal_Val_statistics_compared")
return
end
# plot_total()

# function plot_compared()
#         Catchments=["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal" ]
#         Catchments_n=["Feistritztal", "Paltental *", "Gailtal *",  "Silbertal *", "Defreggental", "Pitztal" ]
#
#         #Catchments = ["Defreggental", "Feistritz", "Gailtal", "Pitztal", "Palten", "Silbertal"]
#         obj_title = [L"D_{E,tot}", L"E_{NSE,Q}",L"E_{NSE logQ}", L"E_{VE Q}", L"E_{NSE FDC}", L"E_{RE AC1}", L"E_{NSE AC90}", L"E_{NSE RC}", L"E_{AE SC}"]
#         s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/"
#
#         cal_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
#         cal_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
#         val_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Validation_statistics.csv", DataFrame,  decimal='.', delim = ',', header=false)
#         val_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
#         cal_performance_dif = zeros(6,9)
#         val_performance_dif = zeros(6,9)
#
#         for (c,cm) in enumerate(Catchments)
#
#                 for (o, ob) in enumerate(obj_title)
#                     # println(cal_performance_ns[6,9])
#                     # println(cal_performance_s[6,9])
#                         cal_performance_dif[c,o] = cal_performance_ns[c,o] - cal_performance_s[c,o]
#                         val_performance_dif[c,o] = val_performance_ns[c,o] - val_performance_s[c,o]
#                 end
#         end
#
#         hm = Plots.plot()
#         hm_c_d = Plots.heatmap(cal_performance_dif, c=:RdBu, clims=(-0.2,0.2),title="Calibration", legend=false,  titlefont=font(14))
#         for y in 1:1:6
#             for x in 1:1:9
#                 t = round(cal_performance_dif[y,x],digits=2)
#                 # if t>=0.1||t<=-0.1
#                 #     annotate!(x,y,string(t), :white)
#                 # else
#                     annotate!(x,y,string(t), :black)
#                 # end
#             end
#         end
#         xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(14))
#         yticks!([1:6;], Catchments_n, ytickfont=font(14))
#         display(hm_c_d)
#
#         hm_v_d = Plots.heatmap( val_performance_dif, c=:RdBu, clims=(-0.2,0.2),title="Evaluation", yaxis=nothing, titlefont=font(14))
#
#         for y in 1:1:6
#             for x in 1:1:9
#                 t = round(val_performance_dif[y,x],digits=3)
#                 # if t>=0.1||t<=-0.1
#                 #     annotate!(x,y,string(t), :white)
#                 # else
#                     annotate!(x,y,string(t), :black)
#                 # end
#             end
#         end
#         xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(14))
#         #yticks!([1:6;], Catchments_n)
#         # Plots.plot(plots_obj[2], plots_obj[3], plots_obj[4], plots_obj[5], plots_obj[6], plots_obj[7], plots_obj[8], plots_obj[9], layout= (2,4), legend = false, size=(1800,1000), left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
#         # Plots.savefig(path_to_save * "obj_Calibration_Validation_violin.png")
#         display(hm_v_d)
#         display(val_performance_dif)
#
#         total_dif = Plots.plot(hm_c_d, hm_v_d, layout = grid(1,2, widths=[0.46, 0.54]), size=(2500,1100), bottom_margin=30px)
#
#         # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Total/Compared_Cal_Val_statistics.png")
#         # Plots.savefig("/Volumes/Magali 2/Results/Calibrations/Compared_Cal_Val_statistics.png")
#
#         display(total_dif)
#     return
# end


function total_plot_compared_new()
        Catchments=["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal" ]
        Catchments_n=["Feistritztal", "Paltental *", "Gailtal *",  "Silbertal *", "Defreggental", "Pitztal" ]

        obj_title = [L"D_{E,tot}", L"E_{NSE,Q}",L"E_{NSE,log(Q)}", L"E_{VE,Q}", L"E_{NSE,FDC}", L"E_{RE,AC1}", L"E_{NSE,AC90}", L"E_{NSE,RC}", L"E_{AE,SC}"]
        s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/"

        colorbar_ticks1=(-1:.5:1)
        colorbar_ticks2=(-0.2:0.1:0.2, string.((-0.2:0.1:0.2)))

        cal_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        cal_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        val_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        val_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        cal_performance_dif = zeros(6,9)
        val_performance_dif = zeros(6,9)

        for (c,cm) in enumerate(Catchments)

                for (o, ob) in enumerate(obj_title)
                    cal_performance_dif[c,o] = cal_performance_ns[c,o] - cal_performance_s[c,o]
                    val_performance_dif[c,o] = val_performance_ns[c,o] - val_performance_s[c,o]
                end
        end

        #create non-stationary calibration scores heatmap
        cal_performance_s = Matrix(cal_performance_s)
        cal_performance_ns = Matrix(cal_performance_ns)
        val_performance_s = Matrix(val_performance_s)
        val_performance_ns = Matrix(val_performance_ns)

        hm_s = Plots.plot()

        hm_c_s = Plots.heatmap(cal_performance_s, legend=false, c=:RdBu, clims=(-1,1), title="Calibration Sr,cal", titlefont=font(22))
        for y in 1:1:6
            for x in 1:1:9
                t = round(cal_performance_s[y,x],digits=2)
                    annotate!(x,y,Plots.text(string(t),:white, 22))
            end
        end
        xticks!([1:9;], ["","","","","","","","","",""], xtickfontsize=18)
        yticks!([1:6;], Catchments_n, ytickfont=font(22))
        #create non-stationary validation scores heatmap
        hm_v = Plots.plot()
        Plots.gr_cbar_offsets[] = (0.05, 0.07)
        hm_v_s = Plots.heatmap(val_performance_s, c=:RdBu, clims=(-1,1), title="Evaluation Sr,cal", titlefont=font(22), ymirror=true)

        for y in 1:1:6
            for x in 1:1:9
                t = round(val_performance_s[y,x],digits=2)
                annotate!(x,y,Plots.text(string(t),:white, 22))
            end
        end
        xticks!([1:9;], ["","","","","","","","",""], xtickfontsize=18)
        yticks!([1:6;], ["F","E","D","C","B","A"], ytickfontsize=22, tickfonthalign=:center)

        total_s = Plots.plot(hm_c_s, hm_v_s, layout=(1,2), size=(2500,1000))

        #create heatmap non-stationary calibration scores
        hm_ns = Plots.plot()
        hm_c_ns = Plots.heatmap(cal_performance_ns, c=:RdBu, clims=(-1,1), legend=false,title="Calibration Sr,clim,adapt", titlefont=font(22))
        for y in 1:1:6
            for x in 1:1:9
                t = round(cal_performance_ns[y,x],digits=2)
                    annotate!(x,y,Plots.text(string(t),:white, 22))
            end
        end
        xticks!([1:9;], ["","","","","","","","",""])
        yticks!([1:6;], Catchments_n, ytickfont=font(22))

        hm_ns = Plots.plot()
        Plots.gr_cbar_offsets[] = (0.05, 0.07)
        hm_v_ns = Plots.heatmap(val_performance_ns, c=:RdBu, clims=(-1,1), colorbar_ticks=(-1:0.5:1), title="Evaluation Sr,clim,adapt", titlefont=font(22), ymirror=true, ytickfontsize=18)
        for y in 1:1:6
            for x in 1:1:9
                t = round(val_performance_ns[y,x],digits=2)
                    annotate!(x,y,Plots.text(string(t),:white, 22))
            end
        end
        xticks!([1:9;], ["","","","","","","","",""])
        yticks!([1:6;], ["L","K","J","I","H","G"], ytickfontsize=22, tickfonthalign=:center)
        total_ns = Plots.plot(hm_c_ns, hm_v_ns, layout=(1,2), size=(2500,1000))

        hm = Plots.plot()
        hm_c_d = Plots.heatmap(cal_performance_dif, c=:RdBu, clims=(-0.2,0.2),title="Calibration", legend=false,  titlefont=font(22), ytickfont=18)
        for y in 1:1:6
            for x in 1:1:9
                t = round(cal_performance_dif[y,x],digits=2)
                    annotate!(x,y,Plots.text(string(t),:black, 22))
            end
        end
        xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(22))
        yticks!([1:6;], Catchments_n, ytickfont=font(22))
        Plots.gr_cbar_offsets[] = (0.05, 0.07)
        hm_v_d = Plots.heatmap(val_performance_dif, c=:RdBu, clims=(-0.2,0.2), colorbar_ticks=colorbar_ticks1, title="Evaluation", yaxis=nothing, titlefont=font(22))

        for y in 1:1:6
            for x in 1:1:9
                t = round(val_performance_dif[y,x],digits=2)
                annotate!(x,y,Plots.text(string(t),:black, 22))
            end
        end
        xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(22), ymirror=true)
        yticks!([1:6;], ["R","Q","P","O","N","M"], ytickfontsize=22, tickfonthalign=:center)

        total_dif = Plots.plot(hm_c_d, hm_v_d, layout=(1,2), size=(2400,1000))

        l=@layout[a b{0.57w}; c d{0.57w};e f{0.57w}]
        total_both = Plots.plot(hm_c_s, hm_v_s, hm_c_ns, hm_v_ns, hm_c_d, hm_v_d, layout=l, size=(2500,3000), left_margin=15mm, right_margin=15mm)
        display(total_both)

        # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/Total_compared_Cal_Val_statistics_L3.png")

    return
end

# total_plot_compared_new()

function total_plot_compared_de_tot_summary()
    Catchments=["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal" ]
    Catchments_n=["Feistritztal", "Paltental *", "Gailtal *",  "Silbertal *", "Defreggental", "Pitztal" ]

    obj_title = [L"D_{E,tot}"]
    s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/"

    colorbar_ticks1=(-1:.5:1)
    colorbar_ticks2=(-0.2:0.1:0.2, string.((-0.2:0.1:0.2)))

    cal_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
    cal_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
    val_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
    val_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
    performance_dif = zeros(6,2)
    s_performance=zeros(6,2)
    ns_performance=zeros(6,2)

    for (c,cm) in enumerate(Catchments)

            for (o, ob) in enumerate(obj_title)
                performance_dif[c,1] = cal_performance_ns[c,o] - cal_performance_s[c,o]
                performance_dif[c,2] = val_performance_ns[c,o] - val_performance_s[c,o]
                s_performance[c,1] = cal_performance_s[c,o]
                s_performance[c,2] = val_performance_s[c,o]
                ns_performance[c,1] = cal_performance_ns[c,o]
                ns_performance[c,2] = val_performance_ns[c,o]
            end
    end

    println(typeof(s_performance))
    #create non-stationary calibration scores heatmap

    hm_s = Plots.heatmap(s_performance, legend=false, c=:RdBu, clims=(-1,1), title="Sr,cal", titlefont=font(22), top_margin=5mm, bottom_margin=5mm)
    for y in 1:1:6
        for x in 1:1:2
            t = round(s_performance[y,x],digits=2)
                annotate!(x,y,Plots.text(string(t),:white, 22))
        end
    end
    xticks!([1:2;], ["Cal.","Val."], xtickfontsize=22)
    yticks!([1:6;], Catchments_n, ytickfont=font(22))

    #create non-stationary validation scores heatmap

    hm_ns = Plots.heatmap(ns_performance, c=:RdBu, clims=(-1,1), colorbar_ticks=(-1:0.5:1), title="Sr,clim", titlefont=font(22), right_margin=60mm, top_margin=5mm, bottom_margin=5mm)
    annotate!(3,3.5,Plots.text("Overall Model performance ("*L"D_{E,tot}"*" [-])", :black, rotation=90,22))
    Plots.gr_cbar_offsets[] = (0.06, 0.07)

    for y in 1:1:6
        for x in 1:1:2
            t = round(ns_performance[y,x],digits=2)
                annotate!(x,y,Plots.text(string(t),:white, 22))
        end
    end
    xticks!([1:2;], ["Cal.","Val."], xtickfontsize=22)
    yticks!([1:6;], ["","","","","","","","",""], ytickfont=font(22))

    hm_dif = Plots.heatmap(performance_dif, c=:RdBu, clims=(-0.2,0.2), title="Δ (Sr,cal-Sr,clim)", titlefont=font(22), framestyle=:box, right_margin=40mm, top_margin=5mm, bottom_margin=5mm)
    annotate!(3,3.5,Plots.text("Δ Overall Model performance ("*L"ΔD_{E,tot}"*" [-])", :black, rotation=90,22))
    Plots.gr_cbar_offsets[] = (0.06, 0.07)
    for y in 1:1:6
        for x in 1:1:2
            t = round(performance_dif[y,x],digits=2)
                annotate!(x,y,Plots.text(string(t),:black, 22))
        end
    end
    xticks!([1:2;], ["Cal.","Val."], xtickfontsize=22)
    yticks!([1:6;], ["","","","","","","","",""], ytickfont=font(22))
    # ylabel!("Total Model performance ("*L"D_{E,tot}"*" [-])")

    l=@layout[a{0.23w} b c]
    total_both = Plots.plot(hm_s, hm_ns, hm_dif, layout=l, size=(2000,800))
    display(total_both)

    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/Total_DEtot_compared_Cal_Val_statistics_L3.png")

end

# total_plot_compared_de_tot_summary()

function total_difference_plot_compared()
        Catchments=["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal" ]
        Catchments_n=["Feistritztal", "Paltental *", "Gailtal *",  "Silbertal *", "Defreggental", "Pitztal" ]

        obj_title = [L"D_{E,tot}", L"E_{NSE,Q}",L"E_{NSE,log(Q)}", L"E_{VE,Q}", L"E_{NSE,FDC}", L"E_{RE,AC1}", L"E_{NSE,AC90}", L"E_{NSE,RC}", L"E_{AE,SC}"]
        s_calibrations_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/"

        colorbar_ticks1=(-1:.5:1)
        colorbar_ticks2=(-0.2:0.1:0.2, string.((-0.2:0.1:0.2)))

        cal_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        cal_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Calibration_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        val_performance_s = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/S_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        val_performance_ns = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/NS_Validation_statistics.csv", DataFrame, decimal='.', delim = ',', header=false)
        cal_performance_dif = zeros(6,9)
        val_performance_dif = zeros(6,9)

        for (c,cm) in enumerate(Catchments)

                for (o, ob) in enumerate(obj_title)

                    cal_performance_dif[c,o] = cal_performance_ns[c,o] - cal_performance_s[c,o]
                    val_performance_dif[c,o] = val_performance_ns[c,o] - val_performance_s[c,o]
                end
        end

        #create difference in calibration scores heatmap
        println(size(cal_performance_dif))
        hm = Plots.plot()
        hm_c_d = Plots.heatmap(cal_performance_dif, c=:RdBu, clims=(-0.2,0.2),title="Calibration", legend=false,  titlefont=font(26), ytickfont=22)
        for y in 1:1:6
            for x in 1:1:9
                t = round(cal_performance_dif[y,x],digits=2)
                if t ==-0.0
                    t=0.0
                end
                    annotate!(x,y,Plots.text(string(t),:black, 22))
            end
        end
        xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(24))
        yticks!([1:6;], Catchments_n, ytickfont=font(22))
        Plots.gr_cbar_offsets[] = (0.05, 0.07)
        hm_v_d = Plots.heatmap(val_performance_dif, c=:RdBu, clims=(-0.2,0.2), colorbar_ticks=colorbar_ticks2, tickfontsize=22, title="Evaluation", yaxis=nothing, titlefont=font(26))

        for y in 1:1:6
            for x in 1:1:9
                t = round(val_performance_dif[y,x],digits=2)
                if t ==-0.0
                    t=0.0
                end
                annotate!(x,y,Plots.text(string(t),:black, 22))
            end
        end
        xticks!([1:9;], obj_title, xrotation=45, xtickfont=font(22), ymirror=true)
        annotate!(10.5,3.5,Plots.text("Δ Overall Model performance ("*L"ΔD_{E,tot}"*" [-])", :black, rotation=90,24))
        Plots.gr_cbar_offsets[] = (0.06, 0.07)

        l=@layout[a b{0.57w}]
        total_both = Plots.plot(hm_c_d, hm_v_d, layout=l, size=(2500,1100), left_margin=15mm, right_margin=[0mm 30mm], top_margin=10mm, bottom_margin=20mm, framestyle=:box)
        display(total_both)

        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Calibration/Total/Total_difference_compared_L3.png")

    end
total_difference_plot_compared()
