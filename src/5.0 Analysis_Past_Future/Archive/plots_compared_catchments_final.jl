
using Statistics
using Plots
using StatsPlots
using DelimitedFiles
using Plots.PlotMeasures
using DocStringExtensions
using CSV
using DataFrames
using LaTeXStrings
relative_error(future, initial) = (future - initial) ./ initial
#include("compare_Present_Future_low_flows.jl")
#include("loadfunctions.jl")
path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
Name_Projections_45 = readdir(path_45)
path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
Name_Projections_85 = readdir(path_85)
path_pro_HD = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"
path_ext_2 = "/Volumes/Magali 2/Results/Projections/"
path_ext_1 = "/Volumes/Magali/Results_Ext/PastvsFuture/"

Area_Catchment_Gailtal = sum([98227533.0, 184294158.0, 83478138.0, 220613195.0])
Area_Catchment_Palten = sum([198175943.0, 56544073.0, 115284451.3])
Area_Catchment_Pitten = 115496400.
Area_Catchment_Silbertal = 100139168.
Area_Catchment_Defreggental = sum([235811198.0, 31497403.0])
Area_Catchment_Pitztal = sum([20651736.0, 145191864.0])

Catchment_Names = ["Pitten", "Palten", "Gailtal", "IllSugadin", "Defreggental", "Pitztal"]
Catchment_Names_new = ["Feistritz", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal"]
Catchment_Names_new2 = ["Defreggental", "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]
Catchment_Height = [917, 1315, 1476, 1776, 2233, 2558]
Catchment_Height_new2 = [2233, 917, 1476, 1315, 2558, 1776]

Area_Catchments = [Area_Catchment_Pitten, Area_Catchment_Palten, Area_Catchment_Gailtal, Area_Catchment_Silbertal, Area_Catchment_Defreggental, Area_Catchment_Pitztal]
Area_Catchments_new2 = [Area_Catchment_Defreggental, Area_Catchment_Pitten, Area_Catchment_Gailtal, Area_Catchment_Palten, Area_Catchment_Pitten, Area_Catchment_Silbertal]

nr_runs = [300,300,298,300, 300, 300]
nr_runs_new = [2980,2980,2980,2980, 2450, 2980]
nr_runs_new_t = [2950,2950,2950,2950, 2950, 2950]

nr_runs_test = [3,3,3,3,3,3]




function plot_changes_monthly_discharge_all_catchments_absolute(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    legend = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])

        total_Monthly_Discharge_future_45_PforF = zeros(12,3)
        total_Monthly_Discharge_future_45_NS = zeros(12,3)
        total_Monthly_Discharge_future_85_PforF= zeros(12,3)
        total_Monthly_Discharge_future_85_NS= zeros(12,3)
        total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]

        for month in 1:12
            total_Monthly_Discharge_future_45_PforF_ = Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] - Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)]
            total_Monthly_Discharge_future_45_NS_ = Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)]- Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)]
            total_Monthly_Discharge_future_85_PforF_ = Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] - Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)]
            total_Monthly_Discharge_future_85_NS_ = Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)]- Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)]

            total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1])
            total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1])
            total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1])
            total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = [total_Monthly_Discharge_future_85_NS[:,1]-total_Monthly_Discharge_future_85_NS[:,2], total_Monthly_Discharge_future_85_NS[:,3]-total_Monthly_Discharge_future_85_NS[:,1]], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = [total_Monthly_Discharge_future_85_PforF[:,1]-total_Monthly_Discharge_future_85_PforF[:,2], total_Monthly_Discharge_future_85_PforF[:,3]-total_Monthly_Discharge_future_85_PforF[:,1]],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = [total_Monthly_Discharge_future_45_NS[:,1]-total_Monthly_Discharge_future_45_NS[:,2], total_Monthly_Discharge_future_45_NS[:,3]-total_Monthly_Discharge_future_45_NS[:,1]], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = [total_Monthly_Discharge_future_45_PforF[:,1]-total_Monthly_Discharge_future_45_PforF[:,2], total_Monthly_Discharge_future_45_PforF[:,3]-total_Monthly_Discharge_future_45_PforF[:,1]], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            # if i==6 && month==12
            #     scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,adapt")
            #     scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP 8.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 8.5 Sr,clim,adapt")
            # end
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        ylims!((-4.5,4))
        if i==1 || i==4
            yticks!([-4:2:4;])
            ylabel!("∆ Monthly Discharge [mm/d]", yguidefontsize=20)
        else
            yticks!([-4:2:4;], ["", "", "","",""])
        end

        if i in 4:6
            xticks!([1:1:12;], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])
        end
        # hline!([0], color=["white"], label=false)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        box = plot!()

        push!(all_boxplots, box)
        # end

        # if i==6
        #     Plots.plot()
        #         scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=0, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,stat")
        #         leg1=plot!()
        #         push!(legend, leg1)
        #     Plots.plot()
        #         scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=0, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,adapt")
        #         leg2=plot!()
        #         push!(legend, leg2)
        #     Plots.plot()
        #         scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=0, markerstrokewidth= 0, label="RCP 8.5 Sr,clim,stat")
        #         leg3=plot!()
        #         push!(legend, leg3)
        #     Plots.plot()
        #         scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=0, markerstrokewidth= 0,label="RCP 8.5 Sr,clim,adapt")
        #         leg4=plot!()
        #         push!(legend, leg4)
        #     end

        end

    # legend_plot = Plots.plot(legend[1], legend[2], legend[3], legend[4], layout= (1,4), legend=:mid, size=(2000,50))
    # display(legend_plot)
    total = Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), legend =:topleft, xrotation=0, legendfontsize=20, size=(2000,960), left_margin = [20mm 10mm 10mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    display(total)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_absolute_change_grid.png")
end
# plot_changes_monthly_discharge_all_catchments_absolute(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_monthly_discharge_all_catchments_absolute_leg(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    legends = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        # monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        # months_85_NS = monthly_changes_85_NS[:,1]
        # Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        # Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        # monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        # months_45_NS = monthly_changes_45_NS[:,1]
        # Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        # Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        # Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        # monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        # months_85_PforF = monthly_changes_85_PforF[:,1]
        # Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        # Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        # monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        # months_45_PforF = monthly_changes_45_PforF[:,1]
        # Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        # Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        # Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]
        #
        # Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        # Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        # Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        # Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        # Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        # Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        # Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        # Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])
        #
        # total_Monthly_Discharge_future_45_PforF = zeros(12,3)
        # total_Monthly_Discharge_future_45_NS = zeros(12,3)
        # total_Monthly_Discharge_future_85_PforF= zeros(12,3)
        # total_Monthly_Discharge_future_85_NS= zeros(12,3)
        # total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]
        #
        #
        # for month in 1:12
        #     total_Monthly_Discharge_future_45_PforF_ = Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] - Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)]
        #     total_Monthly_Discharge_future_45_NS_ = Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)]- Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)]
        #     total_Monthly_Discharge_future_85_PforF_ = Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] - Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)]
        #     total_Monthly_Discharge_future_85_NS_ = Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)]- Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)]
        #
        #     total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1])
        #     total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1])
        #     total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1])
        #     total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1])
        # end

        total_Monthly_Discharge_future_45_PforF = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/stats_Monthly_Discharge_future_45_PforF.txt",','),:auto)
        total_Monthly_Discharge_future_45_NS = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/statsl_Monthly_Discharge_future_45_NS.txt",','),:auto)
        total_Monthly_Discharge_future_85_PforF = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/stats_Monthly_Discharge_future_85_PforF.txt", ','),:auto)
        total_Monthly_Discharge_future_85_NS = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/stats_Monthly_Discharge_future_85_NS.txt", ','),:auto)
        println(total_Monthly_Discharge_future_85_NS[:,1])
        Plots.plot()
        box = []
        # for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = [total_Monthly_Discharge_future_85_NS[:,1]-total_Monthly_Discharge_future_85_NS[:,2], total_Monthly_Discharge_future_85_NS[:,3]-total_Monthly_Discharge_future_85_NS[:,1]], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = [total_Monthly_Discharge_future_85_PforF[:,1]-total_Monthly_Discharge_future_85_PforF[:,2], total_Monthly_Discharge_future_85_PforF[:,3]-total_Monthly_Discharge_future_85_PforF[:,1]],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = [total_Monthly_Discharge_future_45_NS[:,1]-total_Monthly_Discharge_future_45_NS[:,2], total_Monthly_Discharge_future_45_NS[:,3]-total_Monthly_Discharge_future_45_NS[:,1]], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = [total_Monthly_Discharge_future_45_PforF[:,1]-total_Monthly_Discharge_future_45_PforF[:,2], total_Monthly_Discharge_future_45_PforF[:,3]-total_Monthly_Discharge_future_45_PforF[:,1]], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            # if i==6 && month==12
            #     scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,adapt")
            #     scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP 8.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 8.5 Sr,clim,adapt")
            # end
            # plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false, lw=3)
            # plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, lw=3)
            # plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, lw=3)
            # plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, lw=3)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1],  label=false, lw=3)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  label=false, lw=3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], label=false, lw=3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  label=false, lw=3)
        # end
        hline!([0], color=["black"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(xtickfont = font(20), ytickfont = font(20), outlier=false, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        ylims!((-4.5,4))
        if i==1 || i==4
            yticks!([-4:2:4;])
            ylabel!("∆ Monthly Discharge [mm/d]", yguidefontsize=20)
        else
            yticks!([-4:2:4;], ["", "", "","",""])
        end

        if i in 4:6
            xticks!([1:1:12;], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])
        end
        # hline!([0], color=["white"], label=false)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        box = plot!()

        push!(all_boxplots, box)
        # end

        if i==6
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_45_PforF[1,1]],  color=Farben_45[1], markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 4.5 SR,clim,st ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg1=plot!()
                push!(legends, leg1)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_45_NS[1,1]], color=Farben_45[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 4.5 SR,clim,ad ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg2=plot!()
                push!(legends, leg2)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_PforF[1,1]], color=Farben_85[1], markershape=:rect, markersize=7, markerstrokewidth= 0, label=" RCP 8.5 SR,clim,st ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg3=plot!()
                push!(legends, leg3)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_NS[1,1]], color=Farben_85[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 8.5 SR,clim,ad ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg4=plot!()
                push!(legends, leg4)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_NS[1,1]], color=Farben_85[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=false,legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(100,20), alpha=0.7)
                xaxis!((-1,0))
                leg5=plot!()
                push!(legends, leg5)


            end

        end

    # legend_plot = Plots.plot(legend[1], legend[2], legend[3], legend[4], layout= (1,4), legend=:mid, size=(2000,50))
    # display(legend_plot)
    legend = Plots.plot(legends[5],legends[1], legends[2],legends[3],legends[4], layout=grid(1,5), xticks=:none, yticks=:none, showaxis=false, grid=false, size=(2000,100), legendfontsize=20, top_margin=20px, foreground_color_legend=:white)

    # display(legend)

    total = Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout=grid(2,3), legend =:topleft, xrotation=0, legendfontsize=20, size=(2000,960), bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    display(total)
    tot = Plots.plot(total, legend, layout=@layout([A{1w}; B{0.05h}]), size=(2000,1200))
    # tot = Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6],
    # legends[1], legends[2],legends[3],legends[4], layout=@layout([grid(2,3){0.95h}; grid(1,4)]), size=(2000,1160), foreground_color_legend=:white)

    display(tot)

    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_absolute_change_L2.png")
end
plot_changes_monthly_discharge_all_catchments_absolute_leg(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_monthly_discharge_all_catchments_absolute_std(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])

        total_Monthly_Discharge_future_45_PforF = zeros(12,4)
        total_Monthly_Discharge_future_45_NS = zeros(12,4)
        total_Monthly_Discharge_future_85_PforF= zeros(12,4)
        total_Monthly_Discharge_future_85_NS= zeros(12,4)
        total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]

        for month in 1:12
            total_Monthly_Discharge_future_45_PforF_ = Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] - Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)]
            total_Monthly_Discharge_future_45_NS_ = Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)]- Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)]
            total_Monthly_Discharge_future_85_PforF_ = Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] - Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)]
            total_Monthly_Discharge_future_85_NS_ = Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)]- Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)]

            total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1]),std(total_Monthly_Discharge_future_45_PforF_[:,1])
            total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1]),std(total_Monthly_Discharge_future_45_NS_[:,1])
            total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1]),std(total_Monthly_Discharge_future_85_PforF_[:,1])
            total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1]),std(total_Monthly_Discharge_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = total_Monthly_Discharge_future_85_NS[:,4], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = total_Monthly_Discharge_future_85_PforF[:,4],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = total_Monthly_Discharge_future_45_NS[:,4], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = total_Monthly_Discharge_future_45_PforF[:,4], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            if i==1 &&month==12
                scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP8.5 Cl,stat")
                scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP8.5 Cl,adapt")
                scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[2], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,stat")
                scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,adapt")
            end
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[2], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        ylims!((-4.5,4))
        if i==1 || i==4
            yticks!([-4:2:4;])
            ylabel!("∆Q [mm/d]", yguidefontsize=20)
        else
            yticks!([-4:2:4;], ["", "", "","",""])
        end

        if i in 4:6
            xticks!([1:1:12;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"], xrotation=45)
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])
        end
        # hline!([0], color=["white"], label=false)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        box = plot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), legend =:topleft, legendfontsize=20, size=(3000,1500), left_margin = [20mm 10mm 10mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_absolute_change_grid_std.png")
end
# plot_changes_monthly_discharge_all_catchments_absolute_std(Catchment_Names_new, Catchment_Height, Area_Catchments)


function plot_changes_monthly_discharge_all_catchments_relative_leg(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    legends=[]
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        # monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        # months_85_NS = monthly_changes_85_NS[:,1]
        # Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        # Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        # monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        # months_45_NS = monthly_changes_45_NS[:,1]
        # Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        # Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        # Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        # monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        # months_85_PforF = monthly_changes_85_PforF[:,1]
        # Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        # Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        # monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        # months_45_PforF = monthly_changes_45_PforF[:,1]
        # Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        # Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        # Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]
        #
        # Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        # Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        # Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        # Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        # Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        # Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        # Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        # Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])
        #
        # total_Monthly_Discharge_future_45_PforF = zeros(12,3)
        # total_Monthly_Discharge_future_45_NS = zeros(12,3)
        # total_Monthly_Discharge_future_85_PforF= zeros(12,3)
        # total_Monthly_Discharge_future_85_NS= zeros(12,3)
        # total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]
        #
        # for month in 1:12
        #     total_Monthly_Discharge_future_45_PforF_ = relative_error(Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)])*100
        #     total_Monthly_Discharge_future_45_NS_ = relative_error(Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)], Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)])*100
        #     total_Monthly_Discharge_future_85_PforF_ = relative_error(Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] , Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)])*100
        #     total_Monthly_Discharge_future_85_NS_ = relative_error(Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)], Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)])*100
        #
        #     total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1])
        #     total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1])
        #     total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1])
        #     total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1])
        # end
        #
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_45_PforF.txt",total_Monthly_Discharge_future_45_PforF,',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_45_NS.txt",total_Monthly_Discharge_future_45_NS ,',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_85_PforF.txt", total_Monthly_Discharge_future_85_PforF,',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_85_NS.txt", total_Monthly_Discharge_future_85_NS ,',')

        total_Monthly_Discharge_future_45_PforF = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_45_PforF.txt",','),:auto)
        total_Monthly_Discharge_future_45_NS = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_45_NS.txt",','),:auto)
        total_Monthly_Discharge_future_85_PforF = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_85_PforF.txt", ','),:auto)
        total_Monthly_Discharge_future_85_NS = DataFrame(readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/rel_stats_Monthly_Discharge_future_85_NS.txt", ','),:auto)
        Plots.plot()
        box = []
        # for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = [total_Monthly_Discharge_future_85_NS[:,1]-total_Monthly_Discharge_future_85_NS[:,2], total_Monthly_Discharge_future_85_NS[:,3]-total_Monthly_Discharge_future_85_NS[:,1]], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = [total_Monthly_Discharge_future_85_PforF[:,1]-total_Monthly_Discharge_future_85_PforF[:,2], total_Monthly_Discharge_future_85_PforF[:,3]-total_Monthly_Discharge_future_85_PforF[:,1]],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = [total_Monthly_Discharge_future_45_NS[:,1]-total_Monthly_Discharge_future_45_NS[:,2], total_Monthly_Discharge_future_45_NS[:,3]-total_Monthly_Discharge_future_45_NS[:,1]], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = [total_Monthly_Discharge_future_45_PforF[:,1]-total_Monthly_Discharge_future_45_PforF[:,2], total_Monthly_Discharge_future_45_PforF[:,3]-total_Monthly_Discharge_future_45_PforF[:,1]], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.1)
            # if i==4 &&month==12
            #     scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,adapt")
            #     scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP 8.5 Sr,clim,stat")
            #     scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 8.5 Sr,clim,adapt")
            # end
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1],  label=false, lw=3)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],   label=false, lw=3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1],  label=false, lw=3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],label=false, lw=3)
            # plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
            # plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            # plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            # plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
        # end
        hline!([0], color=["black"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!( bottom_margin = 50px, xtickfont = font(20), ytickfont = font(20), outlier=false, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        if i in [1,2,3]
            ylims!((-100,100))
            if i==1
                yticks!([-100:50:100;])
                ylabel!("∆ Monthly Discharge [%]", yguidefontsize=20)
            else
                yticks!([-100:50:100;], ["","","","",""])
            end

        end

        if  i in [4,5,6]
            ylims!((-100,400))
                if i==4
                    yticks!([-100:100:400;])
                    ylabel!("∆ Monthly Discharge [%]", yguidefontsize=20)
                else
                    yticks!([-100:100:400;], ["","","","","","",""])

                end

        end
        if i in 4:6
            xticks!([1:1:12;], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])

        end
        box = plot!()
        push!(all_boxplots, box)
        if i==6
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_45_PforF[1,1]],  color=Farben_45[1], markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 4.5 SR,clim,st ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg1=plot!()
                push!(legends, leg1)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_45_NS[1,1]], color=Farben_45[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 4.5 SR,clim,ad ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg2=plot!()
                push!(legends, leg2)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_PforF[1,1]], color=Farben_85[1], markershape=:rect, markersize=7, markerstrokewidth= 0, label=" RCP 8.5 SR,clim,st ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg3=plot!()
                push!(legends, leg3)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_NS[1,1]], color=Farben_85[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=" RCP 8.5 SR,clim,ad ",legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(1000,20), alpha=0.7)
                xaxis!((-1,0))
                leg4=plot!()
                push!(legends, leg4)
            Plots.plot()
                scatter!([1],[total_Monthly_Discharge_future_85_NS[1,1]], color=Farben_85[2],  markershape=:rect, markersize=7, markerstrokewidth= 0,label=false,legend=:top, legendfontsize=18,xticks=:none, yticks=:none, showaxis=false, grid=false, size=(100,20), alpha=0.7)
                xaxis!((-1,0))
                leg5=plot!()
                push!(legends, leg5)


            end
        end
        legend = Plots.plot(legends[5],legends[1], legends[2],legends[3],legends[4], layout=grid(1,5), xticks=:none, yticks=:none, showaxis=false, grid=false, size=(2000,100), legendfontsize=20, top_margin=20px, foreground_color_legend=:white)
        total = Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout=grid(2,3), legend =:topleft, xrotation=0, legendfontsize=20, size=(2000,960), bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, left_margin=[20mm 0mm 0mm])
        display(total)
        tot = Plots.plot(total, legend, layout=@layout([A{1w}; B{0.05h}]), size=(2000,1200))
        # tot = Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6],
        # legends[1], legends[2],legends[3],legends[4], layout=@layout([grid(2,3){0.95h}; grid(1,4)]), size=(2000,1160), foreground_color_legend=:white)

        display(tot)


    # end
    # Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), xrotation=0, legend =:topleft, legendfontsize=20, size=(2500,1200), left_margin = [20mm 10mm 10mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_relative_change_grid.png")
end
# plot_changes_monthly_discharge_all_catchments_relative_leg(Catchment_Names_new, Catchment_Height, Area_Catchments)


function plot_changes_monthly_discharge_all_catchments_relative(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])

        total_Monthly_Discharge_future_45_PforF = zeros(12,3)
        total_Monthly_Discharge_future_45_NS = zeros(12,3)
        total_Monthly_Discharge_future_85_PforF= zeros(12,3)
        total_Monthly_Discharge_future_85_NS= zeros(12,3)
        total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]

        for month in 1:12
            total_Monthly_Discharge_future_45_PforF_ = relative_error(Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)])*100
            total_Monthly_Discharge_future_45_NS_ = relative_error(Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)], Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)])*100
            total_Monthly_Discharge_future_85_PforF_ = relative_error(Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] , Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)])*100
            total_Monthly_Discharge_future_85_NS_ = relative_error(Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)], Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)])*100

            total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1])
            total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1])
            total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1])
            total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = [total_Monthly_Discharge_future_85_NS[:,1]-total_Monthly_Discharge_future_85_NS[:,2], total_Monthly_Discharge_future_85_NS[:,3]-total_Monthly_Discharge_future_85_NS[:,1]], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = [total_Monthly_Discharge_future_85_PforF[:,1]-total_Monthly_Discharge_future_85_PforF[:,2], total_Monthly_Discharge_future_85_PforF[:,3]-total_Monthly_Discharge_future_85_PforF[:,1]],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = [total_Monthly_Discharge_future_45_NS[:,1]-total_Monthly_Discharge_future_45_NS[:,2], total_Monthly_Discharge_future_45_NS[:,3]-total_Monthly_Discharge_future_45_NS[:,1]], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = [total_Monthly_Discharge_future_45_PforF[:,1]-total_Monthly_Discharge_future_45_PforF[:,2], total_Monthly_Discharge_future_45_PforF[:,3]-total_Monthly_Discharge_future_45_PforF[:,1]], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            if i==4 &&month==12
                scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,stat")
                scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 4.5 Sr,clim,adapt")
                scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP 8.5 Sr,clim,stat")
                scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP 8.5 Sr,clim,adapt")
            end
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 50px, xtickfont = font(20), ytickfont = font(20), outlier=false, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        if i in [1,2,3]
            ylims!((-100,100))
            if i==1
                yticks!([-100:50:100;])
                ylabel!("∆ Monthly Discharge [%]", yguidefontsize=20)
            else
                yticks!([-100:50:100;], ["","","","",""])
            end

        end

        if  i in [4,5,6]
            ylims!((-100,400))
                if i==4
                    yticks!([-100:100:400;])
                    ylabel!("∆ Monthly Discharge [%]", yguidefontsize=20)
                else
                    yticks!([-100:100:400;], ["","","","","","",""])

                end

        end
        if i in 4:6
            xticks!([1:1:12;], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])

        end
        # hline!([0], color=["white"], label=false)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        box = plot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), xrotation=0, legend =:topleft, legendfontsize=20, size=(2500,1200), left_margin = [20mm 10mm 10mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_relative_change_grid.png")
end
# plot_changes_monthly_discharge_all_catchments_relative(Catchment_Names_new, Catchment_Height, Area_Catchments)
function plot_changes_monthly_discharge_all_catchments_relative_std(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_changes_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_Discharge_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_Discharge_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_Discharge_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_Discharge_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_Discharge_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_Discharge_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_Discharge_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/PforF_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_Discharge_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_Discharge_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_Discharge_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        Monthly_Discharge_past_45_NS = convertDischarge(Monthly_Discharge_past_45_NS, Area_Catchments[i])
        Monthly_Discharge_past_85_NS = convertDischarge(Monthly_Discharge_past_85_NS, Area_Catchments[i])
        Monthly_Discharge_future_45_NS = convertDischarge(Monthly_Discharge_future_45_NS, Area_Catchments[i])
        Monthly_Discharge_future_85_NS = convertDischarge(Monthly_Discharge_future_85_NS, Area_Catchments[i])
        Monthly_Discharge_past_45_PforF = convertDischarge(Monthly_Discharge_past_45_PforF, Area_Catchments[i])
        Monthly_Discharge_past_85_PforF = convertDischarge(Monthly_Discharge_past_85_PforF, Area_Catchments[i])
        Monthly_Discharge_future_45_PforF = convertDischarge(Monthly_Discharge_future_45_PforF, Area_Catchments[i])
        Monthly_Discharge_future_85_PforF = convertDischarge(Monthly_Discharge_future_85_PforF, Area_Catchments[i])

        total_Monthly_Discharge_future_45_PforF = zeros(12,4)
        total_Monthly_Discharge_future_45_NS = zeros(12,4)
        total_Monthly_Discharge_future_85_PforF= zeros(12,4)
        total_Monthly_Discharge_future_85_NS= zeros(12,4)
        total_Monthly_Discharge_future = [total_Monthly_Discharge_future_45_PforF,total_Monthly_Discharge_future_45_NS, total_Monthly_Discharge_future_85_PforF, total_Monthly_Discharge_future_85_NS]

        for month in 1:12
            total_Monthly_Discharge_future_45_PforF_ = relative_error(Monthly_Discharge_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,Monthly_Discharge_past_45_PforF[findall(x-> x == month, months_45_PforF)])*100
            total_Monthly_Discharge_future_45_NS_ = relative_error(Monthly_Discharge_future_45_NS[findall(x-> x == month, months_45_NS)], Monthly_Discharge_past_45_NS[findall(x-> x == month, months_45_NS)])*100
            total_Monthly_Discharge_future_85_PforF_ = relative_error(Monthly_Discharge_future_85_PforF[findall(x-> x == month, months_85_PforF)] , Monthly_Discharge_past_85_PforF[findall(x-> x == month, months_85_PforF)])*100
            total_Monthly_Discharge_future_85_NS_ = relative_error(Monthly_Discharge_future_85_NS[findall(x-> x == month, months_85_NS)], Monthly_Discharge_past_85_NS[findall(x-> x == month, months_85_NS)])*100

            total_Monthly_Discharge_future_45_PforF[month,:] .= mean(total_Monthly_Discharge_future_45_PforF_[:,1]), minimum(total_Monthly_Discharge_future_45_PforF_[:,1]), maximum(total_Monthly_Discharge_future_45_PforF_[:,1]),std(total_Monthly_Discharge_future_45_PforF_[:,1])
            total_Monthly_Discharge_future_45_NS[month,:] .= mean(total_Monthly_Discharge_future_45_NS_[:,1]), minimum(total_Monthly_Discharge_future_45_NS_[:,1]), maximum(total_Monthly_Discharge_future_45_NS_[:,1]),std(total_Monthly_Discharge_future_45_NS_[:,1])
            total_Monthly_Discharge_future_85_PforF[month,:].= mean(total_Monthly_Discharge_future_85_PforF_[:,1]), minimum(total_Monthly_Discharge_future_85_PforF_[:,1]), maximum(total_Monthly_Discharge_future_85_PforF_[:,1]),std(total_Monthly_Discharge_future_85_PforF_[:,1])
            total_Monthly_Discharge_future_85_NS[month,:] .= mean(total_Monthly_Discharge_future_85_NS_[:,1]), minimum(total_Monthly_Discharge_future_85_NS_[:,1]), maximum(total_Monthly_Discharge_future_85_NS_[:,1]),std(total_Monthly_Discharge_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_Discharge_future_85_NS[:,1], ribbon = total_Monthly_Discharge_future_85_NS[:,4], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], ribbon = total_Monthly_Discharge_future_85_PforF[:,4],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], ribbon = total_Monthly_Discharge_future_45_NS[:,4], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1], ribbon = total_Monthly_Discharge_future_45_PforF[:,4], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
            if i==4 &&month==12
                scatter!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP8.5 Cl,stat")
                scatter!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP8.5 Cl,adapt")
                scatter!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[2], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,stat")
                scatter!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,adapt")
            end
            plot!(total_Monthly_Discharge_future_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
            plot!(total_Monthly_Discharge_future_85_NS[:,1], color=Farben_85[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_PforF[:,1],  color=Farben_45[2], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
            plot!(total_Monthly_Discharge_future_45_NS[:,1], color=Farben_45[1],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 50px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)

        if i in [1,2,3]
            ylims!((-100,100))
            if i==1
                yticks!([-100:50:100;])
                ylabel!("∆Q [%]", yguidefontsize=20)
            else
                yticks!([-100:50:100;], ["","","","",""])
            end

        end

        if  i in [4,5,6]
            ylims!((-100,500))
                if i==4
                    yticks!([-100:100:500;])
                    ylabel!("∆Q [%]", yguidefontsize=20)
                else
                    yticks!([-100:100:500;], ["","","","","","",""])

                end

        end
        if i in 4:6
            xticks!([1:1:12;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])

        end
        # hline!([0], color=["white"], label=false)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        box = plot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), legend =:topleft, legendfontsize=20, size=(3000,1500), left_margin = [20mm 10mm 10mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_Discharge/monthly_discharges_all_catchments_relative_change_grid_std.png")
end
# plot_changes_monthly_discharge_all_catchments_relative_std(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_monthly_GW_all_catchments_absolute(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)

        monthly_changes_85_NS = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/GW_discharge_months_8.5.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_GW_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_GW_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/GW_discharge_months_4.5.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_GW_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_GW_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_GW_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/PforF_GW_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_GW_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_GW_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/PForF_GW_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_GW_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_GW_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_GW_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        Monthly_GW_past_45_NS = convertGW(Monthly_GW_past_45_NS, Area_Catchments[i])
        Monthly_GW_past_85_NS = convertGW(Monthly_GW_past_85_NS, Area_Catchments[i])
        Monthly_GW_future_45_NS = convertGW(Monthly_GW_future_45_NS, Area_Catchments[i])
        Monthly_GW_future_85_NS = convertGW(Monthly_GW_future_85_NS, Area_Catchments[i])
        Monthly_GW_past_45_PforF = convertGW(Monthly_GW_past_45_PforF, Area_Catchments[i])
        Monthly_GW_past_85_PforF = convertGW(Monthly_GW_past_85_PforF, Area_Catchments[i])
        Monthly_GW_future_45_PforF = convertGW(Monthly_GW_future_45_PforF, Area_Catchments[i])
        Monthly_GW_future_85_PforF = convertGW(Monthly_GW_future_85_PforF, Area_Catchments[i])

        total_Monthly_GW_future_45_PforF = zeros(12,3)
        total_Monthly_GW_future_45_NS = zeros(12,3)
        total_Monthly_GW_future_85_PforF= zeros(12,3)
        total_Monthly_GW_future_85_NS= zeros(12,3)
        total_Monthly_GW_future = [total_Monthly_GW_future_45_PforF,total_Monthly_GW_future_45_NS, total_Monthly_GW_future_85_PforF, total_Monthly_GW_future_85_NS]

        for month in 1:12
            total_Monthly_GW_future_45_PforF_ = Monthly_GW_future_45_PforF[findall(x-> x == month, months_45_PforF)] -Monthly_GW_past_45_PforF[findall(x-> x == month, months_45_PforF)]
            total_Monthly_GW_future_45_NS_ = Monthly_GW_future_45_NS[findall(x-> x == month, months_45_NS)]-Monthly_GW_past_45_NS[findall(x-> x == month, months_45_NS)]
            total_Monthly_GW_future_85_PforF_ = Monthly_GW_future_85_PforF[findall(x-> x == month, months_85_PforF)] -Monthly_GW_past_85_PforF[findall(x-> x == month, months_85_PforF)]
            total_Monthly_GW_future_85_NS_ = Monthly_GW_future_85_NS[findall(x-> x == month, months_85_NS)]-Monthly_GW_past_85_NS[findall(x-> x == month, months_85_NS)]

            total_Monthly_GW_future_45_PforF[month,:] .= mean(total_Monthly_GW_future_45_PforF_[:,1]), minimum(total_Monthly_GW_future_45_PforF_[:,1]), maximum(total_Monthly_GW_future_45_PforF_[:,1])
            total_Monthly_GW_future_45_NS[month,:] .= mean(total_Monthly_GW_future_45_NS_[:,1]), minimum(total_Monthly_GW_future_45_NS_[:,1]), maximum(total_Monthly_GW_future_45_NS_[:,1])
            total_Monthly_GW_future_85_PforF[month,:].= mean(total_Monthly_GW_future_85_PforF_[:,1]), minimum(total_Monthly_GW_future_85_PforF_[:,1]), maximum(total_Monthly_GW_future_85_PforF_[:,1])
            total_Monthly_GW_future_85_NS[month,:] .= mean(total_Monthly_GW_future_85_NS_[:,1]), minimum(total_Monthly_GW_future_85_NS_[:,1]), maximum(total_Monthly_GW_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_GW_future_85_NS[:,1], ribbon = [total_Monthly_GW_future_85_NS[:,1]-total_Monthly_GW_future_85_NS[:,2], total_Monthly_GW_future_85_NS[:,3]-total_Monthly_GW_future_85_NS[:,1]], color=Farben_85[2], label="RCP8.5 Cl,adapt", alpha=0.2)
            plot!(total_Monthly_GW_future_45_NS[:,1], ribbon = [total_Monthly_GW_future_45_NS[:,1]-total_Monthly_GW_future_45_NS[:,2], total_Monthly_GW_future_45_NS[:,3]-total_Monthly_GW_future_45_NS[:,1]], color=Farben_45[2], label="RCP4.5 Cl,adapt", alpha=0.2)
            plot!(total_Monthly_GW_future_85_PforF[:,1], ribbon = [total_Monthly_GW_future_85_PforF[:,1]-total_Monthly_GW_future_85_PforF[:,2], total_Monthly_GW_future_85_PforF[:,3]-total_Monthly_GW_future_85_PforF[:,1]], color=Farben_85[1], label="RCP8.5 Cl,stat", alpha=0.2)
            plot!(total_Monthly_GW_future_45_PforF[:,1], ribbon = [total_Monthly_GW_future_45_PforF[:,1]-total_Monthly_GW_future_45_PforF[:,2], total_Monthly_GW_future_45_PforF[:,3]-total_Monthly_GW_future_45_PforF[:,1]], color=Farben_45[1], label="RCP4.5 Cl,stat", alpha=0.2)
        end
        if i==3
            ylabel!(" Changes in Groundwater Storage [mm]", yguidefontsize=20)
        end
        #title!("Relative Change in GW RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)

        # ylims!((-3.5,3.5))
        #yticks!([-3:1:3;])

        hline!([0], color=["grey"], linestyle = :dash)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        if i in 4:6
            xticks!([1:1:12;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])

        end
        box = plot!()
        push!(all_boxplots, box)
    end

    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_GW/monthly_GW_all_catchments_absolute_change_total.png")
end

# plot_changes_monthly_GW_all_catchments_absolute(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_monthly_GW_all_catchments_relative(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)

        monthly_changes_85_NS = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/GW_discharge_months_8.5.txt", ',')
        months_85_NS = monthly_changes_85_NS[:,1]
        Monthly_GW_past_85_NS = monthly_changes_85_NS[:,2]
        Monthly_GW_future_85_NS  = monthly_changes_85_NS[:,3]
        monthly_changes_45_NS = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/GW_discharge_months_4.5.txt", ',')
        months_45_NS = monthly_changes_45_NS[:,1]
        Monthly_GW_past_45_NS = monthly_changes_45_NS[:,2]
        Monthly_GW_future_45_NS  = monthly_changes_45_NS[:,3]
        Monthly_GW_Change_45_NS  = monthly_changes_45_NS[:,4]
        monthly_changes_85_PforF = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/PforF_GW_discharge_months_8.5.txt", ',')
        months_85_PforF = monthly_changes_85_PforF[:,1]
        Monthly_GW_past_85_PforF = monthly_changes_85_PforF[:,2]
        Monthly_GW_future_85_PforF  = monthly_changes_85_PforF[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Magali/Results_Ext/PastvsFuture/"*Catchment_Name*"/Monthly_GW/PForF_GW_discharge_months_4.5.txt", ',')
        months_45_PforF = monthly_changes_45_PforF[:,1]
        Monthly_GW_past_45_PforF = monthly_changes_45_PforF[:,2]
        Monthly_GW_future_45_PforF  = monthly_changes_45_PforF[:,3]
        Monthly_GW_Change_45_PforF  = monthly_changes_45_PforF[:,4]

        # Monthly_GW_past_45_NS = convertGW(Monthly_GW_past_45_NS, Area_Catchments[i])
        # Monthly_GW_past_85_NS = convertGW(Monthly_GW_past_85_NS, Area_Catchments[i])
        # Monthly_GW_future_45_NS = convertGW(Monthly_GW_future_45_NS, Area_Catchments[i])
        # Monthly_GW_future_85_NS = convertGW(Monthly_GW_future_85_NS, Area_Catchments[i])
        # Monthly_GW_past_45_PforF = convertGW(Monthly_GW_past_45_PforF, Area_Catchments[i])
        # Monthly_GW_past_85_PforF = convertGW(Monthly_GW_past_85_PforF, Area_Catchments[i])
        # Monthly_GW_future_45_PforF = convertGW(Monthly_GW_future_45_PforF, Area_Catchments[i])
        # Monthly_GW_future_85_PforF = convertGW(Monthly_GW_future_85_PforF, Area_Catchments[i])

        total_Monthly_GW_future_45_PforF = zeros(12,3)
        total_Monthly_GW_future_45_NS = zeros(12,3)
        total_Monthly_GW_future_85_PforF= zeros(12,3)
        total_Monthly_GW_future_85_NS= zeros(12,3)
        total_Monthly_GW_future = [total_Monthly_GW_future_45_PforF,total_Monthly_GW_future_45_NS, total_Monthly_GW_future_85_PforF, total_Monthly_GW_future_85_NS]

        for month in 1:12
            total_Monthly_GW_future_45_PforF_ = relative_error(Monthly_GW_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,Monthly_GW_past_45_PforF[findall(x-> x == month, months_45_PforF)])*100
            total_Monthly_GW_future_45_NS_ = relative_error(Monthly_GW_future_45_NS[findall(x-> x == month, months_45_NS)],Monthly_GW_past_45_NS[findall(x-> x == month, months_45_NS)])*100
            total_Monthly_GW_future_85_PforF_ = relative_error(Monthly_GW_future_85_PforF[findall(x-> x == month, months_85_PforF)] ,Monthly_GW_past_85_PforF[findall(x-> x == month, months_85_PforF)])*100
            total_Monthly_GW_future_85_NS_ =relative_error( Monthly_GW_future_85_NS[findall(x-> x == month, months_85_NS)],Monthly_GW_past_85_NS[findall(x-> x == month, months_85_NS)])*100

            total_Monthly_GW_future_45_PforF[month,:] .= mean(total_Monthly_GW_future_45_PforF_[:,1]), minimum(total_Monthly_GW_future_45_PforF_[:,1]), maximum(total_Monthly_GW_future_45_PforF_[:,1])
            total_Monthly_GW_future_45_NS[month,:] .= mean(total_Monthly_GW_future_45_NS_[:,1]), minimum(total_Monthly_GW_future_45_NS_[:,1]), maximum(total_Monthly_GW_future_45_NS_[:,1])
            total_Monthly_GW_future_85_PforF[month,:].= mean(total_Monthly_GW_future_85_PforF_[:,1]), minimum(total_Monthly_GW_future_85_PforF_[:,1]), maximum(total_Monthly_GW_future_85_PforF_[:,1])
            total_Monthly_GW_future_85_NS[month,:] .= mean(total_Monthly_GW_future_85_NS_[:,1]), minimum(total_Monthly_GW_future_85_NS_[:,1]), maximum(total_Monthly_GW_future_85_NS_[:,1])
        end

        Plots.plot()
        box = []
        for month in 1:12
            plot!(total_Monthly_GW_future_85_NS[:,1], ribbon = [total_Monthly_GW_future_85_NS[:,1]-total_Monthly_GW_future_85_NS[:,2], total_Monthly_GW_future_85_NS[:,3]-total_Monthly_GW_future_85_NS[:,1]], color=Farben_85[2], label="RCP8.5 Cl,adapt", alpha=0.2)
            plot!(total_Monthly_GW_future_45_NS[:,1], ribbon = [total_Monthly_GW_future_45_NS[:,1]-total_Monthly_GW_future_45_NS[:,2], total_Monthly_GW_future_45_NS[:,3]-total_Monthly_GW_future_45_NS[:,1]], color=Farben_45[2], label="RCP4.5 Cl,adapt", alpha=0.2)
            plot!(total_Monthly_GW_future_85_PforF[:,1], ribbon = [total_Monthly_GW_future_85_PforF[:,1]-total_Monthly_GW_future_85_PforF[:,2], total_Monthly_GW_future_85_PforF[:,3]-total_Monthly_GW_future_85_PforF[:,1]], color=Farben_85[1], label="RCP8.5 Cl,stat", alpha=0.2)
            plot!(total_Monthly_GW_future_45_PforF[:,1], ribbon = [total_Monthly_GW_future_45_PforF[:,1]-total_Monthly_GW_future_45_PforF[:,2], total_Monthly_GW_future_45_PforF[:,3]-total_Monthly_GW_future_45_PforF[:,1]], color=Farben_45[1], label="RCP4.5 Cl,stat", alpha=0.2)
        end
        if i==3
            ylabel!(" Relative Change in Groundwater Storage [%]", yguidefontsize=20)
        end
        #title!("Relative Change in GW RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [20mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)

        ylims!((-150,350))
        if i in [1,3,5]
            yticks!([-150:50:150;])
        else
            yticks!([-150:50:150;], ["","","","","","",""])
        end

        hline!([0], color=["grey"], linestyle = :dash)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        if i in 4:6
            xticks!([1:1:12;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        else
            xticks!([1:1:12;], ["", "", "","","","","","","","","","" ])

        end
        box = plot!()
        push!(all_boxplots, box)
    end

    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Monthly_GW/monthly_GW_all_catchments_relative_change_total.png")
end

# plot_changes_monthly_GW_all_catchments_relative(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_prec_temp_discharge_all_catchments_type(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        # for (i, name) in enumerate(Name_Projections_45)
        #     Timeseries_Future = collect(Date(Timeseries_End[i,1]-29,1,1):Day(1):Date(Timeseries_End[i,1],12,31))
        #     #print(size(Timeseries_Past), size(Timeseries_Future))
        #     Timeseries_Proj = readdlm(path_45*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
        #     Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
        #     Temperature = readdlm(path_45*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
        #     Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
        #     # get the temperature data at the mean elevation to calculate the mean potential evaporation
        #     Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
        #
        #     indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
        #     indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
        #     Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
        #     #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
        #     indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
        #     indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
        #     Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
        #     # calculate monthly mean temperature
        #     Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
        #     Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
        #
        #     #-------- PRECIPITATION ------------------
        #     Precipitation_All_Zones = Array{Float64, 1}[]
        #     Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
        #     for j in 1: length(ID_Prec_Zones)
        #             # get precipitation projections for the precipitation measurement
        #             Precipitation_Zone = readdlm(path_45*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
        #             #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
        #             push!(Precipitation_All_Zones, Precipitation_Zone ./10)
        #             Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
        #     end
        #     #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
        #     Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
        #     Precipitation_Future = Total_Precipitation_Proj[indexstart_future:indexend_future]
        #
        #
        #
        #     Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
        #     Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
        #     append!(average_monthly_Temperature_past45, mean(Monthly_Temperature_Past))
        #     append!(average_monthly_Temperature_future45, mean(Monthly_Temperature_Future))
        #     append!(average_monthly_Precipitation_past45, mean(Monthly_Precipitation_Past)*12)
        #     append!(average_monthly_Precipitation_future45, mean(Monthly_Precipitation_Future)*12)
        # end
        # for (i, name) in enumerate(Name_Projections_85)
        #     Timeseries_Future = collect(Date(Timeseries_End[i,2]-29,1,1):Day(1):Date(Timeseries_End[i,2],12,31))
        #     #print(size(Timeseries_Past), size(Timeseries_Future))
        #     Timeseries_Proj = readdlm(path_85*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
        #     Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
        #     Temperature = readdlm(path_85*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
        #     Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
        #     # get the temperature data at the mean elevation to calculate the mean potential evaporation
        #     Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
        #
        #     indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
        #     indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
        #     Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
        #     #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
        #     indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
        #     indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
        #     Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
        #     # calculate monthly mean temperature
        #     Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
        #     Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
        #
        #     #-------- PRECIPITATION ------------------
        #     Precipitation_All_Zones = Array{Float64, 1}[]
        #     Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
        #     for j in 1: length(ID_Prec_Zones)
        #             # get precipitation projections for the precipitation measurement
        #             Precipitation_Zone = readdlm(path_85*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
        #             #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
        #             push!(Precipitation_All_Zones, Precipitation_Zone ./10)
        #             Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
        #     end
        #     #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
        #     Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
        #     Precipitation_Future = Total_Precipitation_Proj[indexstart_future:indexend_future]
        #
        #     Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
        #     Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
        #
        #     Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
        #     Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
        #     append!(average_monthly_Temperature_past85, mean(Monthly_Temperature_Past))
        #     append!(average_monthly_Temperature_future85, mean(Monthly_Temperature_Future))
        #     append!(average_monthly_Precipitation_past85, mean(Monthly_Precipitation_Past)*12)
        #     append!(average_monthly_Precipitation_future85, mean(Monthly_Precipitation_Future)*12)
        #
        #     # take average over all months in timeseries
        #     # for month in 1:12
        #     #     current_Month_Temperature = Monthly_Temperature_Past[findall(x->x == month, Month)]
        #     #     current_Month_Temperature_future = Monthly_Temperature_Future[findall(x->x == month, Month_future)]
        #     #     current_Month_Temperature = mean(current_Month_Temperature)
        #     #     current_Month_Temperature_future = mean(current_Month_Temperature_future)
        #     #     append!(average_monthly_Temperature_past85, current_Month_Temperature)
        #     #     append!(average_monthly_Temperature_future85, current_Month_Temperature_future)
        #     #     #append!(all_months_all_runs, month)
        #     #
        #     #     current_Month_Precipitation = Monthly_Precipitation_Past[findall(x->x == month, Month)]
        #     #     current_Month_Precipitation_future = Monthly_Precipitation_Future[findall(x->x == month, Month_future)]
        #     #     current_Month_Precipitation = mean(current_Month_Precipitation)
        #     #     current_Month_Precipitation_future = mean(current_Month_Precipitation_future)
        #     #     #error = relative_error(current_Month_Discharge_future, current_Month_Discharge)
        #     #     append!(average_monthly_Precipitation_past85, current_Month_Precipitation)
        #     #     append!(average_monthly_Precipitation_future85, current_Month_Precipitation_future)
        #     # end
        # end
        Plots.plot()
        box_prec = []
        # xaxis_1 = collect(1:1:12)
        # boxPlots.plot([1], relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color=Farben_85[2])
        # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black")
        # violin!([2], relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85) * 100, color=Farben_45[2])
        # scatter!(ones(14)*2,relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)*100, color="black")#, minorticks=true, minorgrid=true)#, grid_linewidth=1, minorticks=true)
        #title!(Catchment_Name, titlefont = font(20))
        P_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_4.5.csv", ',')
        relative_error_P_45 = P_error_45[:,1]
        average_monthly_Precipitation_past45 = P_error_45[:,2]
        average_monthly_Precipitation_future45= P_error_45[:,3]
        P_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_8.5.csv", ',')
        relative_error_P_85 = P_error_85[:,1]
        average_monthly_Precipitation_past85 = P_error_85[:,2]
        average_monthly_Precipitation_future85= P_error_85[:,3]
        T_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_4.5.csv", ',')
        relative_error_T_45 = T_error_45[:,1]
        average_monthly_Temperature_past45 = T_error_45[:,2]
        average_monthly_Temperature_future45= T_error_45[:,3]
        T_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_8.5.csv", ',')
        relative_error_T_85 = T_error_85[:,1]
        average_monthly_Temperature_past85 = T_error_85[:,2]
        average_monthly_Temperature_future85= T_error_85[:,3]



        violin!([1], relative_error_P_45*100, color=Farben_45[2],  xticks=:none)
        scatter!(ones(14), relative_error_P_45*100, color="black", xticks=:none)
        scatter!([1], [mean(relative_error_P_45*100)], color="white",markerstrokecolour="black",markersize=7, xticks=:none)

        violin!([2], relative_error_P_85*100, color=Farben_85[2],xticks=:none)
        scatter!(ones(14)*2, relative_error_P_85*100, color="black",xticks=:none)
        scatter!([2], [mean(relative_error_P_85*100)], color="white",markerstrokecolour="black",markersize=7,xticks=:none)



        ylims!((-25,35))
        if h==1||h==6
            yticks!([-20:10:30;])
        else
            yticks!([-20:10:30;], ["", "", "", "", "",""])

        end
        box_prec = violin!(framestyle = :box, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#,  aspect_ratio=1)#aspect_ratio=1)
        push!(all_boxplots_prec, box_prec)
        if h==1
            ylabel!("∆ Precipitation [%]", yguidefontsize=20)
        end
        # ------------ temp ------------
        Plots.plot()

        box_temp = []

        violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[2],  xticks=:none)
        scatter!(ones(14), average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color="black")#,minorticks=true, minorgrid=true)
        violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[2],xticks=:none)
        scatter!(ones(14)*2, average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color="black")#,minorticks=true, minorgrid=true)
        scatter!([1], [mean(average_monthly_Temperature_future45 - average_monthly_Temperature_past45)], color="white",  markerstrokecolour="black", markersize=7, xticks=:none)
        scatter!([2], [mean(average_monthly_Temperature_future85 - average_monthly_Temperature_past85)], color="white", markerstrokecolour="black",markersize=7,xticks=:none)

        ylims!((0.5,7.5))

        if h==1 || h==6
            yticks!([1:1:7;])
        else
            yticks!([1:1:7;], ["", "", "", "", "","",""])

        end
        title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20), margin=20px)
        box_temp = violin!(framestyle = :box, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#, aspect_ratio=1)
        if h==1
            ylabel!("Temperature [°C]", yguidefontsize=20, left_margin=300px)
        end
        push!(all_boxplots_temp, box_temp)

        #discharge
        #for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
        relative_change_85 = monthly_changes_85[:,1]
        Total_Discharge_Past_85 = monthly_changes_85[:,2]
        Total_Discharge_Future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
        relative_change_45 = monthly_changes_45[:,1]
        Total_Discharge_Past_45 = monthly_changes_45[:,2]
        Total_Discharge_Future_45  = monthly_changes_45[:,3]
        #
        # for annual discharge
        # relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchment, nr_runs[h])
        # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs[h])
        # boxPlots.plot([1],relative_change_45*100, color=Farben_85[2])
        # violin!([2],relative_change_85*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
        # boxPlots.plot([1], relative_error(Total_Discharge_Future_45, Total_Discharge_Past_45)*100, color=Farben_85[2])
        # violin!([2], relative_error(Total_Discharge_Future_85, Total_Discharge_Past_85)*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
        Plots.plot()
        box_q = []
        violin!([1], relative_change_45*100, color=Farben_45[2], )
        violin!([2], relative_change_85*100, color=Farben_85[2], )
        scatter!([1], [mean(relative_change_45*100)], color="white",  markerstrokecolour="black", markerstrokewidth=1, markersize=7,xticks=:none)
        scatter!([2], [mean(relative_change_85*100)], color="white",markerstrokecolour="black",  markersize=7,xticks=:none)

        #, minorticks=true, minorgrid=true)
        # xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

            if Catchment_Name == "Pitztal"
                ylims!((-45,90))
                yticks!([-40:20:80;])
            else
                ylims!((-45,45))
                if h==1
                    yticks!([-40:20:40;])
                else
                    yticks!([-40:20:40;], ["", "", "", "", ""])

                end
            end
        xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        box_q = violin!(framestyle = :box,minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#, aspect_ratio=1)#, )#aspect_ratio=1)
        if h==1
            ylabel!("∆Q Sr,clim,adapt[%]", yguidefontsize=20)
        end
        push!(all_boxplots_q, box_q)

        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_PforF.txt", ',')
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_PforF.txt", ',')

        relative_change_85_PforF = monthly_changes_85_PforF[:,1]
        Total_Discharge_Past_85_PforF = monthly_changes_85_PforF[:,2]
        Total_Discharge_Future_85_PforF  = monthly_changes_85_PforF[:,3]
        relative_change_45_PforF = monthly_changes_45_PforF[:,1]
        Total_Discharge_Past_45_PforF = monthly_changes_45_PforF[:,2]
        Total_Discharge_Future_45_PforF  = monthly_changes_45_PforF[:,3]
        #
        # for annual discharge
        # relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchment, nr_runs[h])
        # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs[h])
        # boxPlots.plot([1],relative_change_45*100, color=Farben_85[2])
        # violin!([2],relative_change_85*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
        # boxPlots.plot([1], relative_error(Total_Discharge_Future_45, Total_Discharge_Past_45)*100, color=Farben_85[2])
        # violin!([2], relative_error(Total_Discharge_Future_85, Total_Discharge_Past_85)*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
        Plots.plot()
        box_q_pf = []
        violin!([1], relative_change_45_PforF*100, color=Farben_45[1],  xticks=:none)
        violin!([2], relative_change_85_PforF*100, color=Farben_85[1],  xticks=:none)#, minorticks=true, minorgrid=true)

            if Catchment_Name == "Pitztal"
                ylims!((-45,90))
                yticks!([-40:20:80;])
            else
                ylims!((-45,45))
                if h==1
                    yticks!([-40:20:40;])
                else
                    yticks!([-40:20:40;], ["", "", "", "", ""])

                end
            end
        scatter!([1], [mean(relative_change_45*100)], color="white", markerstrokecolour="black",markerstrokewidth=1, markersize=7,xticks=:none)
        scatter!([2], [mean(relative_change_85*100)], color="white",markerstrokecolour="black",markerstrokewidth=1,   markersize=7,xticks=:none)

        box_q_pf = violin!(framestyle = :box, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#, aspect_ratio=1)#, )#aspect_ratio=1)
        if h==1
            ylabel!("∆Q Sr,clim,stat [%]", yguidefontsize=20)
        end
        push!(all_boxplots_q_pf, box_q_pf)

        #end
    end
    Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        layout= (4,6), legend = false, size=(2600,1500), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/monthly_temperature_prec_Discharge_all_catchments_absolute_total.png")
end

function plot_changes_prec_temp_discharge_all_catchments_combined(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        Plots.plot()
        box_prec = []
        # xaxis_1 = collect(1:1:12)
        # boxPlots.plot([1], relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color=Farben_85[2])
        # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black")
        # violin!([2], relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85) * 100, color=Farben_45[2])
        # scatter!(ones(14)*2,relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)*100, color="black")#, minorticks=true, minorgrid=true)#, grid_linewidth=1, minorticks=true)
        #title!(Catchment_Name, titlefont = font(20))
        P_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_4.5.csv", ',')
        relative_error_P_45 = P_error_45[:,1]
        average_monthly_Precipitation_past45 = P_error_45[:,2]
        average_monthly_Precipitation_future45= P_error_45[:,3]
        P_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_8.5.csv", ',')
        relative_error_P_85 = P_error_85[:,1]
        average_monthly_Precipitation_past85 = P_error_85[:,2]
        average_monthly_Precipitation_future85= P_error_85[:,3]
        T_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_4.5.csv", ',')
        relative_error_T_45 = T_error_45[:,1]
        average_monthly_Temperature_past45 = T_error_45[:,2]
        average_monthly_Temperature_future45= T_error_45[:,3]
        T_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_8.5.csv", ',')
        relative_error_T_85 = T_error_85[:,1]
        average_monthly_Temperature_past85 = T_error_85[:,2]
        average_monthly_Temperature_future85= T_error_85[:,3]



        violin!([1], relative_error_P_45*100, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), relative_error_P_45*100, color="black", xticks=:none, label=false)
        scatter!([1], [mean(relative_error_P_45*100)], color="white",markerstrokecolour="black",markersize=7, xticks=:none, label=false)

        violin!([2], relative_error_P_85*100, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, relative_error_P_85*100, color="black",xticks=:none, label=false)
        scatter!([2], [mean(relative_error_P_85*100)], color="white",markerstrokecolour="black",markersize=7,xticks=:none, label=false)



        ylims!((-25,35))
        if h==1||h==6
            yticks!([-20:10:30;])
        else
            yticks!([-20:10:30;], ["", "", "", "", "",""])

        end
        xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        box_prec = violin!(framestyle = :box, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#,  aspect_ratio=1)#aspect_ratio=1)
        push!(all_boxplots_prec, box_prec)
        if h==1
            ylabel!("∆ Precipitation [%]", yguidefontsize=20)
        end
        # ------------ temp ------------
        Plots.plot()

        box_temp = []

        violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color="black", label=false)#,minorticks=true, minorgrid=true)
        violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color="black", label=false)#,minorticks=true, minorgrid=true)
        scatter!([1], [mean(average_monthly_Temperature_future45 - average_monthly_Temperature_past45)], color="white",  markerstrokecolour="black", markersize=7, xticks=:none, label=false)
        scatter!([2], [mean(average_monthly_Temperature_future85 - average_monthly_Temperature_past85)], color="white", markerstrokecolour="black",markersize=7,xticks=:none, label=false)

        ylims!((0.5,7.5))

        if h==1 || h==6
            yticks!([1:1:7;])
        else
            yticks!([1:1:7;], ["", "", "", "", "","",""])

        end

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end

        title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20), margin=20px, label=false)
        box_temp = violin!(framestyle = :box, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, label=false)#, aspect_ratio=1)
        if h==1
            ylabel!("∆ Temperature [°C]", yguidefontsize=20, left_margin=300px)
        end
        push!(all_boxplots_temp, box_temp)

        if Catchment_Name == "Feistritztal"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "Paltental"
            Catchment_Name = "Palten"
        end

        #discharge
        #for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
        relative_change_85 = monthly_changes_85[:,1]
        Total_Discharge_Past_85 = monthly_changes_85[:,2]
        Total_Discharge_Future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
        relative_change_45 = monthly_changes_45[:,1]
        Total_Discharge_Past_45 = monthly_changes_45[:,2]
        Total_Discharge_Future_45  = monthly_changes_45[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_PforF.txt", ',')
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_PforF.txt", ',')

        relative_change_85_PforF = monthly_changes_85_PforF[:,1]
        Total_Discharge_Past_85_PforF = monthly_changes_85_PforF[:,2]
        Total_Discharge_Future_85_PforF  = monthly_changes_85_PforF[:,3]
        relative_change_45_PforF = monthly_changes_45_PforF[:,1]
        Total_Discharge_Past_45_PforF = monthly_changes_45_PforF[:,2]
        Total_Discharge_Future_45_PforF  = monthly_changes_45_PforF[:,3]
        Plots.plot()
        box_q = []
        violin!([2], relative_change_45*100, color=Farben_45[2], label=false )
        violin!([4.5], relative_change_85*100, color=Farben_85[2], label=false)

        violin!([1], relative_change_45_PforF*100, color=Farben_45[1],  xticks=:none, label=false)
        violin!([3.5], relative_change_85_PforF*100, color=Farben_85[1],  xticks=:none, label=false)#, minorticks=true, minorgrid=true)

        scatter!(1*ones(14), relative_change_45*100, color="black",xticks=:none, label=false)
        scatter!(3.5*ones(14), relative_change_85*100, color="black",xticks=:none, label=false)
        scatter!(2*ones(14), relative_change_45*100, color="black", xticks=:none, label=false)
        scatter!(4.5*ones(14), relative_change_85*100, color="black",xticks=:none, label=false)

        scatter!([1], [mean(relative_change_45*100)], color="white", markerstrokecolour="black",markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([3.5], [mean(relative_change_85*100)], color="white",markerstrokecolour="black",markerstrokewidth=1,   markersize=7,xticks=:none, label=false)
        scatter!([2], [mean(relative_change_45*100)], color="white",  markerstrokecolour="black", markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([4.5], [mean(relative_change_85*100)], color="white",markerstrokecolour="black",  markersize=7,xticks=:none, label=false)


        #, minorticks=true, minorgrid=true)
        # xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        if Catchment_Name == "Pitztal"
            ylims!((-45,90))
            yticks!([-40:20:80;])
        else
            ylims!((-45,45))
            if h==1
                yticks!([-40:20:40;])
            else
                yticks!([-40:20:40;], ["", "", "", "", ""])

            end
        end

        box_q = violin!(framestyle = :box,minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, xticks=:none)#, aspect_ratio=1)#, )#aspect_ratio=1)
        if h==1
            ylabel!("∆ Annual Discharge[%]", yguidefontsize=20)
        end
        push!(all_boxplots_q, box_q)

        #
        box_q_pf = []
        Plots.plot()

        if h==6
            scatter!([1], relative_change_45_PforF*100, color=Farben_45[1], markerstrokewidth=0, xticks=:none,label="RCP4.5 Sr,clim,stat",markersize=5)
            scatter!([2], relative_change_45*100, color=Farben_45[2], markerstrokewidth=0,label="RCP4.5 Sr,clim,adapt",markersize=5 )
            scatter!([3.5], relative_change_85_PforF*100, color=Farben_85[1],markerstrokewidth=0,  xticks=:none, label="RCP8.5 Sr,clim,stat",markersize=5)#, minorticks=true, minorgrid=true)
            scatter!([4.5], relative_change_85*100, color=Farben_85[2], markerstrokewidth=0,label="RCP8.5 Sr,clim,adapt", legend=:topleft, markersize=5)
        end

            box_q_pf = violin!(framestyle = :box, axis=false, ticks=:none, legendfontsize=20)#, aspect_ratio=1)#, )#aspect_ratio=1)
            push!(all_boxplots_q_pf, box_q_pf)
        ylims!((-50,-49))

        #end
    end
    combined = Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        layout= (4,6), legend =:topright, size=(2600,1500), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    display(combined)

    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/monthly_temperature_prec_Discharge_all_catchments_absolute_combined.png")
end

function plot_changes_discharge_all_catchments_combined(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        Plots.plot()
        box_prec = []
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
        relative_change_85 = monthly_changes_85[:,1]
        Total_Discharge_Past_85 = monthly_changes_85[:,2]
        Total_Discharge_Future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
        relative_change_45 = monthly_changes_45[:,1]
        Total_Discharge_Past_45 = monthly_changes_45[:,2]
        Total_Discharge_Future_45  = monthly_changes_45[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_PforF.txt", ',')
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_PforF.txt", ',')

        relative_change_85_PforF = monthly_changes_85_PforF[:,1]
        Total_Discharge_Past_85_PforF = monthly_changes_85_PforF[:,2]
        Total_Discharge_Future_85_PforF  = monthly_changes_85_PforF[:,3]
        relative_change_45_PforF = monthly_changes_45_PforF[:,1]
        Total_Discharge_Past_45_PforF = monthly_changes_45_PforF[:,2]
        Total_Discharge_Future_45_PforF  = monthly_changes_45_PforF[:,3]
        Plots.plot()
        box_q = []
        if h==4
            scatter!([1], relative_change_45_PforF*100, color=Farben_45[1], markerstrokewidth=0, xticks=:none,label="RCP4.5 Sr,clim,stat",markersize=5)
            scatter!([2], relative_change_45*100, color=Farben_45[2], markerstrokewidth=0,label="RCP4.5 Sr,clim,adapt",markersize=5 )
            scatter!([3.5], relative_change_85_PforF*100, color=Farben_85[1],markerstrokewidth=0,  xticks=:none, label="RCP8.5 Sr,clim,stat",markersize=5)#, minorticks=true, minorgrid=true)
            scatter!([4.5], relative_change_85*100, color=Farben_85[2], markerstrokewidth=0,label="RCP8.5 Sr,clim,adapt", legend=:topleft, markersize=5)
        end
        violin!([2], relative_change_45*100, color=Farben_45[2], label=false )
        violin!([4.5], relative_change_85*100, color=Farben_85[2], label=false)

        violin!([1], relative_change_45_PforF*100, color=Farben_45[1],  xticks=:none, label=false)
        violin!([3.5], relative_change_85_PforF*100, color=Farben_85[1],  xticks=:none, label=false)#, minorticks=true, minorgrid=true)

        scatter!(1*ones(14), relative_change_45_PforF*100, color="black",xticks=:none, label=false)
        scatter!(3.5*ones(14), relative_change_85_PforF*100, color="black",xticks=:none, label=false)
        scatter!(2*ones(14), relative_change_45*100, color="black", xticks=:none, label=false)
        scatter!(4.5*ones(14), relative_change_85*100, color="black",xticks=:none, label=false)

        scatter!([1], [mean(relative_change_45_PforF*100)], color="white", markerstrokecolour="black",markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([3.5], [mean(relative_change_85_PforF*100)], color="white",markerstrokecolour="black",markerstrokewidth=1,   markersize=7,xticks=:none, label=false)
        scatter!([2], [mean(relative_change_45*100)], color="white",  markerstrokecolour="black", markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([4.5], [mean(relative_change_85*100)], color="white",markerstrokecolour="black",  markersize=7,xticks=:none, label=false)


        #, minorticks=true, minorgrid=true)
        # xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        if h in 4:6#Catchment_Name == "Pitztal"
            ylims!((-45,90))
            if h==4
                yticks!([-40:40:80;])
            else
                yticks!([-40:20:80;],["", "", "", "", ""])
            end
        else
            ylims!((-45,45))
            if h==1
                yticks!([-40:20:40;])
            else
                yticks!([-40:20:40;], ["", "", "", "", ""])

            end
        end

        box_q = violin!(framestyle = :box, grid=false, xticks=:none)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, xticks=:none)#, aspect_ratio=1)#, )#aspect_ratio=1)
        if h==1||h==4
            ylabel!("∆ Annual Discharge [%]", yguidefontsize=20)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[h])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[h])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[h])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20))
        end

        push!(all_boxplots_q, box_q)
        #
        # box_q_pf = []
        # Plots.plot()
        #
        # if h==6
        #     scatter!([1], relative_change_45_PforF*100, color=Farben_45[1], markerstrokewidth=0, xticks=:none,label="RCP4.5 Sr,clim,stat",markersize=5)
        #     scatter!([2], relative_change_45*100, color=Farben_45[2], markerstrokewidth=0,label="RCP4.5 Sr,clim,adapt",markersize=5 )
        #     scatter!([3.5], relative_change_85_PforF*100, color=Farben_85[1],markerstrokewidth=0,  xticks=:none, label="RCP8.5 Sr,clim,stat",markersize=5)#, minorticks=true, minorgrid=true)
        #     scatter!([4.5], relative_change_85*100, color=Farben_85[2], markerstrokewidth=0,label="RCP8.5 Sr,clim,adapt", legend=:topleft, markersize=5)
        # end
        #
        #     box_q_pf = violin!(framestyle = :box, axis=false, ticks=:none, legendfontsize=20)#, aspect_ratio=1)#, )#aspect_ratio=1)
        #     push!(all_boxplots_q_pf, box_q_pf)
        # ylims!((-50,-49))

        #end
    end
    combined = Plots.plot(#all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        #all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        # all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        layout= (2,3), legend =:topleft, size=(2500,1200), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), legendfontsize=20, dpi=300, topmargin=10px)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    display(combined)

    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/changes_Discharge_all_catchments_absolute_combined.png")
end

function plot_changes_discharge_all_catchments_combined_abs(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        Plots.plot()
        box_prec = []
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
        relative_change_85 = monthly_changes_85[:,1]
        Total_Discharge_Past_85_NS = monthly_changes_85[:,2]
        Total_Discharge_Future_85_NS  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
        relative_change_45 = monthly_changes_45[:,1]
        Total_Discharge_Past_45_NS = monthly_changes_45[:,2]
        Total_Discharge_Future_45_NS  = monthly_changes_45[:,3]
        monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_PforF.txt", ',')
        monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_PforF.txt", ',')

        relative_change_85_PforF = monthly_changes_85_PforF[:,1]
        Total_Discharge_Past_85_PforF = monthly_changes_85_PforF[:,2]
        Total_Discharge_Future_85_PforF  = monthly_changes_85_PforF[:,3]
        relative_change_45_PforF = monthly_changes_45_PforF[:,1]
        Total_Discharge_Past_45_PforF = monthly_changes_45_PforF[:,2]
        Total_Discharge_Future_45_PforF  = monthly_changes_45_PforF[:,3]

        Total_Discharge_Past_45_NS = convertDischarge(Total_Discharge_Past_45_NS, Area_Catchments[h])
        Total_Discharge_Past_85_NS = convertDischarge(Total_Discharge_Past_85_NS, Area_Catchments[h])
        Total_Discharge_Future_45_NS = convertDischarge(Total_Discharge_Future_45_NS, Area_Catchments[h])
        Total_Discharge_Future_85_NS = convertDischarge(Total_Discharge_Future_85_NS, Area_Catchments[h])
        Total_Discharge_Past_45_PforF = convertDischarge(Total_Discharge_Past_45_PforF, Area_Catchments[h])
        Total_Discharge_Past_85_PforF = convertDischarge(Total_Discharge_Past_85_PforF, Area_Catchments[h])
        Total_Discharge_Future_45_PforF = convertDischarge(Total_Discharge_Future_45_PforF, Area_Catchments[h])
        Total_Discharge_Future_85_PforF = convertDischarge(Total_Discharge_Future_85_PforF, Area_Catchments[h])

        Plots.plot()
        box_q = []
        if h==3
            scatter!([1], (Total_Discharge_Future_45_PforF-Total_Discharge_Past_45_PforF), color=Farben_45[1], markerstrokewidth=0, xticks=:none,label="RCP4.5 Sr,clim,stat",markersize=5)
            scatter!([2], (Total_Discharge_Future_45_NS-Total_Discharge_Past_45_NS), color=Farben_45[2], markerstrokewidth=0,label="RCP4.5 Sr,clim,adapt",markersize=5 )
            scatter!([3.5], (Total_Discharge_Future_85_PforF-Total_Discharge_Past_85_PforF), color=Farben_85[1],markerstrokewidth=0,  xticks=:none, label="RCP8.5 Sr,clim,stat",markersize=5)#, minorticks=true, minorgrid=true)
            scatter!([4.5], (Total_Discharge_Future_85_NS-Total_Discharge_Past_85_NS), color=Farben_85[2], markerstrokewidth=0,label="RCP8.5 Sr,clim,adapt", legend=:topleft, markersize=5)
        end
        violin!([2], (Total_Discharge_Future_45_NS-Total_Discharge_Past_45_NS), color=Farben_45[2], label=false )
        violin!([4.5], (Total_Discharge_Future_85_NS-Total_Discharge_Past_85_NS), color=Farben_85[2], label=false)

        violin!([1], (Total_Discharge_Future_45_PforF-Total_Discharge_Past_45_PforF), color=Farben_45[1],  xticks=:none, label=false)
        violin!([3.5], (Total_Discharge_Future_85_PforF-Total_Discharge_Past_85_PforF), color=Farben_85[1],  xticks=:none, label=false)#, minorticks=true, minorgrid=true)

        scatter!(1*ones(14), (Total_Discharge_Future_45_PforF-Total_Discharge_Past_45_PforF), color="black",xticks=:none, label=false)
        scatter!(3.5*ones(14), (Total_Discharge_Future_85_PforF-Total_Discharge_Past_85_PforF), color="black",xticks=:none, label=false)
        scatter!(2*ones(14), (Total_Discharge_Future_45_NS-Total_Discharge_Past_45_NS), color="black", xticks=:none, label=false)
        scatter!(4.5*ones(14), (Total_Discharge_Future_85_NS-Total_Discharge_Past_85_NS), color="black",xticks=:none, label=false)

        scatter!([1], [mean((Total_Discharge_Future_45_PforF-Total_Discharge_Past_45_PforF))], color="white", markerstrokecolour="black",markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([3.5], [mean((Total_Discharge_Future_85_PforF-Total_Discharge_Past_85_PforF))], color="white",markerstrokecolour="black",markerstrokewidth=1,   markersize=7,xticks=:none, label=false)
        scatter!([2], [mean((Total_Discharge_Future_45_NS-Total_Discharge_Past_45_NS))], color="white",  markerstrokecolour="black", markerstrokewidth=1, markersize=7,xticks=:none, label=false)
        scatter!([4.5], [mean((Total_Discharge_Future_85_NS-Total_Discharge_Past_85_NS))], color="white",markerstrokecolour="black",  markersize=7,xticks=:none, label=false)


        #, minorticks=true, minorgrid=true)
        # xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        if h in 4:6#Catchment_Name == "Pitztal"
            ylims!((-300,400))
            if h==4
                yticks!([-300:150:450;])
            else
                yticks!([-300:150:450;],["", "", "", "", "", ""])
            end
        else
            ylims!((-150,150))
            if h==1
                yticks!([-150:75:150;])
            else
                yticks!([-150:75:150;], ["", "", "", "", "", "", ""])

            end
        end

        box_q = violin!(framestyle = :box, grid=false, xticks=:none)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, xticks=:none)#, aspect_ratio=1)#, )#aspect_ratio=1)
        if h==1||h==4
            ylabel!("∆ Annual Discharge [mm]", yguidefontsize=20)
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[h])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[h])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[h])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20))
        end
        push!(all_boxplots_q, box_q)
    end
    combined = Plots.plot(#all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        #all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        # all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        layout= (2,3), legend =:topright, size=(2500,1200), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), legendfontsize=20, dpi=300, topmargin=10px)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    display(combined)

    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/changes_Discharge_all_catchments_absolute_combined_abs.png")
end
#
# plot_changes_discharge_all_catchments_combined_abs(Catchment_Names_new, Catchment_Height, nr_runs_new)
# plot_changes_discharge_all_catchments_combined(Catchment_Names_new, Catchment_Height, nr_runs_new)

# plot_changes_prec_temp_discharge_all_catchments_combined(Catchment_Names_new, Catchment_Height, nr_runs_new)
function plot_changes_prec_temp_all_catchments_combined(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        Plots.plot()
        box_prec = []
        # xaxis_1 = collect(1:1:12)
        # boxPlots.plot([1], relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color=Farben_85[2])
        # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black")
        # violin!([2], relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85) * 100, color=Farben_45[2])
        # scatter!(ones(14)*2,relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)*100, color="black")#, minorticks=true, minorgrid=true)#, grid_linewidth=1, minorticks=true)
        #title!(Catchment_Name, titlefont = font(20))
        P_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_4.5.csv", ',')
        relative_error_P_45 = P_error_45[:,1]
        average_monthly_Precipitation_past45 = P_error_45[:,2]
        average_monthly_Precipitation_future45= P_error_45[:,3]
        P_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_8.5.csv", ',')
        relative_error_P_85 = P_error_85[:,1]
        average_monthly_Precipitation_past85 = P_error_85[:,2]
        average_monthly_Precipitation_future85= P_error_85[:,3]
        T_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_4.5.csv", ',')
        relative_error_T_45 = T_error_45[:,1]
        average_monthly_Temperature_past45 = T_error_45[:,2]
        average_monthly_Temperature_future45= T_error_45[:,3]
        T_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_8.5.csv", ',')
        relative_error_T_85 = T_error_85[:,1]
        average_monthly_Temperature_past85 = T_error_85[:,2]
        average_monthly_Temperature_future85= T_error_85[:,3]


        hline!([0], color=["grey"], linestyle = :dash, label=false)

        violin!([1], relative_error_P_45*100, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), relative_error_P_45*100, color="black", xticks=:none, label=false)
        scatter!([1], [mean(relative_error_P_45*100)], color="white",markerstrokecolour="black",markersize=7, xticks=:none, label=false)

        violin!([2], relative_error_P_85*100, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, relative_error_P_85*100, color="black",xticks=:none, label=false)
        scatter!([2], [mean(relative_error_P_85*100)], color="white",markerstrokecolour="black",markersize=7,xticks=:none, label=false)

        # violin!([1], relative_error_P_45*100, color=Farben_45[2],  xticks=:none, label=false)
        # violin!([2], relative_error_P_85*100, color=Farben_85[2],xticks=:none, label=false)



        ylims!((-25,35))
        if h==1||h==6
            yticks!([-20:10:30;])
        else
            yticks!([-20:10:30;], ["", "", "", "", "",""])

        end
        xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        box_prec = violin!(framestyle = :box, grid=false)# minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#,  aspect_ratio=1)#aspect_ratio=1)
        push!(all_boxplots_prec, box_prec)
        if h==1
            ylabel!("∆ Precipitation [%]", yguidefontsize=20)
        end
        # ------------ temp ------------
        Plots.plot()

        box_temp = []
        violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color="black", label=false)#,minorticks=true, minorgrid=true)
        violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color="black", label=false)#,minorticks=true, minorgrid=true)
        scatter!([1], [mean(average_monthly_Temperature_future45 - average_monthly_Temperature_past45)], color="white",  markerstrokecolour="black", markersize=7, xticks=:none, label=false)
        scatter!([2], [mean(average_monthly_Temperature_future85 - average_monthly_Temperature_past85)], color="white", markerstrokecolour="black",markersize=7,xticks=:none, label=false)
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[7],  xticks=:none, label=false)
        # violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[7],xticks=:none, label=false)


        ylims!((0.5,7.5))

        if h==1 || h==6
            yticks!([1:1:7;], ["    1", "    2", "    3", "    4", "    5","    6","    7"])
        else
            yticks!([1:1:7;], ["", "", "", "", "","",""])

        end

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end

        title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20), margin=20px, label=false)
        box_temp = violin!(framestyle = :box, grid=false,label=false)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, label=false)#, aspect_ratio=1)
        if h==1
            ylabel!("∆ Temperature [°C]", yguidefontsize=20, left_margin=300px)
        end
        push!(all_boxplots_temp, box_temp)

        if Catchment_Name == "Feistritztal"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "Paltental"
            Catchment_Name = "Palten"
        end

    end
    combined = Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        # all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        # all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        layout= (2,6), legend =:topright, size=(2500,750), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    display(combined)

    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/changes_temperature_prec_all_catchments_absolute_combined.png")
end
# plot_changes_discharge_all_catchments_combined(Catchment_Names_new, Catchment_Height, nr_runs_new)

# plot_changes_prec_temp_all_catchments_combined(Catchment_Names_new, Catchment_Height, nr_runs_new)
function plot_monthly_runoff_coefficient_change(All_Catchment_Names, Elevation, seasonal_month)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_violins = []
    all_violins_85 = []
    labels=[]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)

        println(Catchment_Name)
        if seasonal_month == "month"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_8.5_new.txt", ',')

        elseif seasonal_month == "seasonal"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_8.5.txt", ',')

        end
        monthly_runoff_coef_past_45_NS = monthly_runoff_coef_45_NS[:,1]
        monthly_runoff_coef_future_45_NS = monthly_runoff_coef_45_NS[:,2]
        months_45_NS  = monthly_runoff_coef_45_NS[:,3]

        monthly_runoff_coef_past_85_NS = monthly_runoff_coef_85_NS[:,1]
        monthly_runoff_coef_future_85_NS = monthly_runoff_coef_85_NS[:,2]
        months_85_NS  = monthly_runoff_coef_85_NS[:,3]

        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]

        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]


        if seasonal_month == "month"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end
            println(avg_change_monthly_runoff_coef_85_NS)
            println(avg_change_monthly_runoff_coef_85_PforF)
            println(avg_change_monthly_runoff_coef_45_NS)
            println(avg_change_monthly_runoff_coef_45_PforF)



            for month in 1:12
                if i==1 && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=false, falpha=0.3)

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            # Plots.plot()
            # box = []
            # #absolute change
            # for month in 1:12
            #     violin!([xaxis_45[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="RCP 4.5", outlier=false)
            #     violin!([xaxis_85[month]],monthly_runoff_coef_future_85[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            # end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm],right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()

            ylims!((0,2))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            box = plot!()
            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_PforF)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:12
                if Catchment_Name=="Silbertal" && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=labels[3], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=labels[4], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=labels[1], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=labels[2], falpha=0.3)

                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=8, label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)


                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm], right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()
            push!(all_violins_85, box)


        elseif seasonal_month == "seasonal"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)


                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid, linewidth=3)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end
            #ylabel!("abs. change monthly Q/P", yguidefontsize=20)
            # if Catchment_Name != "Pitztal" && Catchment_Name !="Defreggental" && Catchment_Name !="Gailtal"#IllSugadin"
            #     ylims!((-0.5,0.5))
            # else
            if i==1 || i==4
                ylabel!("absolute ∆Q/P [-]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-0.5,1))
                if i==1
                    yticks!([-0.25:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","",""])

                end
            else
                ylims!((-0.75,1))

                if i==4
                    yticks!([-0.5:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","","",""])

                end
            end

            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            box=plot!(left_margin = [20mm 10mm 10mm], right_margin = [10mm 10mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            else
                xticks!([1:1:4;], ["", "", "", ""])

            end

            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)

                scatter!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-45,65))
                if i ==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["","","","","",""])

                end
            else
                ylims!((-65,155))
                if i ==4
                    yticks!([-60:30:150;])
                else
                    yticks!([-60:30:150;], ["","","","","","","",""])

                end

            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)

            plot!(left_margin = [20mm 10mm 10mm], right_margin = [1mm 10mm 20mm],bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            end
            box = plot!()
            push!(all_violins_85, box)
        end
    end


    if seasonal_month == "month"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend =:topleft, legendfontsize=20,size=(2000,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_abs_change.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(200,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_past_future_rel_change.png")
    elseif seasonal_month == "seasonal"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_abs_change_grid.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20, size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_past_future_rel_change_grid.png")
    end
    return all_violins, all_violins_85
end
function plot_RC_violin_all_catchments_combined(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change, seasonal_month)
    Plots.plot()
    all_boxplots=[]
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        if seasonal_month == "month"
            monthly_runoff_coef_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_8.5_new.txt", ',')

        elseif seasonal_month == "seasonal"
            monthly_runoff_coef_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_8.5.txt", ',')

        end
        Plots.plot()

        monthly_runoff_coef_past_45 = monthly_runoff_coef_45[:,1]
        monthly_runoff_coef_future_45 = monthly_runoff_coef_45[:,2]
        months_45  = monthly_runoff_coef_45[:,3]

        monthly_runoff_coef_past_85 = monthly_runoff_coef_85[:,1]
        monthly_runoff_coef_future_85 = monthly_runoff_coef_85[:,2]
        months_85  = monthly_runoff_coef_85[:,3]

        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]

        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]

        if change == "relative"
            violin!([1], relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            violin!([2], relative_error(monthly_runoff_coef_future_45, monthly_runoff_coef_past_45)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([1], relative_error(monthly_runoff_coef_future_45, monthly_runoff_coef_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
            violin!([3], relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            violin!([4], relative_error(monthly_runoff_coef_future_85, monthly_runoff_coef_past_85)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([2], relative_error(monthly_runoff_coef_future_85, monthly_runoff_coef_past_85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, label=false)
            scatter!(ones(14), relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100, size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            scatter!(ones(14)*2, relative_error(monthly_runoff_coef_future_45, monthly_runoff_coef_past_45)*100, size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
            scatter!(ones(14)*3, relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100, size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!(ones(14)*4, relative_error(monthly_runoff_coef_future_85,monthly_runoff_coef_past_85)*100, size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            scatter!([1], [mean(relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!([2], [mean(relative_error(monthly_runoff_coef_future_45,monthly_runoff_coef_past_45)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!([3], [mean(relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!([4], [mean(relative_error(monthly_runoff_coef_future_85,monthly_runoff_coef_past_85)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            if i==1
                ylabel!("Relative change in runoff coefficient [%]")
            end
            xticks!([1:1:2;],["",""])
            if i in 1:3
                ylims!((-50,90))
                if i==1
                    yticks!([-40:20:80;])
                else
                    yticks!([-40:20:80;], ["","","","","","",""])
                end
            else
                ylims!((-60,180))
                if i==4
                    yticks!([-50:25:175;])
                else
                    yticks!([-50:25:175;], ["","","","","","","","","",""])
                end
            end


        elseif change == "absolute"
            violin!([1], monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            violin!([2], monthly_runoff_coef_future_45- monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
            violin!([3], monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            violin!([4], monthly_runoff_coef_future_85-monthly_runoff_coef_past_85, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!(ones(14), [monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF], size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            scatter!(ones(14)*2, [monthly_runoff_coef_future_45- monthly_runoff_coef_past_45], size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
            scatter!(ones(14)*3, [monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF], size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!(ones(14)*4, [monthly_runoff_coef_future_85-monthly_runoff_coef_past_85], size=(2000,800), leg=false, color="black", left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!([1], [mean(monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            scatter!([2], [mean(monthly_runoff_coef_future_45- monthly_runoff_coef_past_45)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
            scatter!([3], [mean(monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
            scatter!([4], [mean(monthly_runoff_coef_future_85-monthly_runoff_coef_past_85)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7,left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

            # boxplot!([2], (monthly_runoff_coef_future_85 - monthly_runoff_coef_past_85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, label=false)
            # println(Catchment_Name)
            # println("Change 45 ", median((monthly_runoff_coef_future_45 - monthly_runoff_coef_past_45)))
            # println("Change 85 ", median((monthly_runoff_coef_future_85 - monthly_runoff_coef_past_85)))
            if i==1
                ylabel!("Absolute change in runoff coefficient [%]")
            end

            xticks!([1:1:2;],["",""])
            if i in 1:1:2
                ylims!((-0.3,0.5))
                if i==1
                    yticks!([-0.2:0.1:0.4;])
                else
                    yticks!([-0.2:0.1:0.4;], ["","","","","","",""])
                end
            else
                ylims!((-0.4,1.3))
                if i==1
                    yticks!([-0.3:0.3:1.2;])
                else
                    yticks!([-0.3:0.3:1.2;], ["","","","","",""])
                end
            end
        end



        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
        end
        # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft)
        push!(all_boxplots,box_85)
    end
    box1 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(1,6), size=(4400,1000), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[40mm 0mm 0mm 0mm 0mm 0mm])

    if change=="absolute"
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_abs_change_violin.png")
    else
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_rel_change_violin.png")
    end
    return all_boxplots
end
function plot_monthly_runoff_coefficient_change_violin(All_Catchment_Names, Elevation, seasonal_month)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------

    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_violins = []
    all_violins_85 = []
    labels=[]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)

        println(Catchment_Name)
        if seasonal_month == "month"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_8.5_new.txt", ',')

        elseif seasonal_month == "seasonal"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_8.5.txt", ',')

        end
        monthly_runoff_coef_past_45_NS = monthly_runoff_coef_45_NS[:,1]
        monthly_runoff_coef_future_45_NS = monthly_runoff_coef_45_NS[:,2]
        months_45_NS  = monthly_runoff_coef_45_NS[:,3]

        monthly_runoff_coef_past_85_NS = monthly_runoff_coef_85_NS[:,1]
        monthly_runoff_coef_future_85_NS = monthly_runoff_coef_85_NS[:,2]
        months_85_NS  = monthly_runoff_coef_85_NS[:,3]

        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]

        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]


        if seasonal_month == "month"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end
            println(avg_change_monthly_runoff_coef_85_NS)
            println(avg_change_monthly_runoff_coef_85_PforF)
            println(avg_change_monthly_runoff_coef_45_NS)
            println(avg_change_monthly_runoff_coef_45_PforF)



            for month in 1:12
                if i==1 && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=false, falpha=0.3)

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            # Plots.plot()
            # box = []
            # #absolute change
            # for month in 1:12
            #     violin!([xaxis_45[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="RCP 4.5", outlier=false)
            #     violin!([xaxis_85[month]],monthly_runoff_coef_future_85[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            # end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm],right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()

            ylims!((0,2))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            box = plot!()
            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_PforF)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:12
                if Catchment_Name=="Silbertal" && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=labels[3], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=labels[4], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=labels[1], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=labels[2], falpha=0.3)

                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=8, label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)


                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm], right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()
            push!(all_violins_85, box)


        elseif seasonal_month == "seasonal"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)


                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid, linewidth=3)

                violin!([xaxis_85[month]],monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
                violin!([xaxis_45[month]],monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)

            end
            #ylabel!("abs. change monthly Q/P", yguidefontsize=20)
            # if Catchment_Name != "Pitztal" && Catchment_Name !="Defreggental" && Catchment_Name !="Gailtal"#IllSugadin"
            #     ylims!((-0.5,0.5))
            # else
            if i==1 || i==4
                ylabel!("absolute ∆Q/P [-]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-0.5,1))
                if i==1
                    yticks!([-0.25:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","",""])

                end
            else
                ylims!((-0.75,1))

                if i==4
                    yticks!([-0.5:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","","",""])

                end
            end

            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            box=plot!(left_margin = [20mm 10mm 10mm], right_margin = [10mm 10mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            else
                xticks!([1:1:4;], ["", "", "", ""])

            end

            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)

                scatter!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-45,65))
                if i ==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["","","","","",""])

                end
            else
                ylims!((-65,155))
                if i ==4
                    yticks!([-60:30:150;])
                else
                    yticks!([-60:30:150;], ["","","","","","","",""])

                end

            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)

            plot!(left_margin = [20mm 10mm 10mm], right_margin = [1mm 10mm 20mm],bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            end
            box = plot!()
            push!(all_violins_85, box)
        end
    end


    if seasonal_month == "month"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend =:topleft, legendfontsize=20,size=(2000,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_abs_change.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(200,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_past_future_rel_change.png")
    elseif seasonal_month == "seasonal"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_abs_change_grid.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20, size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_past_future_rel_change_grid.png")
    end
    return all_violins, all_violins_85
end

function combined_plot_runoff(All_Catchment_Names, Elevation)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_violins_abs = []
    all_lines_abs = []
    all_violins_rel = []
    all_lines_rel = []
    total_r = []
    total_a= []
    labels=[]
    xaxis_45 = collect(1:1:4)
    xaxis_85 = collect(1:1:4)


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)

        println(Catchment_Name)

        monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
        monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')
        monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_4.5.txt", ',')
        monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_8.5.txt", ',')

        monthly_runoff_coef_past_45_NS = monthly_runoff_coef_45_NS[:,1]
        monthly_runoff_coef_future_45_NS = monthly_runoff_coef_45_NS[:,2]
        months_45_NS  = monthly_runoff_coef_45_NS[:,3]

        monthly_runoff_coef_past_85_NS = monthly_runoff_coef_85_NS[:,1]
        monthly_runoff_coef_future_85_NS = monthly_runoff_coef_85_NS[:,2]
        months_85_NS  = monthly_runoff_coef_85_NS[:,3]

        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]

        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]

        Plots.plot()
        box = []
        avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
        avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
        avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
        avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

        for month in 1:4
            change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
            change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
            change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
            change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
            avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
            avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
            avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
            avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
        end

        for month in 1:4
            if Catchment_Name=="Feistritz" && month==4
                labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
            else
                labels=[false,false,false,false]
            end

            plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)

            scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[1], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid, linewidth=3)
            scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[2], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid, linewidth=3)
            scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid, linewidth=3)
            scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[2], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid, linewidth=3)


        end

        if i==1 || i==4
            ylabel!("∆ Runoff Coefficient [-]", yguidefontsize=20)
        end
        if i in 1:3
            ylims!((-0.5,1))
            if i==1
                yticks!([-0.25:0.25:0.75;])

            else
                yticks!([-0.25:0.25:0.75;], ["","","","",""])

            end
        else
            ylims!((-0.75,1))

            if i==4
                yticks!([-0.5:0.25:0.75;])
            else
                yticks!([-0.25:0.25:0.75;], ["","","","","",""])

            end
        end
        title!("Seasonal", titlefont=20)
        #ylims!((0,5))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        box=plot!(bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, grid=false, legendfontsize=20, legend=:topleft)
        if i in 4:6
            xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
        else
            xticks!([1:1:4;], ["", "", "", ""])

        end

        push!(all_lines_abs, box)

        Plots.plot()
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        violin!([1], monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF, size=(2000,800), leg=false, color=[Farben_45[1]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        violin!([2], monthly_runoff_coef_future_45_NS- monthly_runoff_coef_past_45_NS, size=(2000,800), leg=false, color=[Farben_45[2]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
        violin!([3], monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF, size=(2000,800), leg=false, color=[Farben_85[1]], minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        violin!([4], monthly_runoff_coef_future_85_NS-monthly_runoff_coef_past_85_NS, size=(2000,800), leg=false, color=[Farben_85[2]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!(ones(14), [monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF], size=(2000,800), leg=false, color="black", minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        scatter!(ones(14)*2, [monthly_runoff_coef_future_45_NS- monthly_runoff_coef_past_45_NS], size=(2000,800), leg=false, color="black", minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
        scatter!(ones(14)*3, [monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF], size=(2000,800), leg=false, color="black", minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!(ones(14)*4, [monthly_runoff_coef_future_85_NS-monthly_runoff_coef_past_85_NS], size=(2000,800), leg=false, color="black",  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!([1], [mean(monthly_runoff_coef_future_45_PforF- monthly_runoff_coef_past_45_PforF)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        scatter!([2], [mean(monthly_runoff_coef_future_45_NS- monthly_runoff_coef_past_45_NS)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
        scatter!([3], [mean(monthly_runoff_coef_future_85_PforF- monthly_runoff_coef_past_85_PforF)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!([4], [mean(monthly_runoff_coef_future_85_NS-monthly_runoff_coef_past_85_NS)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        title!("Annual" ,titlefont=20)

        if i in 1:3
            ylims!((-0.5,1))
            yticks!([-0.25:0.25:0.75;], ["","","","",""])
        else
            ylims!((-0.75,1))
            yticks!([-0.25:0.25:0.75;], ["","","","","",""])
        end
        xticks!([1:1:4;], ["", "", "", ""])

        abs_viol = plot!(legendfontsize=20, grid=false)
        push!(all_violins_abs, abs_viol)



        #------ RELATIVE CHANGE IN RUNOFF
        # for RCP 8.5
        Plots.plot()
        box = []
        # relative chagne
        rel_avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
        rel_avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
        rel_avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
        rel_avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

        for month in 1:4
            change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
            change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
            change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
            change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
            rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
            rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
            rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
            rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
        end

        for month in 1:4
            if i==4 && month==4
                labels=["RCP 4.5 Sr,clim,stat", "RCP 4.5 Sr,clim,adapt", "RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"]
            else
                labels=[false,false,false,false]
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)

            plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
            plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)

            scatter!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid)
            scatter!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid)
            scatter!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid)
            scatter!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid)

            # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
            # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]],  minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
        end


        if i in 1:3
            ylims!((-45,65))
            if i ==1
                yticks!([-40:20:60;])
                # plot!(left_margin=20mm)
            else
                yticks!([-40:20:60;], ["","","","","",""])

            end
        else
            ylims!((-65,155))
            if i ==4
                yticks!([-60:30:150;])
            else
                yticks!([-60:30:150;], ["","","","","","","",""])

            end

        end
        #ylims!((0,5))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        if i==1|| i==4
            ylabel!("∆ Runoff Coefficient [%]", yguidefontsize=20)
        end

        plot!(bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false,grid=false,legendfontsize=20, legend=:topleft)
        if i in 4:6
            xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
        else
            xticks!([1:1:4;], ["", "", "", ""])

        end
        title!("Seasonal", titlefont=20)
        # if i==1|| i==4
        #     ylabel!("∆ Runoff Coefficient [-]", yguidefontsize=20)
        # end

        box = plot!()
        push!(all_lines_rel, box)

        Plots.plot()
        hline!([0], color=["grey"], linestyle = :dash, label=false)

        violin!([1], relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100, size=(2000,800), leg=false, color=[Farben_45[1]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        violin!([2], relative_error(monthly_runoff_coef_future_45_NS, monthly_runoff_coef_past_45_NS)*100, size=(2000,800), leg=false, color=[Farben_45[2]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([1], relative_error(monthly_runoff_coef_future_45, monthly_runoff_coef_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
        violin!([3], relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100, size=(2000,800), leg=false, color=[Farben_85[1]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        violin!([4], relative_error(monthly_runoff_coef_future_85_NS, monthly_runoff_coef_past_85_NS)*100, size=(2000,800), leg=false, color=[Farben_85[2]],  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([2], relative_error(monthly_runoff_coef_future_85, monthly_runoff_coef_past_85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, label=false)
        scatter!(ones(14), relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100, size=(2000,800), leg=false, color="black",  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        scatter!(ones(14)*2, relative_error(monthly_runoff_coef_future_45_NS, monthly_runoff_coef_past_45_NS)*100, size=(2000,800), leg=false, color="black",  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        # boxplot!([1], monthly_runoff_coef_future_45, monthly_runoff_coef_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label=false)
        scatter!(ones(14)*3, relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100, size=(2000,800), leg=false, color="black",  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!(ones(14)*4, relative_error(monthly_runoff_coef_future_85_NS,monthly_runoff_coef_past_85_NS)*100, size=(2000,800), leg=false, color="black",  minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        scatter!([1], [mean(relative_error(monthly_runoff_coef_future_45_PforF, monthly_runoff_coef_past_45_PforF)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!([2], [mean(relative_error(monthly_runoff_coef_future_45_NS,monthly_runoff_coef_past_45_NS)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!([3], [mean(relative_error(monthly_runoff_coef_future_85_PforF, monthly_runoff_coef_past_85_PforF)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)
        scatter!([4], [mean(relative_error(monthly_runoff_coef_future_85_NS,monthly_runoff_coef_past_85_NS)*100)], size=(2000,800), leg=false, color="white", markerstrokecolour="black", markersize=7, minorticks = true, gridlinewidth=2, framestyle = :box, label=false)

        # if i==1
        #     ylabel!("Relative change in runoff coefficient [%]")
        # end
        xticks!([1:1:4;], ["", "", "", ""])
        if i in 1:3
            ylims!((-50,90))
            yticks!([-40:20:80;], ["","","","","","",""])

        else
            ylims!((-60,180))
            yticks!([-50:25:175;], ["","","","","","","","","",""])

        end
        title!("Annual", titlefont=20)
        box_85 = boxplot!(bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft, grid=false)
        push!(all_violins_rel, box_85)


    end

    for (i, Catchment_Name) in enumerate(All_Catchment_Names)

        plottitle=0
        if Catchment_Name == "Feistritz"
            plottitle="Feistritztal ("*string(Elevation[i])*"m)"
        elseif Catchment_Name == "Palten"
            plottitle="Paltental ("*string(Elevation[i])*"m)"
        else
            plottitle=Catchment_Name*" ("*string(Elevation[i])*"m)"
        end

        title = plot(title = plottitle, grid = false, showaxis = false, titlefont = font(20), xticks=:none, yticks=:none)
        Plots.plot(title, all_lines_rel[i], all_violins_rel[i], left_margin = 0mm, bottom_margin=10mm, layout=@layout([A{0.01h}; [B C{0.3w}]]), legend=:topleft)
        # Plots.plot(all_lines_rel[i], all_violins_rel[i], layout=@layout[a b{0.3w}])
        allrel=plot!()

        push!(total_r, allrel)
        Plots.plot(title, all_lines_abs[i], all_violins_abs[i], left_margin = 0mm, bottom_margin=10mm,layout=@layout([A{0.01h}; [B C{0.3w}]]), legend=:topleft)
        # ylabel!("∆ Runoff Coefficient [-]", yguidefontsize=20)

        allabs=plot!()

        push!(total_a, allabs)
    end
    println(length(total_r))
    println(length(total_a))


    R = Plots.plot(total_r[1],total_r[2],total_r[3],total_r[4],total_r[5],total_r[6], layout=(2,3), bottom_margin=20px, size=(2500,1200), left_margin=[0mm 20mm 0mm 0mm 0mm 0mm 0mm 0mm 0mm])
    # ylabel!("∆ Runoff Coefficient [%]", yguidefontsize=20)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_rel_change_combined.png")


    A = Plots.plot(total_a[1],total_a[2],total_a[3],total_a[4],total_a[5],total_a[6], layout=(2,3),bottom_margin=20px, size=(2500,1200), left_margin=[0mm 20mm 0mm 0mm 0mm 0mm 0mm 0mm 0mm])
    # ylabel!("∆ Runoff Coefficient [-]", yguidefontsize=20)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_abs_change_combined.png")

end



# combined_plot_runoff(Catchment_Names_new, Catchment_Height)




function plot_monthly_runoff_coefficient_change_combined(All_Catchment_Names, Elevation, seasonal_month)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    all_violins = []
    all_violins_85 = []
    labels=[]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)

        println(Catchment_Name)
        if seasonal_month == "month"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_monthly_runoff_coefficient_8.5_new.txt", ',')

        elseif seasonal_month == "seasonal"
            monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')
            monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/PforF_seasonal_runoff_coefficient_8.5.txt", ',')

        end
        monthly_runoff_coef_past_45_NS = monthly_runoff_coef_45_NS[:,1]
        monthly_runoff_coef_future_45_NS = monthly_runoff_coef_45_NS[:,2]
        months_45_NS  = monthly_runoff_coef_45_NS[:,3]

        monthly_runoff_coef_past_85_NS = monthly_runoff_coef_85_NS[:,1]
        monthly_runoff_coef_future_85_NS = monthly_runoff_coef_85_NS[:,2]
        months_85_NS  = monthly_runoff_coef_85_NS[:,3]

        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]

        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]


        if seasonal_month == "month"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end
            println(avg_change_monthly_runoff_coef_85_NS)
            println(avg_change_monthly_runoff_coef_85_PforF)
            println(avg_change_monthly_runoff_coef_45_NS)
            println(avg_change_monthly_runoff_coef_45_PforF)



            for month in 1:12
                if i==1 && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=false, falpha=0.3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=false, falpha=0.3)

                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=8, label=:none)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            # Plots.plot()
            # box = []
            # #absolute change
            # for month in 1:12
            #     violin!([xaxis_45[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="RCP 4.5", outlier=false)
            #     violin!([xaxis_85[month]],monthly_runoff_coef_future_85[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            # end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm],right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()

            ylims!((0,2))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            box = plot!()
            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(12,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(12,3)

            for month in 1:12
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_PforF)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:12
                if Catchment_Name=="Silbertal" && month==12
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[2], label=labels[3], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[1], label=labels[4], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[2], label=labels[1], falpha=0.3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[1], label=labels[2], falpha=0.3)

                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=8, label=:none)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle,  markerstrokewidth=0, markersize=8,label=:none)


                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end
            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            plot!(left_margin = [20mm 0mm 0mm], right_margin = [0mm 0mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, xticks=:none)
            if i in 4:6
                xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            else
                xticks!([1.5:2:23.5;], ["", "", "", "", "","", "", "", "", "", "", ""])

            end
            box = plot!()
            push!(all_violins_85, box)


        elseif seasonal_month == "seasonal"
            Plots.plot()
            box = []
            avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] - monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
                change_monthly_runoff_coef_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] - monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
                change_monthly_runoff_coef_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] - monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)]
                avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end

                plot!(avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_85_NS[:,1]-avg_change_monthly_runoff_coef_85_NS[:,2], avg_change_monthly_runoff_coef_85_NS[:,3]-avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_85_PforF[:,1]-avg_change_monthly_runoff_coef_85_PforF[:,2], avg_change_monthly_runoff_coef_85_PforF[:,3]-avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [avg_change_monthly_runoff_coef_45_NS[:,1]-avg_change_monthly_runoff_coef_45_NS[:,2], avg_change_monthly_runoff_coef_45_NS[:,3]-avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [avg_change_monthly_runoff_coef_45_PforF[:,1]-avg_change_monthly_runoff_coef_45_PforF[:,2], avg_change_monthly_runoff_coef_45_PforF[:,3]-avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)


                scatter!(avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[2], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[1], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[2], markershape=:circle,  markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid, linewidth=3)
                scatter!(avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[1], markershape=:circle, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid, linewidth=3)

                violin!([xaxis_85[month]],monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
                violin!([xaxis_45[month]],monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)

            end
            #ylabel!("abs. change monthly Q/P", yguidefontsize=20)
            # if Catchment_Name != "Pitztal" && Catchment_Name !="Defreggental" && Catchment_Name !="Gailtal"#IllSugadin"
            #     ylims!((-0.5,0.5))
            # else
            if i==1 || i==4
                ylabel!("absolute ∆Q/P [-]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-0.5,1))
                if i==1
                    yticks!([-0.25:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","",""])

                end
            else
                ylims!((-0.75,1))

                if i==4
                    yticks!([-0.5:0.25:0.75;])
                else
                    yticks!([-0.25:0.25:0.75;], ["","","","","",""])

                end
            end

            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            box=plot!(left_margin = [20mm 10mm 10mm], right_margin = [10mm 10mm 20mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            else
                xticks!([1:1:4;], ["", "", "", ""])

            end

            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            rel_avg_change_monthly_runoff_coef_45_PforF = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_45_NS = zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_PforF= zeros(4,3)
            rel_avg_change_monthly_runoff_coef_85_NS= zeros(4,3)

            for month in 1:4
                change_monthly_runoff_coef_45_PforF_ =   100*relative_error(monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_85_PforF_ = 100*relative_error(monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)] ,monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)])
                change_monthly_runoff_coef_45_NS_ = 100*relative_error(monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)] ,monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)])
                change_monthly_runoff_coef_85_NS_ = 100*relative_error(monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_85_NS)] ,monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_85_NS)])
                rel_avg_change_monthly_runoff_coef_45_PforF[month,:] .= mean(change_monthly_runoff_coef_45_PforF_[:,1]), minimum(change_monthly_runoff_coef_45_PforF_[:,1]), maximum(change_monthly_runoff_coef_45_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_45_NS[month,:] .= mean(change_monthly_runoff_coef_45_NS_[:,1]), minimum(change_monthly_runoff_coef_45_NS_[:,1]), maximum(change_monthly_runoff_coef_45_NS_[:,1])
                rel_avg_change_monthly_runoff_coef_85_PforF[month,:].= mean(change_monthly_runoff_coef_85_PforF_[:,1]), minimum(change_monthly_runoff_coef_85_PforF_[:,1]), maximum(change_monthly_runoff_coef_85_PforF_[:,1])
                rel_avg_change_monthly_runoff_coef_85_NS[month,:] .= mean(change_monthly_runoff_coef_85_NS_[:,1]), minimum(change_monthly_runoff_coef_85_NS_[:,1]), maximum(change_monthly_runoff_coef_85_NS_[:,1])
            end

            for month in 1:4
                if Catchment_Name=="Feistritz" && month==4
                    labels=["RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat","RCP8.5 Sr,clim,adapt"]
                else
                    labels=[false,false,false,false]
                end
                plot!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_NS[:,1]-rel_avg_change_monthly_runoff_coef_85_NS[:,2], rel_avg_change_monthly_runoff_coef_85_NS[:,3]-rel_avg_change_monthly_runoff_coef_85_NS[:,1]], color=Farben_85[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_85_PforF[:,1]-rel_avg_change_monthly_runoff_coef_85_PforF[:,2], rel_avg_change_monthly_runoff_coef_85_PforF[:,3]-rel_avg_change_monthly_runoff_coef_85_PforF[:,1]], color=Farben_85[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_NS[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_NS[:,1]-rel_avg_change_monthly_runoff_coef_45_NS[:,2], rel_avg_change_monthly_runoff_coef_45_NS[:,3]-rel_avg_change_monthly_runoff_coef_45_NS[:,1]], color=Farben_45[2], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)
                plot!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], ribbon = [rel_avg_change_monthly_runoff_coef_45_PforF[:,1]-rel_avg_change_monthly_runoff_coef_45_PforF[:,2], rel_avg_change_monthly_runoff_coef_45_PforF[:,3]-rel_avg_change_monthly_runoff_coef_45_PforF[:,1]], color=Farben_45[1], label=false, falpha=0.3, yticks=:none, linestle=:solid, linewidth=3)

                scatter!(rel_avg_change_monthly_runoff_coef_85_PforF[:,1], color=Farben_85[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[3], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_85_NS[:,1], color=Farben_85[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[4], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_PforF[:,1], color=Farben_45[1], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[1], yticks=:none, linestle=:solid)
                scatter!(rel_avg_change_monthly_runoff_coef_45_NS[:,1],  color=Farben_45[2], markershape=:circle, linewidth=3, markerstrokewidth=0, markersize=7, label=labels[2], yticks=:none, linestle=:solid)

                # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], falpha=0.3, label="Past", outlier=false)
                # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
            end

            if i==1 || i==4
                ylabel!("∆Q/P [%]", yguidefontsize=20)
            end
            if i in 1:3
                ylims!((-45,65))
                if i ==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["","","","","",""])

                end
            else
                ylims!((-65,155))
                if i ==4
                    yticks!([-60:30:150;])
                else
                    yticks!([-60:30:150;], ["","","","","","","",""])

                end

            end
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)

            plot!(left_margin = [20mm 10mm 10mm], right_margin = [1mm 10mm 20mm],bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
            if i in 4:6
                xticks!([1:1:4;], ["Spring", "Summer", "Autumn", "Winter"])
            end
            box = plot!()
            push!(all_violins_85, box)
        end
    end


    if seasonal_month == "month"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend =:topleft, legendfontsize=20,size=(2000,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_abs_change.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(200,1500), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_monthly_runoff_coefficient_past_future_rel_change.png")
    elseif seasonal_month == "seasonal"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (2,3), legend =:topleft, legendfontsize=20,size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_abs_change_grid.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend =:topleft, legendfontsize=20, size=(2500,1250), left_margin = [20mm 10mm 10mm],right_margin = [10mm 10mm 20mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/Total_seasonal_runoff_coefficient_past_future_rel_change_grid.png")
    end
end
#
# function plot_changes_annual_discharge_all_catchments(All_Catchment_Names, Area_Catchments, nr_runs)
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#     Plots.plot()
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#         # monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_8.5.txt", ',')
#         # months_85 = monthly_changes_85[:,1]
#         # Monthly_Discharge_past_85 = monthly_changes_85[:,2]
#         # Monthly_Discharge_future_85  = monthly_changes_85[:,3]
#         # monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_4.5.txt", ',')
#         # months_45 = monthly_changes_45[:,1]
#         # Monthly_Discharge_past_45 = monthly_changes_45[:,2]
#         # Monthly_Discharge_future_45  = monthly_changes_45[:,3]
#         # Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
#
#         # for annual discharge
#         relative_change_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
#         relative_change_45 = relative_change_45[:,1]
#         # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
#         #annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchments[i], nr_runs[i])
#         #relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs)
#         #boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]]
#         if Catchment_Name == "Pitten"
#             Catchment_Name = "Feistritz"
#         elseif Catchment_Name == "IllSugadin"
#             Catchment_Name = "Silbertal"
#         end
#         violin!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         # violin!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#
#         #boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
#         #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
#         #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
#         #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
#         ylims!((-35,35))
#         yticks!([-35:10:35;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         #ylabel!("Relative Change in Average Annual Discharge [%]")
#         ylabel!("[%]")
#         title!("Relative Change in Average Annual Discharge for RCP 4.5")
#     end
#     box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
#     Plots.plot()
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#         # monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_8.5.txt", ',')
#         # months_85 = monthly_changes_85[:,1]
#         # Monthly_Discharge_past_85 = monthly_changes_85[:,2]
#         # Monthly_Discharge_future_85  = monthly_changes_85[:,3]
#         # monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_4.5.txt", ',')
#         # months_45 = monthly_changes_45[:,1]
#         # Monthly_Discharge_past_45 = monthly_changes_45[:,2]
#         # Monthly_Discharge_future_45  = monthly_changes_45[:,3]
#         # Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
#
#         # for annual discharge
#         #relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchments[i], nr_runs[i])
#         # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchments[i], nr_runs[i])
#         relative_change_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
#         relative_change_85 = relative_change_85[:,1]
#
#         #boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]]
#         if Catchment_Name == "Pitten"
#             Catchment_Name = "Feistritz"
#             println("works")
#         elseif Catchment_Name == "IllSugadin"
#             Catchment_Name = "Silbertal"
#         end
#         violin!([Catchment_Name], relative_change_85*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         # boxplot!([Catchment_Name], relative_change_85*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
#         #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
#         #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
#         #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
#         ylims!((-35,35))
#         yticks!([-35:10:35;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         #ylabel!("Relative Change in Average Annual Discharge [%]")
#         ylabel!("[%]")
#         title!("Relative Change in Average Annual Discharge for RCP 4.5")
#     end
#     box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
#     Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
#
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Discharge/annual_discharges_all_catchments_45_85.png")
# end

function plot_magnitude_changes_AMF_all_catchments(All_Catchment_Names, Elevation, Area_Catchments)
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Plots.plot()
    rel_change_45= []
    rel_change_85 = []
    abs_change_45 = []
    abs_change_85 = []
    rel_change_45_pf= []
    rel_change_85_pf = []
    abs_change_45_pf = []
    abs_change_85_pf = []
    all_boxplots = []
    dataframe = zeros(6,6)
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        Plots.plot()
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_4.5.txt",',')
        annual_max_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_4.5.txt",',')

        average_max_Discharge_past_45 = convertDischarge(annual_max_flow_45[:,1], Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(annual_max_flow_45[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45 = annual_max_flow_45[:,3]
        Timing_max_Discharge_future_45 = annual_max_flow_45[:,4]
        All_Concentration_past_45 = annual_max_flow_45[:,5]
        All_Concentration_future_45 = annual_max_flow_45[:,6]
        average_max_Discharge_past_45_pf = convertDischarge(annual_max_flow_45_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_45_pf = convertDischarge(annual_max_flow_45_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45_pf = annual_max_flow_45_pf[:,3]
        Timing_max_Discharge_future_45_pf = annual_max_flow_45_pf[:,4]
        All_Concentration_past_45_pf = annual_max_flow_45_pf[:,5]
        All_Concentration_future_45_pf = annual_max_flow_45_pf[:,6]
        annual_max_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_8.5.txt",',')
        annual_max_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_8.5.txt",',')

        average_max_Discharge_past_85 = convertDischarge(annual_max_flow_85[:,1], Area_Catchments[i])
        average_max_Discharge_future_85 = convertDischarge(annual_max_flow_85[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85 = annual_max_flow_85[:,3]
        Timing_max_Discharge_future_85 = annual_max_flow_85[:,4]
        All_Concentration_past_85 = annual_max_flow_85[:,5]
        All_Concentration_future_85 = annual_max_flow_85[:,6]
        average_max_Discharge_past_85_pf = convertDischarge(annual_max_flow_85_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_85_pf = convertDischarge(annual_max_flow_85_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85_pf = annual_max_flow_85_pf[:,3]
        Timing_max_Discharge_future_85_pf = annual_max_flow_85_pf[:,4]
        All_Concentration_past_85_pf = annual_max_flow_85_pf[:,5]
        All_Concentration_future_85_pf = annual_max_flow_85_pf[:,6]

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            violin!([1], relative_error(average_max_Discharge_future_45_pf,average_max_Discharge_past_45_pf)*100,color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
            violin!([2], relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100,color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
            violin!([3], relative_error(average_max_Discharge_future_85_pf,average_max_Discharge_past_85_pf)*100,color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
            violin!([4], relative_error(average_max_Discharge_future_85 ,average_max_Discharge_past_85)*100,color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
        # else
        if i==6
            scatter!([1], average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf,color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([2], average_max_Discharge_future_45 - average_max_Discharge_past_45,color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
            scatter!([3], average_max_Discharge_future_85_pf - average_max_Discharge_past_85_pf,color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([4], average_max_Discharge_future_85 - average_max_Discharge_past_85,color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        end
        # boxplot!([Catchment_Name], average_max_Discharge_future_45 - average_max_Discharge_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # append!(abs_change_45, mean(average_max_Discharge_future_45 - average_max_Discharge_past_45))
        # append!(rel_change_45, mean(relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100))
        # append!(abs_change_45_pf, mean(average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf))
        # append!(rel_change_45_pf, mean(relative_error(average_max_Discharge_future_45_pf, average_max_Discharge_past_45_pf)*100))

        ylims!((-55,80))
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=10px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px)
        end
        # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
        if i==1 || i==4
            ylabel!("∆AMF,mean [%]")
            yticks!([-50:25:75;])

        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:bottomright)
        push!(all_boxplots,box_85)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(2,3), size=(2200,1200), framestyle = :box, left_margin=[20mm 0mm 0mm])
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/max_annual_discharges_all_catchments_45_85_absolute.png")
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude.csv", hcat(rel_change_45, rel_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude.csv", hcat(abs_change_45, abs_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude_pf.csv", hcat(rel_change_45_pf, rel_change_85_pf))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude_pf.csv", hcat(abs_change_45_pf, abs_change_85_pf))

end

function plot_magnitude_changes_AMF_all_catchments_layout2(All_Catchment_Names, Elevation, Area_Catchments)
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Plots.plot()
    rel_change_45= []
    rel_change_85 = []
    abs_change_45 = []
    abs_change_85 = []
    rel_change_45_pf= []
    rel_change_85_pf = []
    abs_change_45_pf = []
    abs_change_85_pf = []
    all_boxplots = []
    all_boxplots_pf = []

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        Plots.plot()
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_4.5.txt",',')
        annual_max_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_4.5.txt",',')

        average_max_Discharge_past_45 = convertDischarge(annual_max_flow_45[:,1], Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(annual_max_flow_45[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45 = annual_max_flow_45[:,3]
        Timing_max_Discharge_future_45 = annual_max_flow_45[:,4]
        All_Concentration_past_45 = annual_max_flow_45[:,5]
        All_Concentration_future_45 = annual_max_flow_45[:,6]
        average_max_Discharge_past_45_pf = convertDischarge(annual_max_flow_45_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_45_pf = convertDischarge(annual_max_flow_45_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45_pf = annual_max_flow_45_pf[:,3]
        Timing_max_Discharge_future_45_pf = annual_max_flow_45_pf[:,4]
        All_Concentration_past_45_pf = annual_max_flow_45_pf[:,5]
        All_Concentration_future_45_pf = annual_max_flow_45_pf[:,6]
        annual_max_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_8.5.txt",',')
        annual_max_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_8.5.txt",',')

        average_max_Discharge_past_85 = convertDischarge(annual_max_flow_85[:,1], Area_Catchments[i])
        average_max_Discharge_future_85 = convertDischarge(annual_max_flow_85[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85 = annual_max_flow_85[:,3]
        Timing_max_Discharge_future_85 = annual_max_flow_85[:,4]
        All_Concentration_past_85 = annual_max_flow_85[:,5]
        All_Concentration_future_85 = annual_max_flow_85[:,6]
        average_max_Discharge_past_85_pf = convertDischarge(annual_max_flow_85_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_85_pf = convertDischarge(annual_max_flow_85_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85_pf = annual_max_flow_85_pf[:,3]
        Timing_max_Discharge_future_85_pf = annual_max_flow_85_pf[:,4]
        All_Concentration_past_85_pf = annual_max_flow_85_pf[:,5]
        All_Concentration_future_85_pf = annual_max_flow_85_pf[:,6]

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            violin!([1], relative_error(average_max_Discharge_future_45_pf,average_max_Discharge_past_45_pf)*100,color=[Farben_45[1]],  label=false)
            violin!([3.5], relative_error(average_max_Discharge_future_85_pf,average_max_Discharge_past_85_pf)*100,color=[Farben_85[1]], label=false)
            scatter!(ones(14), relative_error(average_max_Discharge_future_45_pf,average_max_Discharge_past_45_pf)*100,color="black",  label=false)
            scatter!(ones(14)*3.5, relative_error(average_max_Discharge_future_85_pf,average_max_Discharge_past_85_pf)*100,color="black", label=false)
            scatter!([1], [mean(relative_error(average_max_Discharge_future_45_pf,average_max_Discharge_past_45_pf)*100)],color="white",  markerstrokecolour="black", markersize=7, markerstrokewidth=1, label=false)
            scatter!([3.5], [mean(relative_error(average_max_Discharge_future_85_pf,average_max_Discharge_past_85_pf)*100)],color="white", markerstrokecolour="black", markersize=7, markerstrokewidth=1, label=false)
            violin!([2], relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100,color=[Farben_45[2]],  label=false)
            violin!([4.5], relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100,color=[Farben_85[2]], label=false)
            scatter!(ones(14)*2, relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100,color="black",  label=false)
            scatter!(ones(14)*4.5, relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100,color="black", label=false)
            scatter!([2], [mean(relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100)],color="white", markerstrokecolour="black", markersize=7, label=false)
            scatter!([4.5], [mean(relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100)],color="white", markerstrokecolour="black", markersize=7,label=false)


        # else
        if i==1
            scatter!([1], average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf,color=[Farben_45[1]], label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([2], average_max_Discharge_future_45 - average_max_Discharge_past_45,color=[Farben_45[2]], label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
            scatter!([3.5], average_max_Discharge_future_85_pf - average_max_Discharge_past_85_pf,color=[Farben_85[1]], label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([4.5], average_max_Discharge_future_85 - average_max_Discharge_past_85,color=[Farben_85[2]], label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)

        end
        # boxplot!([Catchment_Name], average_max_Discharge_future_45 - average_max_Discharge_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # append!(abs_change_45, mean(average_max_Discharge_future_45 - average_max_Discharge_past_45))
        # append!(rel_change_45, mean(relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100))
        # append!(abs_change_45_pf, mean(average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf))
        # append!(rel_change_45_pf, mean(relative_error(average_max_Discharge_future_45_pf, average_max_Discharge_past_45_pf)*100))

        ylims!((-55,80))
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=10px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px)
        end
        xticks!([[1,2,3.5,4.5];], ["", "", "", ""])
        if i==1||i==4
            ylabel!("∆ Magnitude Mean AMF [%]")
            yticks!([-50:25:75;])
        else
            yticks!([-50:25:75;], ["","","","","",""])
        end
        # hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_pf = boxplot!(left_margin = [0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:best, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
        push!(all_boxplots_pf,box_pf)

        # Plots.plot()
        # violin!([1], relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100,color=[Farben_45[2]],  label=false)
        # violin!([2], relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100,color=[Farben_85[2]], label=false)
        # scatter!(ones(14), relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100,color="black",  label=false)
        # scatter!(ones(14)*2, relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100,color="black", label=false)
        # scatter!([1], [mean(relative_error(average_max_Discharge_future_45,average_max_Discharge_past_45)*100)],color="white", markerstrokecolour="black", markersize=7, label=false)
        # scatter!([2], [mean(relative_error(average_max_Discharge_future_85,average_max_Discharge_past_85)*100)],color="white", markerstrokecolour="black", markersize=7,label=false)


    # else
        # if i==1
        #     scatter!([1], average_max_Discharge_future_45 - average_max_Discharge_past_45,color=[Farben_45[2]], label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
        #     scatter!([2], average_max_Discharge_future_85 - average_max_Discharge_past_85,color=[Farben_85[2]], label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        # end

        # ylims!((-55,80))
        # xticks!([1:1:2;], ["", ""])
        # if i==1
        #     ylabel!("∆AMF,mean [%]")
        #     yticks!([-50:25:75;])
        # else
        #     yticks!([-50:25:75;], ["","","","","",""])
        # end
        # # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        # box = boxplot!(left_margin = [0mm 0mm 0mm], yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=16, legend=:topright, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
        # push!(all_boxplots,box)



    end
    Plots.plot(all_boxplots_pf[1], all_boxplots_pf[2],all_boxplots_pf[3],all_boxplots_pf[4],all_boxplots_pf[5],all_boxplots_pf[6], layout=(2,3), size=(2500,1200), framestyle = :box, left_margin = [20mm 0mm 0mm])
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/magnitude_max_annual_discharges_all_catchments_combined.png")
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude.csv", hcat(rel_change_45, rel_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude.csv", hcat(abs_change_45, abs_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude_pf.csv", hcat(rel_change_45_pf, rel_change_85_pf))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude_pf.csv", hcat(abs_change_45_pf, abs_change_85_pf))

end

function plot_magnitude_changes_AMF_all_catchments_abs_layout2(All_Catchment_Names, Elevation, Area_Catchments)
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Plots.plot()
    rel_change_45= []
    rel_change_85 = []
    abs_change_45 = []
    abs_change_85 = []
    rel_change_45_pf= []
    rel_change_85_pf = []
    abs_change_45_pf = []
    abs_change_85_pf = []
    all_boxplots = []
    all_boxplots_pf = []

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        Plots.plot()
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_4.5.txt",',')
        annual_max_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_4.5.txt",',')

        average_max_Discharge_past_45 = convertDischarge(annual_max_flow_45[:,1], Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(annual_max_flow_45[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45 = annual_max_flow_45[:,3]
        Timing_max_Discharge_future_45 = annual_max_flow_45[:,4]
        All_Concentration_past_45 = annual_max_flow_45[:,5]
        All_Concentration_future_45 = annual_max_flow_45[:,6]
        average_max_Discharge_past_45_pf = convertDischarge(annual_max_flow_45_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_45_pf = convertDischarge(annual_max_flow_45_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45_pf = annual_max_flow_45_pf[:,3]
        Timing_max_Discharge_future_45_pf = annual_max_flow_45_pf[:,4]
        All_Concentration_past_45_pf = annual_max_flow_45_pf[:,5]
        All_Concentration_future_45_pf = annual_max_flow_45_pf[:,6]
        annual_max_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_8.5.txt",',')
        annual_max_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_8.5.txt",',')

        average_max_Discharge_past_85 = convertDischarge(annual_max_flow_85[:,1], Area_Catchments[i])
        average_max_Discharge_future_85 = convertDischarge(annual_max_flow_85[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85 = annual_max_flow_85[:,3]
        Timing_max_Discharge_future_85 = annual_max_flow_85[:,4]
        All_Concentration_past_85 = annual_max_flow_85[:,5]
        All_Concentration_future_85 = annual_max_flow_85[:,6]
        average_max_Discharge_past_85_pf = convertDischarge(annual_max_flow_85_pf[:,1], Area_Catchments[i])
        average_max_Discharge_future_85_pf = convertDischarge(annual_max_flow_85_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85_pf = annual_max_flow_85_pf[:,3]
        Timing_max_Discharge_future_85_pf = annual_max_flow_85_pf[:,4]
        All_Concentration_past_85_pf = annual_max_flow_85_pf[:,5]
        All_Concentration_future_85_pf = annual_max_flow_85_pf[:,6]

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            violin!([1], average_max_Discharge_future_45_pf-average_max_Discharge_past_45_pf,color=[Farben_45[1]],  label=false)
            violin!([3.5], average_max_Discharge_future_85_pf-average_max_Discharge_past_85_pf,color=[Farben_85[1]], label=false)
            scatter!(ones(14), average_max_Discharge_future_45_pf-average_max_Discharge_past_45_pf,color="black",  label=false)
            scatter!(ones(14)*3.5, average_max_Discharge_future_85_pf-average_max_Discharge_past_85_pf,color="black", label=false)
            scatter!([1], [mean(average_max_Discharge_future_45_pf-average_max_Discharge_past_45_pf)],color="white",  markerstrokecolour="black", markersize=7, markerstrokewidth=1, label=false)
            scatter!([3.5], [mean(average_max_Discharge_future_85_pf-average_max_Discharge_past_85_pf)],color="white", markerstrokecolour="black", markersize=7, markerstrokewidth=1, label=false)
            violin!([2], average_max_Discharge_future_45-average_max_Discharge_past_45,color=[Farben_45[2]],  label=false)
            violin!([4.5], average_max_Discharge_future_85-average_max_Discharge_past_85,color=[Farben_85[2]], label=false)
            scatter!(ones(14)*2, average_max_Discharge_future_45-average_max_Discharge_past_45,color="black",  label=false)
            scatter!(ones(14)*4.5, average_max_Discharge_future_85-average_max_Discharge_past_85,color="black", label=false)
            scatter!([2], [mean(average_max_Discharge_future_45-average_max_Discharge_past_45)],color="white", markerstrokecolour="black", markersize=7, label=false)
            scatter!([4.5], [mean(average_max_Discharge_future_85-average_max_Discharge_past_85)],color="white", markerstrokecolour="black", markersize=7,label=false)


        # else
        if i==1
            scatter!([1], average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf,color=[Farben_45[1]], label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([2], average_max_Discharge_future_45 - average_max_Discharge_past_45,color=[Farben_45[2]], label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
            scatter!([3.5], average_max_Discharge_future_85_pf - average_max_Discharge_past_85_pf,color=[Farben_85[1]], label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([4.5], average_max_Discharge_future_85 - average_max_Discharge_past_85,color=[Farben_85[2]], label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)

        end
        # boxplot!([Catchment_Name], average_max_Discharge_future_45 - average_max_Discharge_past_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # append!(abs_change_45, mean(average_max_Discharge_future_45 - average_max_Discharge_past_45))
        # append!(rel_change_45, mean(relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100))
        # append!(abs_change_45_pf, mean(average_max_Discharge_future_45_pf - average_max_Discharge_past_45_pf))
        # append!(rel_change_45_pf, mean(relative_error(average_max_Discharge_future_45_pf, average_max_Discharge_past_45_pf)*100))

        ylims!((-8,8))
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=10px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px)
        end
        xticks!([[1,2,3.5,4.5];], ["", "", "", ""])
        if i==1||i==4
            ylabel!("∆ Magnitude Mean AMF [mm]")
             yticks!([-7.5:2.5:7.5;])
        else
             yticks!([-7.5:2.5:7.5;], ["","","","","",""])
        end
        # hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_pf = boxplot!(left_margin = [0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:best, grid=false)#minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
        push!(all_boxplots_pf,box_pf)




    end
    Plots.plot(all_boxplots_pf[1], all_boxplots_pf[2],all_boxplots_pf[3],all_boxplots_pf[4],all_boxplots_pf[5],all_boxplots_pf[6], layout=(2,3), size=(2500,1200), framestyle = :box, left_margin = [20mm 0mm 0mm])
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/magnitude_max_annual_discharges_all_catchments_combined_absolute.png")
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude.csv", hcat(rel_change_45, rel_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude.csv", hcat(abs_change_45, abs_change_85))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude_pf.csv", hcat(rel_change_45_pf, rel_change_85_pf))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude_pf.csv", hcat(abs_change_45_pf, abs_change_85_pf))

end
# plot_magnitude_changes_AMF_all_catchments_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments)

# plot_magnitude_changes_AMF_all_catchments_abs_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments)
# plot_magnitude_changes_AMF_all_catchments(Catchment_Names_new, Catchment_Height, Area_Catchments)
function calculate_magnitude_changes_AMF_all_catchments(All_Catchment_Names, Elevation, Area_Catchments)
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Plots.plot()
    rel_change_45= []
    rel_change_85 = []
    abs_change_45 = []
    abs_change_85 = []
    rel_change_45_pf= []
    rel_change_85_pf = []
    abs_change_45_pf = []
    abs_change_85_pf = []
    all_boxplots = []
    dataframe = zeros(6,6)
    dataframe_pf = zeros(6,6)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        Plots.plot()
        if Catchment_Name=="Gailtal"
            annual_max_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_40.5.txt",',')
        else
            annual_max_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_4.5.txt",',')
        end
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_4.5.txt",',')

        # average_max_Discharge_past_45 = convertDischarge(annual_max_flow_45[:,1], Area_Catchments[i])
        # average_max_Discharge_future_45 = convertDischarge(annual_max_flow_45[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45 = annual_max_flow_45[:,3]
        Timing_max_Discharge_future_45 = annual_max_flow_45[:,4]
        All_Concentration_past_45 = annual_max_flow_45[:,5]
        All_Concentration_future_45 = annual_max_flow_45[:,6]
        # average_max_Discharge_past_45_pf = convertDischarge(annual_max_flow_45_pf[:,1], Area_Catchments[i])
        # average_max_Discharge_future_45_pf = convertDischarge(annual_max_flow_45_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_45_pf = annual_max_flow_45_pf[:,3]
        Timing_max_Discharge_future_45_pf = annual_max_flow_45_pf[:,4]
        All_Concentration_past_45_pf = annual_max_flow_45_pf[:,5]
        All_Concentration_future_45_pf = annual_max_flow_45_pf[:,6]
        if Catchment_Name=="Gailtal"
            annual_max_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_80.5.txt",',')
        else
            annual_max_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_8.5.txt",',')
        end
        annual_max_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_8.5.txt",',')

        # average_max_Discharge_past_85 = convertDischarge(annual_max_flow_85[:,1], Area_Catchments[i])
        # average_max_Discharge_future_85 = convertDischarge(annual_max_flow_85[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85 = annual_max_flow_85[:,3]
        Timing_max_Discharge_future_85 = annual_max_flow_85[:,4]
        All_Concentration_past_85 = annual_max_flow_85[:,5]
        All_Concentration_future_85 = annual_max_flow_85[:,6]
        # average_max_Discharge_past_85_pf = convertDischarge(annual_max_flow_85_pf[:,1], Area_Catchments[i])
        # average_max_Discharge_future_85_pf = convertDischarge(annual_max_flow_85_pf[:,2], Area_Catchments[i])
        Timing_max_Discharge_past_85_pf = annual_max_flow_85_pf[:,3]
        Timing_max_Discharge_future_85_pf = annual_max_flow_85_pf[:,4]
        All_Concentration_past_85_pf = annual_max_flow_85_pf[:,5]
        All_Concentration_future_85_pf = annual_max_flow_85_pf[:,6]
        dataframe[i,1] = (mean(Timing_max_Discharge_past_85)+mean(Timing_max_Discharge_past_45))/2
        dataframe[i,2] = (std(Timing_max_Discharge_past_85)+std(Timing_max_Discharge_past_45))/2
        dataframe[i,3] = mean(Timing_max_Discharge_future_45)
        dataframe[i,4] = std(Timing_max_Discharge_future_45)
        dataframe[i,5] = mean(Timing_max_Discharge_future_85)
        dataframe[i,6] =  std(Timing_max_Discharge_future_85)
        dataframe_pf[i,1] = (mean(Timing_max_Discharge_past_85_pf)+mean(Timing_max_Discharge_past_45_pf))/2
        dataframe_pf[i,2] = (std(Timing_max_Discharge_past_85_pf)+std(Timing_max_Discharge_past_45_pf))/2
        dataframe_pf[i,3] = mean(Timing_max_Discharge_future_45_pf)
        dataframe_pf[i,4] = std(Timing_max_Discharge_future_45_pf)
        dataframe_pf[i,5] = mean(Timing_max_Discharge_future_85_pf)
        dataframe_pf[i,6] =  std(Timing_max_Discharge_future_85_pf)



    end
    # Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(2,3), size=(2200,1200), framestyle = :box, left_margin=[20mm 0mm 0mm])
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/max_annual_discharges_all_catchments_45_85_absolute.png")
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_timing_change_AMF_magnitude_ns2.csv", dataframe)
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_timing_change_AMF_magnitude_pf2.csv", dataframe_pf)
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_rel_change_AMF_magnitude_pf.csv", hcat(rel_change_45_pf, rel_change_85_pf))
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/mean_abs_change_AMF_magnitude_pf.csv", hcat(abs_change_45_pf, abs_change_85_pf))

end
# plot_magnitude_changes_AMF_all_catchments_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments)

# calculate_magnitude_changes_AMF_all_catchments(Catchment_Names_new, Catchment_Height, Area_Catchments)

function plot_changes_magnitude_AMF_return_periods_sarah(All_Catchment_Names, Elevation, Area_Catchments, type, change)
    all_boxplots = []
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')[1:12*14*2950,:]
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')[1:12*14*2950,:]
        Farben45 = palette(:reds)
        Farben85 = palette(:blues)
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        Max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        Max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        plot()
        mean_change = Float64[]
        max_change = Float64[]
        min_change = Float64[]
        mean_change_85 = Float64[]
        max_change_85 = Float64[]
        min_change_85 = Float64[]
        std_change_45 = Float64[]
        std_change_85 = Float64[]
        mean_change_pf = Float64[]
        max_change_pf = Float64[]
        min_change_pf = Float64[]
        mean_change_85_pf = Float64[]
        max_change_85_pf = Float64[]
        min_change_85_pf = Float64[]
        std_change_45_pf = Float64[]
        std_change_85_pf = Float64[]

        for exceedance in Exceedance_Probability_45[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45)
            index_ = findall(x->x == exceedance, Exceedance_Probability_85)

            if change == "relative"
                change_45 = relative_error(Max_Discharge_Future_45[index], max_Discharge_Past_45[index])*100
                change_85 = relative_error(Max_Discharge_Future_85[index_], max_Discharge_Past_85[index_])*100
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
            elseif change === "absolute"
                change_45 = convertDischarge(Max_Discharge_Future_45[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45[index], Area_Catchments[j])
                change_85 = convertDischarge(Max_Discharge_Future_85[index_], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85[index_], Area_Catchments[j])
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
            end
        end

        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')[1:12*14*2950,:]
        max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')[1:12*14*2950,:]
        max_Discharge_Past_45_pf = max_discharge_prob_45_pf[:,1]
        Max_Discharge_Future_45_pf = max_discharge_prob_45_pf[:,2]
        Exceedance_Probability_45_pf = max_discharge_prob_45_pf[:,3]
        max_Discharge_Past_85_pf = max_discharge_prob_85_pf[:,1]
        Max_Discharge_Future_85_pf = max_discharge_prob_85_pf[:,2]
        Exceedance_Probability_85_pf = max_discharge_prob_85_pf[:,3]

        plot()
        for exceedance in Exceedance_Probability_45_pf[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45_pf)
            index_ = findall(x->x == exceedance, Exceedance_Probability_85_pf)

            if change == "relative"
                change_45_pf = relative_error(Max_Discharge_Future_45_pf[index], max_Discharge_Past_45_pf[index])*100
                change_85_pf = relative_error(Max_Discharge_Future_85_pf[index_], max_Discharge_Past_85_pf[index_])*100
                append!(mean_change_pf, mean(change_45_pf))
                append!(max_change_pf, maximum(change_45_pf))
                append!(min_change_pf, minimum(change_45_pf))
                append!(mean_change_85_pf, mean(change_85_pf))
                append!(max_change_85_pf, maximum(change_85_pf))
                append!(min_change_85_pf, minimum(change_85_pf))
                append!(std_change_45_pf, std(change_45_pf))
                append!(std_change_85_pf, std(change_85_pf))
            elseif change === "absolute"
                change_45_pf = convertDischarge(Max_Discharge_Future_45_pf[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45_pf[index], Area_Catchments[j])
                change_85_pf = convertDischarge(Max_Discharge_Future_85_pf[index_], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85_pf[index_], Area_Catchments[j])
                append!(mean_change_pf, mean(change_45_pf))
                append!(max_change_pf, maximum(change_45_pf))
                append!(min_change_pf, minimum(change_45_pf))
                append!(mean_change_85_pf, mean(change_85_pf))
                append!(max_change_85_pf, maximum(change_85_pf))
                append!(min_change_85_pf, minimum(change_85_pf))
                append!(std_change_45_pf, std(change_45_pf))
                append!(std_change_85_pf, std(change_85_pf))
            end
        end
        println(size(std_change_45), size(std_change_45_pf),size(std_change_85),size(std_change_85_pf))
        return_period = (31 ./ collect(1:30))

        percentage = (collect(1/31:1/31:30/31)*100)
        if type == "percentage"
            plot(percentage, (mean_change), color=Farben45[2], label="RCP 4.5 Sr,clim,adapt", ribbon = std_change_45, linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_85), color=Farben85[2], label="RCP 8.5 Sr,clim,adapt", ribbon = std_change_85, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_pf), color=Farben_45[1], label="RCP 4.5 Sr,clim,stat", ribbon = std_change_45_pf, linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5 Sr,clim,stat", ribbon = std_change_85_pf, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)

            # plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", linewidth=3)
            # plot!(percentage, mean_change - std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # plot!(percentage, mean_change + std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", size=(1500,800), xflip=true, linewidth=3)
            # plot!(percentage, mean_change_85 - std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            # plot!(percentage, mean_change_85 + std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            ylabel!("[%]", yguidefontsize=12)
            xlabel!("Exceedance Probability [%]", xguidefontsize=12)
            if Catchment_Name == "Pitztal"
                ylims!((-30,130))
                yticks!([-20:20:130;])
            else
                ylims!((-30,90))
                yticks!([-20:10:90;])
            end
        elseif type == "return period"
            plot!(return_period, (mean_change_85), color=Farben_85[2], label=false, linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
            plot!(return_period, (mean_change_85_pf), color=Farben_85[1], label=false, linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85_pf)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
            plot!(return_period, (mean_change), color=Farben_45[2], label=false, linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45)#ribbon = (mean_change-min_change, max_change - mean_change))#
            plot!(return_period, (mean_change_pf), color=Farben_45[1], label=false, linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45_pf)#ribbon = (mean_change-min_change, max_change - mean_change))#

            scatter!(return_period, (mean_change), color=Farben_45[2], label=false, markersize=7, markerstrokewidth= 0)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85), color=Farben_85[2], label=false,size=(1500,800), markersize=7, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
            scatter!(return_period, (mean_change_pf), color=Farben_45[1], label=false, markersize=6, markerstrokewidth= 0)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label=false,size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)

            if change == "relative"
                if j==5
                    scatter!(return_period, (mean_change_pf), color=Farben_45[1], label="RCP 4.5 Sr,clim,stat", markersize=6, markerstrokewidth= 0)#, ribbon = std_change_45)
                    scatter!(return_period, (mean_change), color=Farben_45[2], label="RCP 4.5 Sr,clim,adapt", markersize=7, markerstrokewidth= 0)#, ribbon = std_change_45)
                    scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5 Sr,clim,stat",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
                    scatter!(return_period, (mean_change_85), color=Farben_85[2], label="RCP 8.5 Sr,clim,adapt",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
                end
                if j==3
                    ylabel!("∆ Magnitude of Mean AMF [%]", yguidefontsize=12)
                end
                    ylims!((-30,90))
                    yticks!([-20:20:80;])
            elseif change == "absolute"
                if j==1
                    scatter!(return_period, (mean_change_pf), color=Farben_45[1], label="RCP 4.5 Sr,clim,stat", markersize=6, markerstrokewidth= 0)#, ribbon = std_change_45)
                    scatter!(return_period, (mean_change), color=Farben_45[2], label="RCP 4.5 Sr,clim,adapt", markersize=7, markerstrokewidth= 0)#, ribbon = std_change_45)
                    scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5 Sr,clim,stat",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
                    scatter!(return_period, (mean_change_85), color=Farben_85[2], label="RCP 8.5 Sr,clim,adapt",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
                end
                if j==3
                    ylabel!("∆ Magnitude of Mean AMF [mm/d]", yguidefontsize=12)
                end
                if Catchment_Name == "Gailtal"
                    ylims!((-10,20))
                    yticks!([-10:5:20;])
                else
                    ylims!((-1.5,6))
                    yticks!([-1:1:6;])
                end
            end
            xlims!((1,30))
            if j==5||j==6
                xlabel!("Return period [yrs]", xguidefontsize=12)
                xticks!([1,2,5,10,20,30], ["1", "2", "5", "10", "20", "30"])
            else
                xticks!([1,2,5,10,20,30], ["", "", "", "", "", ""])

            end

        end

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = Farben_45[2]")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = plot!(left_margin = [20mm 0mm], bottom_margin = 20px, xtickfont = font(12), ytickfont = font(12), framestyle = :box,  legend=:topright)
        push!(all_boxplots, box)
    end
    plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=:topleft, legendfontsize= 20, size=(2200,1200), left_margin = [20mm 0mm], bottom_margin = 40px, yguidefontsize=20, xguidefontsize=20, xtickfont = font(20), ytickfont = font(20),
        grid=false, dpi=300)
    if change=="relative"
        savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_magnitude_all_Catchments_all_years_return_period_ribbon_std_total_rel.png")
    else
        savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_magnitude_all_Catchments_all_years_return_period_ribbon_std_total_abs.png")
    end

end

# function plot_changes_magnitude_AMF_return_periods_try(All_Catchment_Names, Elevation, Area_Catchments, type, change)
#     all_boxplots = []
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#
#     Plots.plot()
#     for (j,Catchment_Name) in enumerate(All_Catchment_Names)
#         println(Catchment_Name)
#         max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
#         Farben_45= palette(:reds)
#         max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
#         Farben_85= palette(:blues)
#         max_Discharge_Past_45 = max_discharge_prob_45[:,1]
#         Max_Discharge_Future_45 = max_discharge_prob_45[:,2]
#         Exceedance_Probability_45 = max_discharge_prob_45[:,3]
#         max_Discharge_Past_85 = max_discharge_prob_85[:,1]
#         Max_Discharge_Future_85 = max_discharge_prob_85[:,2]
#         Exceedance_Probability_85 = max_discharge_prob_85[:,3]
#         # max_discharge_prob_45_s = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
#         # max_discharge_prob_85_s = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
#         # Exceedance_Probability_45_S = max_discharge_prob_45[:,3]
#
#         max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
#         max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
#
#         max_Discharge_Past_45_pf = max_discharge_prob_45_pf[:,1]
#         Max_Discharge_Future_45_pf = max_discharge_prob_45_pf[:,2]
#         Exceedance_Probability_45_pf = max_discharge_prob_45_pf[:,3]
#         max_Discharge_Past_85_pf = max_discharge_prob_85_pf[:,1]
#         Max_Discharge_Future_85_pf = max_discharge_prob_85_pf[:,2]
#         Exceedance_Probability_85_pf = max_discharge_prob_85_pf[:,3]
#
#         Plots.plot()
#         mean_change = Float64[]
#         max_change = Float64[]
#         min_change = Float64[]
#         mean_change_85 = Float64[]
#         max_change_85 = Float64[]
#         min_change_85 = Float64[]
#         std_change_45 = Float64[]
#         std_change_85 = Float64[]
#
#         mean_change_pf = Float64[]
#         max_change_pf = Float64[]
#         min_change_pf = Float64[]
#         mean_change_85_pf = Float64[]
#         max_change_85_pf = Float64[]
#         min_change_85_pf = Float64[]
#         std_change_45_pf = Float64[]
#         std_change_85_pf = Float64[]
#         # println(ep)
#         # index=Int64[]
#         # index_85=Int64[]
#         # index_pf=Int64[]
#         # index_85_pf=Int64[]
#         ep=[]
#         if length(Exceedance_Probability_45[1:30]) <= length(Exceedance_Probability_85[1:30])
#             ep = Exceedance_Probability_45[1:30]
#         else
#             ep = Exceedance_Probability_85[1:30]
#         end
#         for exceedance in ep
#             index = findall(x->x == exceedance, ep)
#             if change == "relative"
#                 change_45 = relative_error(Max_Discharge_Future_45[index], max_Discharge_Past_45[index])*100
#                 change_85 = relative_error(Max_Discharge_Future_85[index], max_Discharge_Past_85[index])*100
#                 append!(mean_change, mean(change_45))
#                 append!(max_change, maximum(change_45))
#                 append!(min_change, minimum(change_45))
#
#                 append!(mean_change_85, mean(change_85))
#                 append!(max_change_85, maximum(change_85))
#                 append!(min_change_85, minimum(change_85))
#
#                 append!(std_change_45, std(change_45))
#                 append!(std_change_85, std(change_85))
#
#             elseif change === "absolute"
#                 change_45 = convertDischarge(Max_Discharge_Future_45[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45[index], Area_Catchments[j])
#                 change_85 = convertDischarge(Max_Discharge_Future_85[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85[index], Area_Catchments[j])
#                 println(change_45)
#                 println(change_85)
#                 append!(mean_change, mean(change_45))
#                 append!(max_change, maximum(change_45))
#                 append!(min_change, minimum(change_45))
#                 append!(mean_change_85, mean(change_85))
#                 append!(max_change_85, maximum(change_85))
#                 append!(min_change_85, minimum(change_85))
#                 append!(std_change_45, std(change_45))
#                 append!(std_change_85, std(change_85))
#
#
#             end
#         end
#         ep = min(Exceedance_Probability_45_pf[1:30], Exceedance_Probability_85_pf[1:30])
#         for exceedance in ep
#             index = findall(x->x == exceedance, ep)
#
#             if change == "relative"
#                 change_45_pf = relative_error(Max_Discharge_Future_45_pf[index], max_Discharge_Past_45_pf[index])*100
#                 change_85_pf = relative_error(Max_Discharge_Future_85_pf[index], max_Discharge_Past_85_pf[index])*100
#                 append!(mean_change_pf, mean(change_45_pf))
#                 append!(max_change_pf, maximum(change_45_pf))
#                 append!(min_change_pf, minimum(change_45_pf))
#
#                 append!(mean_change_85_pf, mean(change_85_pf))
#                 append!(max_change_85_pf, maximum(change_85_pf))
#                 append!(min_change_85_pf, minimum(change_85_pf))
#
#                 append!(std_change_45_pf, std(change_45_pf))
#                 append!(std_change_85_pf, std(change_85_pf))
#
#             elseif change === "absolute"
#                 change_45_pf = convertDischarge(Max_Discharge_Future_45_pf[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45_pf[index], Area_Catchments[j])
#                 change_85_pf = convertDischarge(Max_Discharge_Future_85_pf[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85_pf[index], Area_Catchments[j])
#                 append!(mean_change_pf, mean(change_45_pf))
#                 append!(max_change_pf, maximum(change_45_pf))
#                 append!(min_change_pf, minimum(change_45_pf))
#                 append!(mean_change_85_pf, mean(change_85_pf))
#                 append!(max_change_85_pf, maximum(change_85_pf))
#                 append!(min_change_85_pf, minimum(change_85_pf))
#                 append!(std_change_45_pf, std(change_45_pf))
#                 append!(std_change_85_pf, std(change_85_pf))
#
#             end
#         end
#
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_returnplot_input_NS2.txt", hcat(mean_change, mean_change_85,std_change_45,std_change_85, min_change,min_change_85, max_change, max_change_85),',')
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_returnplot_input_PforF2.txt", hcat(mean_change_pf, mean_change_85_pf,std_change_45_pf,std_change_85_pf,min_change_pf,min_change_85_pf, max_change_pf, max_change_85_pf),',')
#
#         Plots.plot()
#         # println(max_change)
#         # println(min_change)
#         return_period = (31 ./ collect(1:30))
#
#         percentage = (collect(1/31:1/31:30/31)*100)
#         if type == "percentage"
#             Plots.plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", ribbon = std_change_45, linewidth=3, fillalpha=.3)
#             Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", ribbon = std_change_85, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)
#             # Plots.plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", linewidth=3)
#             # Plots.plot!(percentage, mean_change - std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
#             # Plots.plot!(percentage, mean_change + std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
#             # Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", size=(1500,800), xflip=true, linewidth=3)
#             # Plots.plot!(percentage, mean_change_85 - std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
#             # Plots.plot!(percentage, mean_change_85 + std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
#             ylabel!("[%]", yguidefontsize=12)
#             xlabel!("Exceedance Probability [%]", xguidefontsize=12)
#             if Catchment_Name == "Pitztal"
#                 ylims!((-30,130))
#                 yticks!([-20:20:130;])
#             else
#                 ylims!((-30,90))
#                 yticks!([-20:10:90;])
#             end
#         elseif type == "return period"
#             Plots.plot!(return_period, (mean_change_85), color=[Farben_85[2]], label="RCP 8.5", linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85, xticks=:none)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
#             Plots.plot!(return_period, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5", linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85_pf, xticks=:none)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
#             Plots.plot(return_period, (mean_change), color=[Farben_45[2]], label="RCP 4.5", linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45, xticks=:none) #ribbon = (mean_change-min_change, max_change - mean_change))#
#             Plots.plot(return_period, (mean_change_pf), color=Farben_45[1], label="RCP 4.5", linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45_pf, xticks=:none) #ribbon = (mean_change-min_change, max_change - mean_change))#
#
#             scatter!(return_period, (mean_change_85), color=[Farben_85[2]], label="RCP 8.5",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10,xticks=:none)#, ribbon = std_change_85)
#             scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10,xticks=:none)#, ribbon = std_change_85)
#             scatter!(return_period, (mean_change), color=[Farben_45[2]], label="RCP 4.5", markersize=6, markerstrokewidth= 0, xticks=:none)#, ribbon = std_change_45)
#             scatter!(return_period, (mean_change_pf), color=Farben_45[1], label="RCP 4.5", markersize=6, markerstrokewidth= 0, xticks=:none)#, ribbon = std_change_45)
#
#             if change == "relative"
#                 ylabel!("[%]", yguidefontsize=12)
#                 ylims!((-30,90))
#                 yticks!([-20:20:80;])
#             elseif change == "absolute"
#                 if j ==3
#                     ylabel!("Absolute change in magnitude of AMF [mm/d]", yguidefontsize=12)
#                 end
#                 if Catchment_Name == "Gailtal"
#                     ylims!((-10,20))
#                     yticks!([-10:5:20;])
#                 else
#                     ylims!((-1.5,6))
#                     yticks!([-1:1:6;])
#                 end
#             end
#             if j==5||j==6
#                 xlabel!("Return period [yrs]", xguidefontsize=12)
#                 xticks!([1,2,5,10,20,30], ["1", "2", "5", "10", "20", "30"])
#             end
#
#         end
#
#         #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
#         if Catchment_Name == "Feistirtz"
#             title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20), margin=20px)
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[j])*"m)", titlefont = font(20), margin=20px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20), margin=20px)
#         end
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#
#         #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
#         #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
#         box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
#         push!(all_boxplots, box)
#     end
#     Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xguidefontsize=20, xtickfont = font(20), ytickfont = font(20),
#      dpi=300,minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_magnitude_all_Catchments_all_years_return_period_ribbon_min_max.png")
# end

# plot_changes_magnitude_AMF_return_periods_sarah(Catchment_Names_new, Catchment_Height, Area_Catchments, "return period", "absolute")
# plot_changes_magnitude_AMF_return_periods_sarah(Catchment_Names_new, Catchment_Height, Area_Catchments, "return period", "relative")
# plot_changes_magnitude_AMF_return_periods_sarah(Catchment_Names_new, Catchment_Height, Area_Catchments, "return period", "absolute")

function plot_monthly_deficit_all_catchments_absolute(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, ribbons)
    all_boxplots = []
    past = collect(1:3:34)
    xaxis_45 = collect(2:3:35)
    xaxis_85 = collect(3:3:36)
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]


    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        months = repeat([1,2,3,4,5,6,7,8,9,10,11,12],14*nr_runs[j])
        Deficits_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_4.5_new2.txt", ',')
        Deficits_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_8.5_new2.txt", ',')
        Deficits_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/PforF_monthly_days_deficit_Q90_4.5.txt", ',')
        Deficits_85_PforF= readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/PforF_monthly_days_deficit_Q90_8.5.txt", ',')

        # println(size(Deficits_45))
        #println(size(Deficits_45)[2]/14)
        Deficit_monthly_past_45_NS = Deficits_45[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_45_NS = Deficits_45[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_45_NS = Deficits_45[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        Deficit_monthly_past_85_NS = Deficits_85[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_85_NS = Deficits_85[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_85_NS = Deficits_85[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        println(size(Deficit_monthly_past_45_NS), size(Deficit_monthly_future_45_NS))
        Deficit_monthly_past_NS = (Deficit_monthly_past_45_NS + Deficit_monthly_past_85_NS) .* 0.5
        # Deficit_monthly_past_45 = Deficit_monthly_past_45 ./ Threshold_45
        # Deficit_monthly_future_45 = Deficit_monthly_future_45 ./ Threshold_45
        # Deficit_monthly_past_85 = Deficit_monthly_past_85 ./ Threshold_85
        # Deficit_monthly_future_85 = Deficit_monthly_future_85 ./ Threshold_85
        # plot
        Deficit_monthly_past_45_PforF = Deficits_45_PforF[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_45_PforF = Deficits_45_PforF[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_45_PforF = Deficits_45_PforF[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        Deficit_monthly_past_85_PforF = Deficits_85_PforF[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_85_PforF = Deficits_85_PforF[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_85_PforF = Deficits_85_PforF[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        println(size(Deficit_monthly_past_45_PforF), size(Deficit_monthly_future_45_PforF))
        Deficit_monthly_past_PforF = (Deficit_monthly_past_45_PforF + Deficit_monthly_past_85_PforF) .* 0.5

        Plots.plot()

            total_Deficit_monthly_future_45_PforF = zeros(12,4)
            total_Deficit_monthly_future_45_NS = zeros(12,4)
            total_Deficit_monthly_future_85_PforF= zeros(12,4)
            total_Deficit_monthly_future_85_NS= zeros(12,4)

            for month in 1:12
                total_Deficit_monthly_future_45_PforF_ = Deficit_monthly_future_45_PforF[findall(x-> x == month, months)]
                total_Deficit_monthly_future_45_NS_ = Deficit_monthly_future_45_NS[findall(x-> x == month, months)]
                total_Deficit_monthly_future_85_PforF_ = Deficit_monthly_future_85_PforF[findall(x-> x == month, months)]
                total_Deficit_monthly_future_85_NS_ = Deficit_monthly_future_85_NS[findall(x-> x == month, months)]

                total_Deficit_monthly_future_45_PforF[month,:] .= mean(total_Deficit_monthly_future_45_PforF_[:,1]), minimum(total_Deficit_monthly_future_45_PforF_[:,1]), maximum(total_Deficit_monthly_future_45_PforF_[:,1]), std(total_Deficit_monthly_future_45_PforF_[:,1])
                total_Deficit_monthly_future_45_NS[month,:] .= mean(total_Deficit_monthly_future_45_NS_[:,1]), minimum(total_Deficit_monthly_future_45_NS_[:,1]), maximum(total_Deficit_monthly_future_45_NS_[:,1]), std(total_Deficit_monthly_future_45_NS_[:,1])
                total_Deficit_monthly_future_85_PforF[month,:].= mean(total_Deficit_monthly_future_85_PforF_[:,1]), minimum(total_Deficit_monthly_future_85_PforF_[:,1]), maximum(total_Deficit_monthly_future_85_PforF_[:,1]), std(total_Deficit_monthly_future_85_PforF_[:,1])
                total_Deficit_monthly_future_85_NS[month,:] .= mean(total_Deficit_monthly_future_85_NS_[:,1]), minimum(total_Deficit_monthly_future_85_NS_[:,1]), maximum(total_Deficit_monthly_future_85_NS_[:,1]), std(total_Deficit_monthly_future_85_NS_[:,1])
            end

            Plots.plot()
            box = []
            if ribbons=="minmax"
                for month in 1:12
                    plot!(total_Deficit_monthly_future_85_NS[:,1], ribbon = [total_Deficit_monthly_future_85_NS[:,1]-total_Deficit_monthly_future_85_NS[:,2], total_Deficit_monthly_future_85_NS[:,3]-total_Deficit_monthly_future_85_NS[:,1]], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_45_NS[:,1], ribbon = [total_Deficit_monthly_future_45_NS[:,1]-total_Deficit_monthly_future_45_NS[:,2], total_Deficit_monthly_future_45_NS[:,3]-total_Deficit_monthly_future_45_NS[:,1]], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_85_PforF[:,1], ribbon = [total_Deficit_monthly_future_85_PforF[:,1]-total_Deficit_monthly_future_85_PforF[:,2], total_Deficit_monthly_future_85_PforF[:,3]-total_Deficit_monthly_future_85_PforF[:,1]],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_45_PforF[:,1], ribbon = [total_Deficit_monthly_future_45_PforF[:,1]-total_Deficit_monthly_future_45_PforF[:,2], total_Deficit_monthly_future_45_PforF[:,3]-total_Deficit_monthly_future_45_PforF[:,1]], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    if j==6 &&month==12
                        scatter!(total_Deficit_monthly_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,stat")
                        scatter!(total_Deficit_monthly_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,adapt")
                        scatter!(total_Deficit_monthly_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP8.5 Cl,stat")
                        scatter!(total_Deficit_monthly_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP8.5 Cl,adapt")
                    end
                    plot!(total_Deficit_monthly_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=8, markerstrokewidth= 0,label=false)
                    plot!(total_Deficit_monthly_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=8, markerstrokewidth= 0,label=false)
                    plot!(total_Deficit_monthly_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
                    plot!(total_Deficit_monthly_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)
                end
            elseif ribbons=="std"
                for month in 1:12
                    plot!(total_Deficit_monthly_future_85_NS[:,1], ribbon = total_Deficit_monthly_future_85_NS[:,4], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_45_NS[:,1], ribbon = total_Deficit_monthly_future_45_NS[:,4], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_85_PforF[:,1], ribbon = total_Deficit_monthly_future_85_PforF[:,4],  markershape=:circle, markersize=7, markerstrokewidth= 0,color=Farben_85[1], label=false, alpha=0.3)
                    plot!(total_Deficit_monthly_future_45_PforF[:,1], ribbon = total_Deficit_monthly_future_45_PforF[:,4], color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false, alpha=0.3)
                    if j==6 &&month==12
                        scatter!(total_Deficit_monthly_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,stat")
                        scatter!(total_Deficit_monthly_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP4.5 Cl,adapt")
                        scatter!(total_Deficit_monthly_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label="RCP8.5 Cl,stat")
                        scatter!(total_Deficit_monthly_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=7, markerstrokewidth= 0,label="RCP8.5 Cl,adapt")
                    end
                    plot!(total_Deficit_monthly_future_85_NS[:,1], color=Farben_85[2],  markershape=:circle, markersize=8, markerstrokewidth= 0,label=false)
                    plot!(total_Deficit_monthly_future_45_NS[:,1], color=Farben_45[2],  markershape=:circle, markersize=8, markerstrokewidth= 0,label=false)
                    plot!(total_Deficit_monthly_future_85_PforF[:,1], color=Farben_85[1], markershape=:circle, markersize=7, markerstrokewidth= 0, label=false)
                    plot!(total_Deficit_monthly_future_45_PforF[:,1],  color=Farben_45[1], markershape=:circle, markersize=7, markerstrokewidth= 0,label=false)

                end
            end

            # boxplot!([past[month]], Deficit_monthly_past[findall(x-> x == month, months)], size=(2000,800), leg=false, color="grey", outliers=false, label="Past")
        #     if j==6 && month==12
        #         boxplot!([xaxis_45[month]], Deficit_monthly_future_45[findall(x-> x == month, months)], size=(2000,800),  color=Farben_45[2], outliers=false, label="Future RCP 4.5", falpha=0.7)
        #         boxplot!([xaxis_85[month]],Deficit_monthly_future_85[findall(x-> x == month, months)], size=(2000,800),  color=Farben_85[2], left_margin = [5mm 0mm], outliers=false, label="Future RCP 8.5", falpha=0.7)
        #         boxplot!([past[month]], Deficit_monthly_past_pf[findall(x-> x == month, months)], size=(2000,800),  color="grey", outliers=false, label="Past", falpha=0.7)
        #         boxplot!([xaxis_45[month]], Deficit_monthly_future_45_pf[findall(x-> x == month, months)], size=(2000,800),  color=Farben_45[1], outliers=false, label="Future RCP 4.5 PforF", falpha=0.7)
        #         boxplot!([xaxis_85[month]],Deficit_monthly_future_85_pf[findall(x-> x == month, months)], size=(2000,800), leg=true, color=Farben_85[1], left_margin = [5mm 0mm], outliers=false, label="Future RCP 8.5 PforF", falpha=0.7)
        #     else
        #         boxplot!([xaxis_45[month]], Deficit_monthly_future_45[findall(x-> x == month, months)], size=(2000,800),  color=Farben_45[2], outliers=false, label=false, falpha=0.7)
        #         boxplot!([xaxis_85[month]],Deficit_monthly_future_85[findall(x-> x == month, months)], size=(2000,800),  color=Farben_85[2], left_margin = [5mm 0mm], outliers=false, label=false, falpha=0.7)
        #         boxplot!([past[month]], Deficit_monthly_past_pf[findall(x-> x == month, months)], size=(2000,800),  color="grey", outliers=false, label=false, falpha=0.7)
        #         boxplot!([xaxis_45[month]], Deficit_monthly_future_45_pf[findall(x-> x == month, months)], size=(2000,800),  color=Farben_45[1], outliers=false, label=false, falpha=0.7)
        #         boxplot!([xaxis_85[month]],Deficit_monthly_future_85_pf[findall(x-> x == month, months)], size=(2000,800), leg=true, color=Farben_85[1], left_margin = [5mm 0mm], outliers=false, label=false, falpha=0.7)
        #
        #     end
        # end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        #ylabel!("Change in Mean Deficit [mm]")

        #ylabel!("[mm]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        # ylims!((-3,10))
        # yticks!([-2:2:10;])
        if Catchment_Name == "Defreggental" || Catchment_Name == "Pitztal"
            if ribbons=="std"
                ylims!((0,1.5))
            else
                ylims!((0,2.5))
            end
            #yticks!([-0:0.5:1.5;])
        else
            if ribbons=="std"
                ylims!((0,4))
            else
                ylims!((0,5))
            end
            #yticks!([-0:1:4;])
        end
        if j==3
            ylabel!("∆ Monthly Deficit [mm]")

        end
        xticks!([1:1:12;], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        #xlims!((0,25))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [20mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20),  framestyle = :boxlegend, legend=:topright)
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legendfontsize= 20, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, grid=false)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    if ribbons=="minmax"
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Drought/Drought_Monthly_Deficit_Q90_absolute_line_minmax.png")
    elseif ribbons=="std"
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Drought/Drought_Monthly_Deficit_Q90_absolute_line_std.png")
    end

end

# plot_monthly_deficit_all_catchments_absolute(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "std")


function calculate_Q90_Prec_all_catchments_PforF(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
    # Catchment_Name = "Pitztal"
    # i = 6
        if Catchment_Name=="Silbertal"
        #end
        # box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
        # Plots.plot()
        # for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation_NS(path_45, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100,',')
            #
            # path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
            # Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation_PforF(path_85, Area_Catchments[i], Catchment_Name)
            # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100,',')
    #     if Catchment_Name == "Pitten"
    #         Catchment_Name = "Feistritz"
    #     elseif Catchment_Name == "IllSugadin"
    #         Catchment_Name = "Silbertal"
    #     end
    #     violin!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
    #     boxplot!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
    #     println(Catchment_Name)
    #     println("45 ", relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100)
    #     println("85 ", relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100)
    #     #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
    #     #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
    #     #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
    #     # ylims!((-35,35))
    #     # yticks!([-35:10:35;])
    #     hline!([0], color=["grey"], linestyle = :dash)
    #     #ylabel!("Relative Change in Average Annual Discharge [%]")
    #     ylabel!("absolute change Q90/P")
    #     title!("Absolute Change in for RCP 8.5")
        end
    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end

function calculate_Q90_Prec_all_catchments_NS(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        if Catchment_Name=="Silbertal"
    # Catchment_Name = "Pitztal"
    # i = 6
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation_NS(path_85, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100,',')

            # path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
            # Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation_NS(path_45, Area_Catchments[i], Catchment_Name)
            # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100,',')
    #     if Catchment_Name == "Pitten"
    #         Catchment_Name = "Feistritz"
    #     elseif Catchment_Name == "IllSugadin"
    #         Catchment_Name = "Silbertal"
    #     end
    #     violin!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
    #     boxplot!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
    #     println(Catchment_Name)
    #     println("45 ", relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100)
    #     println("85 ", relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100)
    #     #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
    #     #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
    #     #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
    #     # ylims!((-35,35))
    #     # yticks!([-35:10:35;])
    #     hline!([0], color=["grey"], linestyle = :dash)
    #     #ylabel!("Relative Change in Average Annual Discharge [%]")
    #     ylabel!("absolute change Q90/P")
    #     title!("Absolute Change in for RCP 8.5")
        end
    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end

function calculate_Q90_Prec_all_catchments_PforF_abs(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation_NS(path_45, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec_abs.txt",Q90_Prec_Future45- Q90_Prec_Past45,',')
            #
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation_PforF(path_85, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec_abs.txt",Q90_Prec_Future85-Q90_Prec_Past85,',')
    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end

function calculate_Q90_Prec_all_catchments_NS_abs(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    # Farben_45= palette(:reds)
    # Farben_85= palette(:blues)
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        # if Catchment_Name=="Silbertal"
    # Catchment_Name = "Pitztal"
    # i = 6
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation_NS(path_85, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec_abs.txt",Q90_Prec_Future85-Q90_Prec_Past85,',')

        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation_NS(path_45, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec_abs.txt",Q90_Prec_Future45-Q90_Prec_Past45,',')

    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end
# for (c,Catchment_Name) in enumerate(Catchment_Names_new)
#     if Catchment_Name =="Silbertal"
#         println(Catchment_Name)
#         @time begin
#         Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45 = monthly_days_Q90_NS(path_45, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_4.5_new.txt",hcat(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45),',')
#
#         Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85 = monthly_days_Q90_NS(path_85, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_8.5_new.txt",hcat(Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85),',')
#         # plot_monthly_low_flows(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Catchment_Name, nr_runs)
#         # plot_monthly_deficit(Deficit_monthly_past_45, Deficit_monthly_future_45, Deficit_monthly_past_85, Deficit_monthly_future_85, Catchment_Name, nr_runs)
#         end
#     end
# end
# calculate_Q90_Prec_all_catchments_NS(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)
# calculate_Q90_Prec_all_catchments_PforF(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)
# for (c,Catchment_Name) in enumerate(Catchment_Names_new)
#     if Catchment_Name !="Silbertal"
#         println(Catchment_Name)
#         @time begin
#         Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45 = monthly_days_Q90_NS(path_45, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_4.5_new2.txt",hcat(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45),',')
#
#         Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85 = monthly_days_Q90_NS(path_85, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_8.5_new2.txt",hcat(Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85),',')
#         # plot_monthly_low_flows(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Catchment_Name, nr_runs)
#         # plot_monthly_deficit(Deficit_monthly_past_45, Deficit_monthly_future_45, Deficit_monthly_past_85, Deficit_monthly_future_85, Catchment_Name, nr_runs)
#         end
#     end
# end

# function plot_Q90_Prec_all_catchments_NS(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
#     all_boxplots=[]
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#
#         Plots.plot()
#         RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",',')
#         RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",',')
#         RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",',')
#         RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",',')
#
#
#         # if Catchment_Name == "Pitten"
#         #     Catchment_Name = "Feistritz"
#         # elseif Catchment_Name == "IllSugadin"
#         #     Catchment_Name = "Silbertal"
#         # end
#         if Catchment_Name == "Feistritz"
#             Catchment_Name = "Feistritztal"
#             println("works")
#         elseif Catchment_Name == "Palten"
#             Catchment_Name = "Paltental"
#         end
#         # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
#         # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
#         # if i!=6
#             violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
#             violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
#             violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
#             violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
#         # else
#         if i==6
#             scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
#             scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
#         end
#         println(size(RE_Q90_PforF_85)[1])
#         # for j in 1:size(RE_Q90_PforF_85)[1]
#         # scatter!([ones(length(RE_Q90_PforF_85))], [RE_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*2], [RE_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#
#         ylims!((-55,80))
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px )
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=10px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px)
#         end
#         # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
#         if i==1 || i==4
#             ylabel!("∆Q90 [%]")
#             # yticks!([-50:25:75;])
#         end
#         if i in 1:3
#             ylims!((-45,65))
#             yticks!([-40:20:60;])
#         else
#             ylims!((-30,130))
#             yticks!([-20:20:120;])
#         end
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#         # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
#         box_85 = boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:bottomright)
#         push!(all_boxplots,box_85)
#     end
#     Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(2,3), size=(2200,1200), minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4,framestyle = :box, left_margin=[20mm 0mm 0mm])
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_all_catchments_45_85_relative_total.png")
#
# end

# calculate_Q90_Prec_all_catchments_NS_abs(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)
# calculate_Q90_Prec_all_catchments_PforF_abs(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)


# for (c,Catchment_Name) in enumerate(Catchment_Names_new)
#     if Catchment_Name!="Silbertal"
#         println(Catchment_Name)
#         @time begin
#         Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45 = monthly_days_Q90_NS(path_45, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_4.5_new.txt",hcat(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Deficit_monthly_past_45, Deficit_monthly_future_45, Threshold_45),',')
#
#         Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85 = monthly_days_Q90_NS(path_85, Area_Catchments[c], Catchment_Name)
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/NS_monthly_days_deficit_Q90_8.5_new.txt",hcat(Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Deficit_monthly_past_85, Deficit_monthly_future_85, Threshold_85),',')
#         # plot_monthly_low_flows(Nr_Days_Drought_monthly_past_45, Nr_Days_Drought_monthly_future_45, Nr_Days_Drought_monthly_past_85, Nr_Days_Drought_monthly_future_85, Catchment_Name, nr_runs)
#         # plot_monthly_deficit(Deficit_monthly_past_45, Deficit_monthly_future_45, Deficit_monthly_past_85, Deficit_monthly_future_85, Catchment_Name, nr_runs)
#         end
#     end
# end


# plot_Q90_Prec_all_catchments_NS(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)

# calculate_Q90_Prec_all_catchments_NS(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)

# function plot_Q90_Prec_all_catchments_combined(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change)
#     Plots.plot()
#     all_boxplots=[]
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#
#         Plots.plot()
#         low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year4.5.txt",',')
#         Low_Flows_past45 = low_flow_45[:,1]
#         Low_Flows_future45 = low_flow_45[:,2]
#         low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year8.5.txt",',')
#         Low_Flows_past85 = low_flow_85[:,1]
#         Low_Flows_future85 = low_flow_85[:,2]
#         low_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year4.5.txt",',')
#         Low_Flows_past45_pf = low_flow_45_pf[:,1]
#         Low_Flows_future45_pf = low_flow_45_pf[:,2]
#         low_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year8.5.txt",',')
#         Low_Flows_past85_pf = low_flow_85_pf[:,1]
#         Low_Flows_future85_pf = low_flow_85_pf[:,2]
#
#         if change == "relative"
#             violin!([1], relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#
#             violin!([2], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([1], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             violin!([3.5], relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             violin!([4.5], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([2], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             if i==1
#                 ylabel!("∆ Magnitude of 7day Low Flows [%]")
#             end
#             if i in 1:3
#                 ylims!((-50,70))
#                 if i==1
#                     yticks!([-40:20:60;])
#                 end
#             else
#                 ylims!((-60,180))
#                 if i==4
#                     yticks!([-50:25:175;])
#                 end
#             end
#
#
#         elseif change == "absolute"
#             violin!([1], Low_Flows_future45_pf- Low_Flows_past45_pf, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#
#             violin!([2], Low_Flows_future45- Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([1], Low_Flows_future45, Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             violin!([3.5], Low_Flows_future85_pf- Low_Flows_past85_pf, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             violin!([4.5], Low_Flows_future85-Low_Flows_past85, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([2], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             # println(Catchment_Name)
#             # println("Change 45 ", median((Low_Flows_future45 - Low_Flows_past45)))
#             # println("Change 85 ", median((Low_Flows_future85 - Low_Flows_past85)))
#             if i==1
#                 ylabel!("∆ Magnitude of 7day Low Flows [mm]")
#             end
#
#         end
#
#
#         # if Catchment_Name == "Pitten"
#         #     Catchment_Name = "Feistritz"
#         # elseif Catchment_Name == "IllSugadin"
#         #     Catchment_Name = "Silbertal"
#         # end
#         if Catchment_Name == "Feistritz"
#             Catchment_Name = "Feistritztal"
#             println("works")
#         elseif Catchment_Name == "Palten"
#             Catchment_Name = "Paltental"
#         end
#         # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
#         # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
#         # if i!=6
#             # violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
#             # violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
#             # violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
#             # violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
#         # else
#         # if i==6
#         #     scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
#         #     scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
#         #     scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
#         #     scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
#         # end
#
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
#         end
#         # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#         # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
#         box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft)
#         push!(all_boxplots,box_85)
#     end
#     box1 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(1,6), size=(4400,600), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[40mm 0mm 0mm 20mm 0mm 0mm])
#     all_boxplots=[]
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#
#         Plots.plot()
#         RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",',')
#         RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",',')
#         RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",',')
#         RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",',')
#
#
#         # if Catchment_Name == "Pitten"
#         #     Catchment_Name = "Feistritz"
#         # elseif Catchment_Name == "IllSugadin"
#         #     Catchment_Name = "Silbertal"
#         # end
#         if Catchment_Name == "Feistritz"
#             Catchment_Name = "Feistritztal"
#             println("works")
#         elseif Catchment_Name == "Palten"
#             Catchment_Name = "Paltental"
#         end
#         # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
#         # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
#         # if i!=6
#             violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
#             violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
#             violin!([3.5], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
#             violin!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
#         # else
#         if i==6
#             scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
#             scatter!([3.5], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
#         end
#         println(size(RE_Q90_PforF_85)[1])
#         # for j in 1:size(RE_Q90_PforF_85)[1]
#         # scatter!([ones(length(RE_Q90_PforF_85))], [RE_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*2], [RE_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#
#         ylims!((-55,80))
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
#         end
#         # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
#         if i==1
#             ylabel!("∆Q90 [%]")
#             # yticks!([-50:25:75;])
#         end
#         if i in 1:3
#             ylims!((-45,65))
#             if i==1
#                 yticks!([-40:20:60;])
#             end
#         else
#             ylims!((-30,130))
#             if i==4
#                 yticks!([-20:20:120;])
#             end
#         end
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#         # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
#         box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft)
#         push!(all_boxplots,box_85)
#     end
#     box2 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(1,6), size=(4400,600), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[40mm 0mm 0mm 20mm 0mm 0mm])
#     # total_plot=[]
#     # push!(total_plot, box_1, box_2)
# #    push!(total_plot, box_2)
#     Plots.plot(box1, box2, layout=(2,1), size=(4400,1200))#,minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_7d_combined_all_catchments.png")
#
# end
#
# function plot_Q90_Prec_all_catchments_combined_abs(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change)
#     Plots.plot()
#     all_boxplots=[]
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#
#         Plots.plot()
#         low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year4.5.txt",',')
#         Low_Flows_past45 = low_flow_45[:,1]
#         Low_Flows_future45 = low_flow_45[:,2]
#         low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year8.5.txt",',')
#         Low_Flows_past85 = low_flow_85[:,1]
#         Low_Flows_future85 = low_flow_85[:,2]
#         low_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year4.5.txt",',')
#         Low_Flows_past45_pf = low_flow_45_pf[:,1]
#         Low_Flows_future45_pf = low_flow_45_pf[:,2]
#         low_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year8.5.txt",',')
#         Low_Flows_past85_pf = low_flow_85_pf[:,1]
#         Low_Flows_future85_pf = low_flow_85_pf[:,2]
#
#         if change == "relative"
#             violin!([1], relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#
#             violin!([2], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([1], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             violin!([3.5], relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             violin!([4.5], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([2], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             if i==1
#                 ylabel!("Change in magnitude 7 day low flows [%]")
#             end
#             if i in 1:3
#                 ylims!((-50,70))
#                 if i==1
#                     yticks!([-40:20:60;])
#                 end
#             else
#                 ylims!((-60,180))
#                 if i==4
#                     yticks!([-50:25:175;])
#                 end
#             end
#
#
#         elseif change == "absolute"
#             violin!([1], Low_Flows_future45_pf- Low_Flows_past45_pf, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#
#             violin!([2], Low_Flows_future45- Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([1], Low_Flows_future45, Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             violin!([3.5], Low_Flows_future85_pf- Low_Flows_past85_pf, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             violin!([4.5], Low_Flows_future85-Low_Flows_past85, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
#             # boxplot!([2], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
#             # println(Catchment_Name)
#             # println("Change 45 ", median((Low_Flows_future45 - Low_Flows_past45)))
#             # println("Change 85 ", median((Low_Flows_future85 - Low_Flows_past85)))
#             if i==1
#                 ylabel!("Absolute change in 7day low flows  [mm]")
#             end
#
#         end
#
#
#         # if Catchment_Name == "Pitten"
#         #     Catchment_Name = "Feistritz"
#         # elseif Catchment_Name == "IllSugadin"
#         #     Catchment_Name = "Silbertal"
#         # end
#         if Catchment_Name == "Feistritz"
#             Catchment_Name = "Feistritztal"
#             println("works")
#         elseif Catchment_Name == "Palten"
#             Catchment_Name = "Paltental"
#         end
#         # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
#         # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
#         # if i!=6
#             # violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
#             # violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
#             # violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
#             # violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
#         # else
#         # if i==6
#         #     scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
#         #     scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
#         #     scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
#         #     scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
#         # end
#
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
#         end
#         # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#         # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
#         box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft)
#         push!(all_boxplots,box_85)
#     end
#     box1 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(1,6), size=(4400,600), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[40mm 0mm 0mm 20mm 0mm 0mm])
#     all_boxplots=[]
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#
#         Plots.plot()
#         abs_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec_abs.txt",',')
#         abs_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec_abs.txt",',')
#         abs_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec_abs.txt",',')
#         abs_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec_abs.txt",',')
#
#
#         # if Catchment_Name == "Pitten"
#         #     Catchment_Name = "Feistritz"
#         # elseif Catchment_Name == "IllSugadin"
#         #     Catchment_Name = "Silbertal"
#         # end
#         if Catchment_Name == "Feistritz"
#             Catchment_Name = "Feistritztal"
#             println("works")
#         elseif Catchment_Name == "Palten"
#             Catchment_Name = "Paltental"
#         end
#         # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
#         # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
#         # if i!=6
#             violin!([1], abs_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
#             violin!([2], abs_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
#             violin!([3.5], abs_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
#             violin!([4.5], abs_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
#         # else
#         if i==6
#             scatter!([1],  abs_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([2],  abs_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
#             scatter!([3.5], abs_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
#             scatter!([4.5], abs_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
#         end
#         println(size(abs_Q90_PforF_85)[1])
#         # for j in 1:size(abs_Q90_PforF_85)[1]
#         # scatter!([ones(length(abs_Q90_PforF_85))], [abs_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
#         # scatter!([ones(length(abs_Q90_PforF_85)).*2], [abs_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#         # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
#
#         ylims!((-55,80))
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
#         else
#             title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
#         end
#         # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
#         if i==1
#             ylabel!("∆Q90/P [%]")
#             # yticks!([-50:25:75;])
#         end
#         ylims!((-1,1))
#         # if i in 1:3
#         #     ylims!((-45,65))
#         #     if i==1
#         #         yticks!([-40:20:60;])
#         #     end
#         # else
#         #     ylims!((-30,130))
#         #     if i==4
#         #         yticks!([-20:20:120;])
#         #     end
#         # end
#         hline!([0], color=["grey"], linestyle = :dash, label=false)
#         # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
#         box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft)
#         push!(all_boxplots,box_85)
#     end
#     box2 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(1,6), size=(4400,600), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[40mm 0mm 0mm 20mm 0mm 0mm])
#     # total_plot=[]
#     # push!(total_plot, box_1, box_2)
# #    push!(total_plot, box_2)
#     Plots.plot(box1, box2, layout=(2,1), size=(4400,1200))#,minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_7d_combined_all_catchments_abs.png")
#
# end
# plot_Q90_Prec_all_catchments_combined(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "relative")
# plot_Q90_Prec_all_catchments_combined(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "absolute")

# plot_Q90_Prec_all_catchments_combined_abs(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "absolute")

function plot_Q90_Prec_all_catchments_combined_layout2(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change)
    Plots.plot()
    all_boxplots=[]
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names[1:3])

        Plots.plot()
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year4.5.txt",',')
        Low_Flows_past45 = low_flow_45[:,1]
        Low_Flows_future45 = low_flow_45[:,2]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year8.5.txt",',')
        Low_Flows_past85 = low_flow_85[:,1]
        Low_Flows_future85 = low_flow_85[:,2]
        low_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year4.5.txt",',')
        Low_Flows_past45_pf = low_flow_45_pf[:,1]
        Low_Flows_future45_pf = low_flow_45_pf[:,2]
        low_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year8.5.txt",',')
        Low_Flows_past85_pf = low_flow_85_pf[:,1]
        Low_Flows_future85_pf = low_flow_85_pf[:,2]

        if change == "relative"
            violin!([1], relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([2], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([3.5], relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([4.5], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            scatter!(ones(14)*1, relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, markercolour="black", label=false)
            scatter!(ones(14)*2, relative_error(Low_Flows_future45, Low_Flows_past45)*100, markercolour="black",label=false)
            scatter!(ones(14)*3.5, relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, markercolour="black",label=false)
            scatter!(ones(14)*4.5, relative_error(Low_Flows_future85, Low_Flows_past85)*100, markercolour="black",label=false)

            scatter!([1], [median(relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([2], [median(relative_error(Low_Flows_future45, Low_Flows_past45)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([3.5], [median(relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([4.5], [median(relative_error(Low_Flows_future85, Low_Flows_past85)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)

            if i==1
                ylabel!("∆ Magnitude of 7day Low Flows [%]")
            end
            if i in 1:3
                ylims!((-50,70))
                if i==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["","","","","","",""])

                end
            else
                ylims!((-60,180))
                if i==4
                    yticks!([-50:25:175;])
                else
                    yticks!([-50:25:175;], ["","","","","","","","","",""])

                end
            end


        elseif change == "absolute"
            violin!([1], Low_Flows_future45_pf- Low_Flows_past45_pf, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([2], Low_Flows_future45- Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([3.5], Low_Flows_future85_pf- Low_Flows_past85_pf, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([4.5], Low_Flows_future85- Low_Flows_past85, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            scatter!(ones(14)*1, Low_Flows_future45_pf- Low_Flows_past45_pf, markercolour="black", label=false)
            scatter!(ones(14)*2, Low_Flows_future45- Low_Flows_past45, markercolour="black",label=false)
            scatter!(ones(14)*3.5, Low_Flows_future85_pf- Low_Flows_past85_pf, markercolour="black",label=false)
            scatter!(ones(14)*4.5, Low_Flows_future85- Low_Flows_past85, markercolour="black",label=false)

            scatter!([1], [median(Low_Flows_future45_pf- Low_Flows_past45_pf)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([2], [median(Low_Flows_future45- Low_Flows_past45)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([3.5], [median(Low_Flows_future85_pf- Low_Flows_past85_pf)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([4.5], [median(Low_Flows_future85- Low_Flows_past85)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)

            if i==1
                ylabel!("∆ Magnitude of 7day Low Flows [mm]")
            end
            if i in 1:3
                ylims!((-4,4))
                if i==1
                    yticks!([-4.00:2.00:4.00;])
                else
                    yticks!([-4.00:2.00:4.00;], ["","","","","","",""])

                end
            else
                ylims!((-1.2,1.7))
                if i==4
                    yticks!([-1:0.5:1.5;])
                else
                    yticks!([-1:0.5:1.5;], ["","","","","",""])

                end
            end
        end

        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            # violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
            # violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
            # violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
            # violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
        # else
        # if i==6
        #     scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
        #     scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        # end
        # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft, outliers=true)
        push!(all_boxplots,box_85)
    end
    box1 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3], layout=(1,3), size=(2200,600),  framestyle = :box, left_margin=[20mm 0mm 0mm], topmargin=10px)
    all_boxplots=[]
    for (i,Catchment_Name) in enumerate(All_Catchment_Names[1:3])

        Plots.plot()
        if change=="relative"
            RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",',')
            RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",',')
            RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",',')
            RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",',')
        elseif change=="absolute"
            RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec_abs.txt",',')
            RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec_abs.txt",',')
            RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec_abs.txt",',')
            RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec_abs.txt",',')
        end
            # if Catchment_Name == "Pitten"
            #     Catchment_Name = "Feistritz"
            # elseif Catchment_Name == "IllSugadin"
            #     Catchment_Name = "Silbertal"
            # end
            if Catchment_Name == "Feistritz"
                Catchment_Name = "Feistritztal"
                println("works")
            elseif Catchment_Name == "Palten"
                Catchment_Name = "Paltental"
            end
            if change == "absolute" && i==1
                scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
                scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
                scatter!([3.5], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
                scatter!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
            end
            # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
            # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
            # if i!=6
            violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
            violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
            violin!([3.5], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
            violin!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
            scatter!(ones(14)*1, RE_Q90_PforF_45[:,1], xticks=:none,yticks=:none, label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1)
            scatter!(ones(14)*2, RE_Q90_NS_45[:,1], xticks=:none,yticks=:none,label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1)
            scatter!(ones(14)*3.5, RE_Q90_PforF_85[:,1], xticks=:none,yticks=:none,label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1)
            scatter!(ones(14)*4.5, RE_Q90_NS_85[:,1], xticks=:none,yticks=:none,label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1)
            scatter!([1], [mean(RE_Q90_PforF_45[:,1])], xticks=:none,yticks=:none, label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7)
            scatter!([2], [mean(RE_Q90_NS_45[:,1])], xticks=:none,yticks=:none,label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7)
            scatter!([3.5], [mean(RE_Q90_PforF_85[:,1])], xticks=:none,yticks=:none,label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7)
            scatter!([4.5],[mean(RE_Q90_NS_85[:,1])], xticks=:none,yticks=:none,label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7)


            println(size(RE_Q90_PforF_85)[1])
            # for j in 1:size(RE_Q90_PforF_85)[1]
            # scatter!([ones(length(RE_Q90_PforF_85))], [RE_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
            # scatter!([ones(length(RE_Q90_PforF_85)).*2], [RE_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
            # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
            # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
            if change=="relative"
                # ylims!((-55,80))
            # if Catchment_Name == "Feistritz"
            #     title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
            # elseif Catchment_Name == "Palten"
            #     title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
            # else
            #     title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
            # end
            # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
                if i==1
                    ylabel!("∆Q90/P [%]")
                    # yticks!([-50:25:75;])
                end
                if i in 1:3
                    ylims!((-45,65))
                    if i==1
                        yticks!([-40:20:60;])
                    else
                        yticks!([-40:20:60;], ["","","","","",""])

                    end
                else
                    ylims!((-30,130))
                    if i==4
                        yticks!([-20:20:120;], ["","","","","","","",""])
                    end
                end
            elseif change=="absolute"
                if i==1
                    ylabel!("∆Q90/P [-]")
                    # yticks!([-50:25:75;])
                end
                if i in 1:3
                    ylims!((-0.2,0.2))
                    if i==1
                        yticks!([-0.2:0.1:0.2;])
                    else
                        yticks!([-0.2:0.1:0.2;], ["","","","","","",""])
                    end
                else
                    ylims!((-0.15,0.15))
                    if i==4
                        yticks!([-0.15:0.05:0.15;])
                    else
                        yticks!([-0.15:0.05:0.15;], ["","","","","","",""])
                    end
                end

            end
            hline!([0], color=["grey"], linestyle = :dash, label=false)
            # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
            box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft, outliers=true)
            push!(all_boxplots,box_85)
    end
    box2 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3], layout=(1,3), size=(2200,600), framestyle = :box, left_margin=[20mm 0mm 0mm], topmargin=10px)
    all_boxplots=[]

    for (i,Catchment_Name) in enumerate(All_Catchment_Names[4:6])
        i=i+3
        Plots.plot()
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year4.5.txt",',')
        Low_Flows_past45 = low_flow_45[:,1]
        Low_Flows_future45 = low_flow_45[:,2]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_whole_year8.5.txt",',')
        Low_Flows_past85 = low_flow_85[:,1]
        Low_Flows_future85 = low_flow_85[:,2]
        low_flow_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year4.5.txt",',')
        Low_Flows_past45_pf = low_flow_45_pf[:,1]
        Low_Flows_future45_pf = low_flow_45_pf[:,2]
        low_flow_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_whole_year8.5.txt",',')
        Low_Flows_past85_pf = low_flow_85_pf[:,1]
        Low_Flows_future85_pf = low_flow_85_pf[:,2]

        if change == "relative"

            violin!([1], relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([2], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([3.5], relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            violin!([4.5], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, yticks=:none, label=false)
            scatter!(ones(14)*1, relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100, markercolour="black", label=false)
            scatter!(ones(14)*2, relative_error(Low_Flows_future45, Low_Flows_past45)*100, markercolour="black",label=false)
            scatter!(ones(14)*3.5, relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100, markercolour="black",label=false)
            scatter!(ones(14)*4.5, relative_error(Low_Flows_future85, Low_Flows_past85)*100, markercolour="black",label=false)

            scatter!([1], [median(relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([2], [median(relative_error(Low_Flows_future45, Low_Flows_past45)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([3.5], [median(relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([4.5], [median(relative_error(Low_Flows_future85, Low_Flows_past85)*100)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)

            if i==1
                ylabel!("∆ Magnitude 7day low flows [%]")
            end
            if i in 1:3
                ylims!((-50,70))
                if i==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["","","","","","",""])

                end
            else
                ylims!((-60,180))
                if i==4
                    yticks!([-50:25:175;])
                else
                    yticks!([-50:25:175;], ["","","","","","","","","",""])

                end
            end


        elseif change == "absolute"
            violin!([1], Low_Flows_future45_pf- Low_Flows_past45_pf, size=(2000,800), leg=false, color=[Farben_45[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([2], Low_Flows_future45- Low_Flows_past45, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([3.5], Low_Flows_future85_pf- Low_Flows_past85_pf, size=(2000,800), leg=false, color=[Farben_85[1]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            violin!([4.5], Low_Flows_future85- Low_Flows_past85, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, xticks=:none, label=false)
            scatter!(ones(14)*1, Low_Flows_future45_pf- Low_Flows_past45_pf, markercolour="black", label=false)
            scatter!(ones(14)*2, Low_Flows_future45- Low_Flows_past45, markercolour="black",label=false)
            scatter!(ones(14)*3.5, Low_Flows_future85_pf- Low_Flows_past85_pf, markercolour="black",label=false)
            scatter!(ones(14)*4.5, Low_Flows_future85- Low_Flows_past85, markercolour="black",label=false)

            scatter!([1], [median(Low_Flows_future45_pf- Low_Flows_past45_pf)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([2], [median(Low_Flows_future45- Low_Flows_past45)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([3.5], [median(Low_Flows_future85_pf- Low_Flows_past85_pf)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            scatter!([4.5], [median(Low_Flows_future85- Low_Flows_past85)], markercolor="white", markersize=7, markerstrokecolour="black", markerstrokewidth=1,label=false)
            # boxplot!([2], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3, xticks=:none, yticks=:none, label=false)
            # println(Catchment_Name)
            # println("Change 45 ", median((Low_Flows_future45 - Low_Flows_past45)))
            # println("Change 85 ", median((Low_Flows_future85 - Low_Flows_past85)))
            if i==1
                ylabel!("∆ Magnitude 7day low flows [mm]")
            end

            if i in 1:3
                ylims!((-4.2,4))
                if i==1
                    yticks!([-4:2:4;])
                else
                    yticks!([-4:2:4;], ["","","","",""])

                end
            else
                ylims!((-1.2,1.7))
                if i==4
                    yticks!([-1:0.5:1.5;])
                else
                    yticks!([-1:0.5:1.5;], ["","","","","",""])

                end
            end

        end


        # if Catchment_Name == "Pitten"
        #     Catchment_Name = "Feistritz"
        # elseif Catchment_Name == "IllSugadin"
        #     Catchment_Name = "Silbertal"
        # end
        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            # violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
            # violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
            # violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
            # violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
        # else
        # if i==6
        #     scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
        #     scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        # end
        println(Catchment_Name)

        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=20px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=20px)
        end
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft, outliers=true)
        push!(all_boxplots,box_85)
    end
    box3 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3], layout=(1,3), size=(2200,600),  framestyle = :box, left_margin=[20mm 0mm 0mm], topmargin=10px)
    all_boxplots=[]
    for (i,Catchment_Name) in enumerate(All_Catchment_Names[4:6])
        i=i+3
        Plots.plot()
        if change=="relative"
            RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",',')
            RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",',')
            RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",',')
            RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",',')
            if i==1
                ylabel!("∆ Q90/P [%]")
            end
        elseif change=="absolute"
            RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec_abs.txt",',')
            RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec_abs.txt",',')
            RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec_abs.txt",',')
            RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec_abs.txt",',')
            if i==1
                ylabel!("∆ Q90/P [-]")
            end
        end

        # if i==6
        #     scatter!([1],  [median(relative_error(Low_Flows_future45_pf, Low_Flows_past45_pf)*100)],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([2],  [median(relative_error(Low_Flows_future45, Low_Flows_past45)*100)],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
        #     scatter!([3.5], [median(relative_error(Low_Flows_future85_pf, Low_Flows_past85_pf)*100)],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
        #     scatter!([4.5], [median(relative_error(Low_Flows_future85, Low_Flows_past85)*100)],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        # end

        # if Catchment_Name == "Pitten"
        #     Catchment_Name = "Feistritz"
        # elseif Catchment_Name == "IllSugadin"
        #     Catchment_Name = "Silbertal"
        # end
        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        if change == "relative"
            if  i==4
                scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
                scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
                scatter!([3.5], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
                scatter!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
            end
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], label=false ,xticks=:none)
            violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]],label=false ,xticks=:none)
            violin!([3.5], RE_Q90_PforF_85[:,1],color=[Farben_85[1]],label=false ,xticks=:none)
            violin!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]],label=false ,xticks=:none)
            scatter!(ones(14)*1, RE_Q90_PforF_45[:,1], label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1 ,xticks=:none)
            scatter!(ones(14)*2, RE_Q90_NS_45[:,1],label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1 ,xticks=:none)
            scatter!(ones(14)*3.5, RE_Q90_PforF_85[:,1],label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1 ,xticks=:none)
            scatter!(ones(14)*4.5, RE_Q90_NS_85[:,1],label=false, markercolor="black", markerstrokecolor="black", markerstrokewidth=1 ,xticks=:none)
            scatter!([1], [mean(RE_Q90_PforF_45[:,1])], label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7 ,xticks=:none)
            scatter!([2], [mean(RE_Q90_NS_45[:,1])],label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7 ,xticks=:none)
            scatter!([3.5], [mean(RE_Q90_PforF_85[:,1])],label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7 ,xticks=:none)
            scatter!([4.5],[mean(RE_Q90_NS_85[:,1])],label=false, markercolor="white", markerstrokecolor="black", markerstrokewidth=1, markersize=7 ,xticks=:none)
        # else
        if i==1
            scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]],label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]],label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
            scatter!([3.5], RE_Q90_NS_45[:,1],color=[Farben_85[1]],label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([4.5], RE_Q90_NS_85[:,1],color=[Farben_85[2]],label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        end
        println(size(RE_Q90_PforF_85)[1])
        # for j in 1:size(RE_Q90_PforF_85)[1]
        # scatter!([ones(length(RE_Q90_PforF_85))], [RE_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*2], [RE_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)

        if change=="relative"
            ylims!((-55,80))
            if i in 1:3
                ylims!((-45,65))
                if i==1
                    yticks!([-40:20:60;])
                else
                    yticks!([-40:20:60;], ["", "", "", "", "",""])
                end
            else
                ylims!((-60,180))
                if i==4
                    yticks!([-50:25:175;])
                else
                    yticks!([-50:25:175;], ["","","","","","","","","",""])
                end
            end
        elseif change=="absolute"
            if i in 1:3
                ylims!((-0.2,0.2))
                if i==1
                    yticks!([-0.2:0.1:0.2;])
                else
                    yticks!([-0.2:0.1:0.2;], ["","","","","","",""])
                end
            else
                ylims!((-0.15,0.15))
                if i==4
                    yticks!([-0.15:0.05:0.15;])
                else
                    yticks!([-0.15:0.05:0.15;], ["","","","","","",""])
                end
            end
        end

        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:topleft, xticks=:none, outliers=true)
        push!(all_boxplots,box_85)
    end
    box4 = Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3], layout=(1,3), size=(2200,600), framestyle = :box, left_margin=[20mm 0mm 0mm], topmargin=10px)

    # total_plot=[]
    # push!(total_plot, box_1, box_2)
#    push!(total_plot, box_2)
    box11 = Plots.plot(box1, box2, layout=(2,1), size=(1200,1200),minorticks=true, grid=false)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_7d_combined_3_catchments_1.png")
    box22=Plots.plot(box3, box4, layout=(2,1), size=(1200,1200),minorticks=true, grid=false)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_7d_combined_3_catchments_2.png")
    tot = Plots.plot(box11,box22, layout=(1,2), size=(2500,1200), legend=:topleft, legendfontsize=16)
    display(tot)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_7d_combined_3_catchments_total"*string(change)*".png")

end
# plot_Q90_Prec_all_catchments_combined_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "relative")
# plot_Q90_Prec_all_catchments_combined_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "absolute")

# plot_magnitude_low_flows(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "relative")
# plot_Q90_Prec_all_catchments_combined_layout2(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new, "relative")

function plot_timing_changes_low_flows_all_Catchments_fraction_4585(All_Catchment_Names, Elevation, nr_runs_new, errorbounds)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        # max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_prob_distr_4.5.txt", ',')
        Farben_45= palette(:reds)
        # max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_low_flows_prob_distr_8.5.txt", ',')
        Farben_85= palette(:blues)
        # max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_prob_distr_4.5.txt", ',')
        # max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_low_flows_prob_distr_8.5.txt", ',')
        #
        # Date_Past_45 = max_discharge_prob_45[:,4]
        # Date_Future_45 = max_discharge_prob_45[:,5]
        # Date_Past_85 = max_discharge_prob_85[:,4]
        # Date_Future_85 = max_discharge_prob_85[:,5]
        # Date_Past_45_pf = max_discharge_prob_45_pf[:,4]
        # Date_Future_45_pf = max_discharge_prob_45_pf[:,5]
        # Date_Past_85_pf = max_discharge_prob_85_pf[:,4]
        # Date_Future_85_pf = max_discharge_prob_85_pf[:,5]
        #
        # # nr_runs = Int(round((size(Date_Past_85)[1]-100)/14/29))
        # # println()
        # # println(nr_runs)
        # period_15_days_past_45, day_range_past_45 = get_distributed_dates(Date_Past_45, 15, nr_runs[j], 29)
        # period_15_days_future_45, day_range_future_45 = get_distributed_dates(Date_Future_45, 15, nr_runs[j], 29)
        # period_15_days_past_85, day_range_past_85 = get_distributed_dates(Date_Past_85, 15, nr_runs[j], 29)
        # period_15_days_future_85, day_range_future_85 = get_distributed_dates(Date_Future_85, 15, nr_runs[j], 29)
        # period_15_days_past_45_pf, day_range_past_45_pf = get_distributed_dates(Date_Past_45_pf, 15, nr_runs[j], 29)
        # period_15_days_future_45_pf, day_range_future_45_pf = get_distributed_dates(Date_Future_45_pf, 15, nr_runs[j], 29)
        # period_15_days_past_85_pf, day_range_past_85_pf = get_distributed_dates(Date_Past_85_pf, 15, nr_runs[j], 29)
        # period_15_days_future_85_pf, day_range_future_85_pf = get_distributed_dates(Date_Future_85_pf, 15, nr_runs[j], 29)
        #
        Plots.plot()
        # #print(size(period_15_days_future))
        # mean_per_15_days_past_45 = Float64[]
        # mean_per_15_days_future_45 = Float64[]
        # mean_per_15_days_past_85 = Float64[]
        # mean_per_15_days_future_85 = Float64[]
        # std_per_15_days_past_45 = Float64[]
        # std_per_15_days_future_45 = Float64[]
        # std_per_15_days_past_85 = Float64[]
        # std_per_15_days_future_85 = Float64[]
        # mean_per_15_days_past_45_pf = Float64[]
        # mean_per_15_days_future_45_pf = Float64[]
        # mean_per_15_days_past_85_pf = Float64[]
        # mean_per_15_days_future_85_pf = Float64[]
        # std_per_15_days_past_45_pf = Float64[]
        # std_per_15_days_future_45_pf = Float64[]
        # std_per_15_days_past_85_pf = Float64[]
        # std_per_15_days_future_85_pf = Float64[]
        #
        # for i in collect(0:15:366)
        #     current_past_45 = period_15_days_past_45[findall(x->x==i, day_range_past_45)]
        #     current_future_45 = period_15_days_future_45[findall(x->x==i, day_range_future_45)]
        #     append!(mean_per_15_days_past_45, mean(current_past_45)*100)
        #     append!(mean_per_15_days_future_45, mean(current_future_45)*100)
        #     append!(std_per_15_days_past_45, std(current_past_45)*100)
        #     append!(std_per_15_days_future_45, std(current_future_45)*100)
        #     current_past_85 = period_15_days_past_85[findall(x->x==i, day_range_past_85)]
        #     current_future_85 = period_15_days_future_85[findall(x->x==i, day_range_future_85)]
        #     append!(mean_per_15_days_past_85, mean(current_past_85)*100)
        #     append!(mean_per_15_days_future_85, mean(current_future_85)*100)
        #     append!(std_per_15_days_past_85, std(current_past_85)*100)
        #     append!(std_per_15_days_future_85, std(current_future_85)*100)
        #
        #     current_past_45_pf = period_15_days_past_45_pf[findall(x->x==i, day_range_past_45_pf)]
        #     current_future_45_pf = period_15_days_future_45_pf[findall(x->x==i, day_range_future_45_pf)]
        #     append!(mean_per_15_days_past_45_pf, mean(current_past_45_pf)*100)
        #     append!(mean_per_15_days_future_45_pf, mean(current_future_45_pf)*100)
        #     append!(std_per_15_days_past_45_pf, std(current_past_45_pf)*100)
        #     append!(std_per_15_days_future_45_pf, std(current_future_45_pf)*100)
        #     current_past_85_pf = period_15_days_past_85_pf[findall(x->x==i, day_range_past_85_pf)]
        #     current_future_85_pf = period_15_days_future_85_pf[findall(x->x==i, day_range_future_85_pf)]
        #     append!(mean_per_15_days_past_85_pf, mean(current_past_85_pf)*100)
        #     append!(mean_per_15_days_future_85_pf, mean(current_future_85_pf)*100)
        #     append!(std_per_15_days_past_85_pf, std(current_past_85_pf)*100)
        #     append!(std_per_15_days_future_85_pf, std(current_future_85_pf)*100)
        #
        # end
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_std2.txt", ',')
        std_per_15_days_past_45 = max_discharge_prob_45[:,1]
        std_per_15_days_future_45 = max_discharge_prob_45[:,2]
        std_per_15_days_past_85= max_discharge_prob_45[:,3]
        std_per_15_days_future_85= max_discharge_prob_45[:,4]
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_mean2.txt", ',')
        mean_per_15_days_past_45 = max_discharge_prob_45[:,1]
        mean_per_15_days_future_45 = max_discharge_prob_45[:,2]
        mean_per_15_days_past_85= max_discharge_prob_45[:,3]
        mean_per_15_days_future_85= max_discharge_prob_45[:,4]
        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_std2.txt", ',')
        std_per_15_days_past_45_pf = max_discharge_prob_45_pf[:,1]
        std_per_15_days_future_45_pf = max_discharge_prob_45_pf[:,2]
        std_per_15_days_past_85_pf= max_discharge_prob_45_pf[:,3]
        std_per_15_days_future_85_pf= max_discharge_prob_45_pf[:,4]
        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_mean2.txt", ',')
        mean_per_15_days_past_45_pf = max_discharge_prob_45_pf[:,1]
        mean_per_15_days_future_45_pf = max_discharge_prob_45_pf[:,2]
        mean_per_15_days_past_85_pf= max_discharge_prob_45_pf[:,3]
        mean_per_15_days_future_85_pf= max_discharge_prob_45_pf[:,4]
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_std2.txt", hcat(std_per_15_days_past_45, std_per_15_days_future_45, std_per_15_days_past_85,std_per_15_days_future_85),',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_mean2.txt", hcat(mean_per_15_days_past_45, mean_per_15_days_future_45, mean_per_15_days_past_85,mean_per_15_days_future_85),',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_std_pf2.txt", hcat(std_per_15_days_past_45_pf, std_per_15_days_future_45_pf, std_per_15_days_past_85_pf,std_per_15_days_future_85_pf),',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_timing_mean_pf2.txt", hcat(mean_per_15_days_past_45_pf, mean_per_15_days_future_45_pf, mean_per_15_days_past_85_pf,mean_per_15_days_future_85_pf),',')
        xaxix_days = collect(7.5:15:370)
        labels =["Past", "RCP 4.5 Sr,clim,stat", "RCP 4.5 Sr,clim,adapt", "RCP 8.5 Sr,clim,stat", "RCP 8.5 Sr,clim,adapt"]
        if errorbounds == true
            Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2,  size=(1500,800), linestyle=:solid, color=["gray27"], linewidth=3, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3, label=false)
            # Plots.plot!(mean_per_15_days_past_85, leg=false, size=(1500,800), linestyle = :solid, color=["gray27"], linewidth=3)
            # scatter!(mean_per_15_days_past_85, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), linestyle = :solid,color=[Farben_85[2]], linewidth=3, ribbon=std_per_15_days_future_85, fillalpha=.3, label=false)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), linestyle = :solid,color=[Farben_85[1]], linewidth=3, ribbon=std_per_15_days_future_85_pf, fillalpha=.3, label=false)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), linestyle = :solid,color=[Farben_45[2]], linewidth=3, ribbon=std_per_15_days_future_45, fillalpha=.3, label=false)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), linestyle = :solid,color=[Farben_45[1]], linewidth=3, ribbon=std_per_15_days_future_45_pf, fillalpha=.3, label=false)

            plot!(xaxix_days, mean_per_15_days_future_85, size=(1500,800), color=[Farben_85[2]], linestyle=:solid,marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            plot!(xaxix_days, mean_per_15_days_future_85_pf, size=(1500,800), color=[Farben_85[1]],linestyle=:solid, marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)

            plot!(xaxix_days, mean_per_15_days_future_45, size=(1500,800), color=[Farben_45[2]], linestyle=:solid,marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            # plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=8, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
            plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, size=(1500,800), linestyle=:solid,color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, linestyle=:solid, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)

            if j==6
                scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[1])
                scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[2], legend=true)
                scatter!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[3])
                scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[4])
                scatter!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[5])
                # scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=8, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)

                scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false, legend=true)
            end
        elseif errorbounds == false
            Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2,  size=(1500,800), linestyle = :solid, color=["gray27"], linewidth=3)#, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3, label=false)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), linestyle = :solid,color=[Farben_85[2]], linewidth=3)#, ribbon=std_per_15_days_future_85, fillalpha=.3, label=false)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), linestyle = :solid,color=[Farben_85[1]], linewidth=3)#, ribbon=std_per_15_days_future_85_pf, fillalpha=.3, label=false)

            Plots.plot!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), linestyle = :solid,color=[Farben_45[2]], linewidth=3)#, ribbon=std_per_15_days_future_45, fillalpha=.3, label=false)
            # Plots.plot!(mean_per_15_days_past_85, leg=false, size=(1500,800), linestyle = :solid, color=["gray27"], linewidth=3)
            # scatter!(mean_per_15_days_past_85, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), linestyle = :solid,color=[Farben_45[1]], linewidth=3)#, ribbon=std_per_15_days_future_45_pf, fillalpha=.3, label=false)
            # Plots.plot!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), linestyle = :solid, color=["gray27"], linewidth=3)
            # scatter!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)

            plot!(xaxix_days, mean_per_15_days_future_85, size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            plot!(xaxix_days, mean_per_15_days_future_45, size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            # plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=8, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)

            plot!(xaxix_days, mean_per_15_days_future_85_pf, size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
            plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)

            if j==6
                scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[1])
                scatter!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[3])
                scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[2], legend=true)
                scatter!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[5])

                scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[4])
                # scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=8, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)

                scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["gray27"], linewidth=3,markercolor=["gray27"], marker=:circle, markersize=7, markerstrokecolor=["gray27"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false, legend=true)
            end
        end
        #ylabel!("[%]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        ylims!((0,50))
        yticks!([0:10:50;])
        xticks!([15, 45, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        xlims!((1,370))
        if j==3
            ylabel!("Fraction of Occurance of Minimum Flows in 30 years [%]")
        end
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [20mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(20), ytickfont = font(20),  framestyle = :box, grid=false, xrotation=0)
        push!(all_boxplots, box)
    end

    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legendfontsize= 20, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px,yguidefontsize=20, xtickfont = font(20),
            ytickfont = font(20), dpi=300)#,minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    # plot()
    if errorbounds == true
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/low_flows_timing_all_catchments_4585_with_std.png")
    else
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/low_flows_timing_all_catchments_4585.png")
    end
end
# plot_timing_changes_low_flows_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)

# function plot_timing_changes_high_flows_all_Catchments_fraction_4585(All_Catchment_Names, Elevation, nr_runs_new, errorbounds)
#     all_boxplots = []
#     Plots.plot()
#     for (j,Catchment_Name) in enumerate(All_Catchment_Names)
#         Farben_45= palette(:reds)
#
#         Farben_85= palette(:blues)
#
#         println(Catchment_Name)
#         max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
#         max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
#         max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
#         max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
#         #
#         Date_Past_45 = max_discharge_prob_45[:,4]
#         Date_Future_45 = max_discharge_prob_45[:,5]
#         Date_Past_85 = max_discharge_prob_85[:,4]
#         Date_Future_85 = max_discharge_prob_85[:,5]
#         Date_Past_45_pf = max_discharge_prob_45_pf[:,4]
#         Date_Future_45_pf = max_discharge_prob_45_pf[:,5]
#         Date_Past_85_pf = max_discharge_prob_85_pf[:,4]
#         Date_Future_85_pf = max_discharge_prob_85_pf[:,5]
#         #
#         # # nr_runs = Int(round((size(Date_Past_85)[1]-100)/14/29))
#         # # println()
#         # # println(nr_runs)
#         period_15_days_past_45, day_range_past_45 = get_distributed_dates(Date_Past_45, 15, nr_runs[j], 30)
#         period_15_days_future_45, day_range_future_45 = get_distributed_dates(Date_Future_45, 15, nr_runs[j], 30)
#         period_15_days_past_85, day_range_past_85 = get_distributed_dates(Date_Past_85, 15, nr_runs[j], 30)
#         period_15_days_future_85, day_range_future_85 = get_distributed_dates(Date_Future_85, 15, nr_runs[j], 30)
#         period_15_days_past_45_pf, day_range_past_45_pf = get_distributed_dates(Date_Past_45_pf, 15, nr_runs[j], 30)
#         period_15_days_future_45_pf, day_range_future_45_pf = get_distributed_dates(Date_Future_45_pf, 15, nr_runs[j], 30)
#         period_15_days_past_85_pf, day_range_past_85_pf = get_distributed_dates(Date_Past_85_pf, 15, nr_runs[j], 30)
#         period_15_days_future_85_pf, day_range_future_85_pf = get_distributed_dates(Date_Future_85_pf, 15, nr_runs[j], 30)
#         #
#         Plots.plot()
#         # # #print(size(period_15_days_future))
#         mean_per_15_days_past_45 = Float64[]
#         mean_per_15_days_future_45 = Float64[]
#         mean_per_15_days_past_85 = Float64[]
#         mean_per_15_days_future_85 = Float64[]
#         std_per_15_days_past_45 = Float64[]
#         std_per_15_days_future_45 = Float64[]
#         std_per_15_days_past_85 = Float64[]
#         std_per_15_days_future_85 = Float64[]
#         mean_per_15_days_past_45_pf = Float64[]
#         mean_per_15_days_future_45_pf = Float64[]
#         mean_per_15_days_past_85_pf = Float64[]
#         mean_per_15_days_future_85_pf = Float64[]
#         std_per_15_days_past_45_pf = Float64[]
#         std_per_15_days_future_45_pf = Float64[]
#         std_per_15_days_past_85_pf = Float64[]
#         std_per_15_days_future_85_pf = Float64[]
#
#         for i in collect(0:15:366)
#             current_past_45 = period_15_days_past_45[findall(x->x==i, day_range_past_45)]
#             current_future_45 = period_15_days_future_45[findall(x->x==i, day_range_future_45)]
#             append!(mean_per_15_days_past_45, mean(current_past_45)*100)
#             append!(mean_per_15_days_future_45, mean(current_future_45)*100)
#             append!(std_per_15_days_past_45, std(current_past_45)*100)
#             append!(std_per_15_days_future_45, std(current_future_45)*100)
#             current_past_85 = period_15_days_past_85[findall(x->x==i, day_range_past_85)]
#             current_future_85 = period_15_days_future_85[findall(x->x==i, day_range_future_85)]
#             append!(mean_per_15_days_past_85, mean(current_past_85)*100)
#             append!(mean_per_15_days_future_85, mean(current_future_85)*100)
#             append!(std_per_15_days_past_85, std(current_past_85)*100)
#             append!(std_per_15_days_future_85, std(current_future_85)*100)
#
#             current_past_45_pf = period_15_days_past_45_pf[findall(x->x==i, day_range_past_45_pf)]
#             current_future_45_pf = period_15_days_future_45_pf[findall(x->x==i, day_range_future_45_pf)]
#             append!(mean_per_15_days_past_45_pf, mean(current_past_45_pf)*100)
#             append!(mean_per_15_days_future_45_pf, mean(current_future_45_pf)*100)
#             append!(std_per_15_days_past_45_pf, std(current_past_45_pf)*100)
#             append!(std_per_15_days_future_45_pf, std(current_future_45_pf)*100)
#             current_past_85_pf = period_15_days_past_85_pf[findall(x->x==i, day_range_past_85_pf)]
#             current_future_85_pf = period_15_days_future_85_pf[findall(x->x==i, day_range_future_85_pf)]
#             append!(mean_per_15_days_past_85_pf, mean(current_past_85_pf)*100)
#             append!(mean_per_15_days_future_85_pf, mean(current_future_85_pf)*100)
#             append!(std_per_15_days_past_85_pf, std(current_past_85_pf)*100)
#             append!(std_per_15_days_future_85_pf, std(current_future_85_pf)*100)
#
#         end
#         # max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_std2.txt", ',')
#         # std_per_15_days_past_45 = max_discharge_prob_45[:,1]
#         # std_per_15_days_future_45 = max_discharge_prob_45[:,2]
#         # std_per_15_days_past_85= max_discharge_prob_45[:,3]
#         # std_per_15_days_future_85= max_discharge_prob_45[:,4]
#         # max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_mean2.txt", ',')
#         # mean_per_15_days_past_45 = max_discharge_prob_45[:,1]
#         # mean_per_15_days_future_45 = max_discharge_prob_45[:,2]
#         # mean_per_15_days_past_85= max_discharge_prob_45[:,3]
#         # mean_per_15_days_future_85= max_discharge_prob_45[:,4]
#         # max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_std_pf2.txt", ',')
#         # std_per_15_days_past_45_pf = max_discharge_prob_45_pf[:,1]
#         # std_per_15_days_future_45_pf = max_discharge_prob_45_pf[:,2]
#         # std_per_15_days_past_85_pf= max_discharge_prob_45_pf[:,3]
#         # std_per_15_days_future_85_pf= max_discharge_prob_45_pf[:,4]
#         # max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_mean_pf2.txt", ',')
#         # mean_per_15_days_past_45_pf = max_discharge_prob_45_pf[:,1]
#         # mean_per_15_days_future_45_pf = max_discharge_prob_45_pf[:,2]
#         # mean_per_15_days_past_85_pf = max_discharge_prob_45_pf[:,3]
#         # mean_per_15_days_future_85_pf = max_discharge_prob_45_pf[:,4]
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_std3.txt", hcat(std_per_15_days_past_45, std_per_15_days_future_45, std_per_15_days_past_85,std_per_15_days_future_85),',')
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_mean3.txt", hcat(mean_per_15_days_past_45, mean_per_15_days_future_45, mean_per_15_days_past_85,mean_per_15_days_future_85),',')
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_std_pf3.txt", hcat(std_per_15_days_past_45_pf, std_per_15_days_future_45_pf, std_per_15_days_past_85_pf,std_per_15_days_future_85_pf),',')
#         writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/AMF_timing_mean_pf3.txt", hcat(mean_per_15_days_past_45_pf, mean_per_15_days_future_45_pf, mean_per_15_days_past_85_pf,mean_per_15_days_future_85_pf),',')
#         xaxix_days = collect(7.5:15:370)
#         labels =["Past", "RCP4.5 Sr,clim,stat", "RCP4.5 Sr,clim,adapt", "RCP8.5 Sr,clim,stat", "RCP8.5 Sr,clim,adapt"]
#         if errorbounds == true
#             Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2,  size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3, label=false)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), linestyle = :solid,color=[Farben_45[2]], linewidth=3, ribbon=std_per_15_days_future_45, fillalpha=.3, label=false)
#             # Plots.plot!(mean_per_15_days_past_85, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3)
#             # scatter!(mean_per_15_days_past_85, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), linestyle = :solid,color=[Farben_85[2]], linewidth=3, ribbon=std_per_15_days_future_85, fillalpha=.3, label=false)
#
#             # Plots.plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3, ribbon = (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2, fillalpha=.3)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), linestyle = :solid,color=[Farben_45[1]], linewidth=3, ribbon=std_per_15_days_future_45_pf, fillalpha=.3, label=false)
#             # Plots.plot!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3)
#             # scatter!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), linestyle = :solid,color=[Farben_85[1]], linewidth=3, ribbon=std_per_15_days_future_85_pf, fillalpha=.3, label=false)
#
#             plot!(xaxix_days, mean_per_15_days_future_85, size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, mean_per_15_days_future_45, size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             # plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=8, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#
#             plot!(xaxix_days, mean_per_15_days_future_85, size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#
#             if j==6
#                 scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[1])
#                 scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[2], legend=true)
#                 scatter!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[3])
#                 scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[4])
#                 scatter!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[5])
#                 # scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=8, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#
#                 scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#                 scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#                 scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false, legend=true)
#             end
#         elseif errorbounds == false
#             Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2,  size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3)#, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3, label=false)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), linestyle = :solid,color=[Farben_45[2]], linewidth=3)#, ribbon=std_per_15_days_future_45, fillalpha=.3, label=false)
#             # Plots.plot!(mean_per_15_days_past_85, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3)
#             # scatter!(mean_per_15_days_past_85, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), linestyle = :solid,color=[Farben_85[2]], linewidth=3)#, ribbon=std_per_15_days_future_85, fillalpha=.3, label=false)
#
#             # Plots.plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3, ribbon = (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2, fillalpha=.3)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), linestyle = :solid,color=[Farben_45[1]], linewidth=3)#, ribbon=std_per_15_days_future_45_pf, fillalpha=.3, label=false)
#             # Plots.plot!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), linestyle = :solid, color=["grey"], linewidth=3)
#             # scatter!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#             Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), linestyle = :solid,color=[Farben_85[1]], linewidth=3)#, ribbon=std_per_15_days_future_85_pf, fillalpha=.3, label=false)
#
#             plot!(xaxix_days, mean_per_15_days_future_85, size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, mean_per_15_days_future_45, size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=5,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             # plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=8, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#
#             plot!(xaxix_days, mean_per_15_days_future_85_pf, size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#             plot!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#
#             if j==6
#                 scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[1])
#                 scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[2], legend=true)
#                 scatter!(xaxix_days, mean_per_15_days_future_45,  size=(1500,800), color=[Farben_45[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_45[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[3])
#                 scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[4])
#                 scatter!(xaxix_days, mean_per_15_days_future_85,  size=(1500,800), color=[Farben_85[2]], marker=:circle, markersize=9, linewidth=3,markerstrokecolor=[Farben_85[2]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[5])
#                 # scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=8, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60)
#
#                 scatter!(xaxix_days, mean_per_15_days_future_85_pf,  size=(1500,800), color=[Farben_85[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_85[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#                 scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2,  size=(1500,800), color=["grey"], linewidth=3,markercolor=["grey"], marker=:circle, markersize=7, markerstrokecolor=["grey"],left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
#                 scatter!(xaxix_days, mean_per_15_days_future_45_pf,  size=(1500,800), color=[Farben_45[1]], marker=:circle, markersize=7, linewidth=3,markerstrokecolor=[Farben_45[1]], left_margin = [20mm 0mm], bottom_margin = 20px, xrotation = 60, label=false, legend=true)
#             end
#         end
#         #ylabel!("[%]", yguidefontsize=12)
#         #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
#         if Catchment_Name == "Feistritz"
#             title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
#         elseif Catchment_Name == "IllSugadin"
#             title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
#         elseif Catchment_Name == "Palten"
#             title!("Paltental ("*string(Elevation[j])*"m)", titlefont = font(20))
#         else
#             title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
#         end
#         #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
#         ylims!((0,50))
#         yticks!([0:10:50;])
#         xticks!([15, 45, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
#         xlims!((1,370))
#         if j==3
#             ylabel!("Fraction of Occurance of Annual Maximum Flows in 30 years [%]")
#         end
#         #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
#         box = Plots.plot!(left_margin = [20mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), framestyle = :box)
#         push!(all_boxplots, box)
#     end
#
#     Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legendfontsize= 16, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px,yguidefontsize=20, xtickfont = font(20),
#             ytickfont = font(20), dpi=300)#,minorticks=true, minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
#     # plot()
#     if errorbounds == true
#         Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_flows_timing_all_catchments_4585_with_std_2.png")
#     else
#         Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_flows_timing_all_catchments_4585_2.png")
#     end
# end
# plot_timing_changes_high_flows_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)

"""
Plots the distribution of timing of annual maximum discharges all in one plot

$(SIGNATURES)

"""
function plot_timing_changes_AMF_all_Catchments_fraction_4585(All_Catchment_Names, Elevation, nr_runs, errorbounds)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    Plots.plot()
    mean_per_15days_past = zeros(25)
    mean_per_15days_future_45 = zeros(25)
    mean_per_15days_future_85 = zeros(25)
    mean_per_15days_past_pf = zeros(25)
    mean_per_15days_future_45_pf = zeros(25)
    mean_per_15days_future_85_pf = zeros(25)
    std_per_15days_past = zeros(25)
    std_per_15days_future_45 = zeros(25)
    std_per_15days_future_85 = zeros(25)
    std_per_15days_past_pf = zeros(25)
    std_per_15days_future_45_pf = zeros(25)
    std_per_15days_future_85_pf = zeros(25)


    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
        max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
        println(Catchment_Name)
        println(size(max_discharge_prob_45), size(max_discharge_prob_85), size(max_discharge_prob_45_pf), size(max_discharge_prob_85_pf))
        Date_Past_45 = max_discharge_prob_45[:,4]
        Date_Future_45 = max_discharge_prob_45[:,5]
        Date_Past_85 = max_discharge_prob_85[:,4]
        Date_Future_85 = max_discharge_prob_85[:,5]
        period_15_days_past_45, day_range_past_45 = get_distributed_dates(Date_Past_45, 15, nr_runs[j], 30)
        period_15_days_future_45, day_range_future_45 = get_distributed_dates(Date_Future_45, 15, nr_runs[j], 30)
        period_15_days_past_85, day_range_past_85 = get_distributed_dates(Date_Past_85, 15, nr_runs[j], 30)
        period_15_days_future_85, day_range_future_85 = get_distributed_dates(Date_Future_85, 15, nr_runs[j], 30)
        Date_Past_45_pf = max_discharge_prob_45_pf[:,4]
        Date_Future_45_pf = max_discharge_prob_45_pf[:,5]
        Date_Past_85_pf = max_discharge_prob_85_pf[:,4]
        Date_Future_85_pf = max_discharge_prob_85_pf[:,5]
        period_15_days_past_45_pf, day_range_past_45_pf = get_distributed_dates(Date_Past_45_pf, 15, nr_runs[j], 30)
        period_15_days_future_45_pf, day_range_future_45_pf = get_distributed_dates(Date_Future_45_pf, 15, nr_runs[j], 30)
        period_15_days_past_85_pf, day_range_past_85_pf = get_distributed_dates(Date_Past_85_pf, 15, nr_runs[j], 30)
        period_15_days_future_85_pf, day_range_future_85_pf = get_distributed_dates(Date_Future_85_pf, 15, nr_runs[j], 30)

        Plots.plot()
        #print(size(period_15_days_future))
        mean_per_15_days_past_45 = Float64[]
        mean_per_15_days_future_45 = Float64[]
        mean_per_15_days_past_85 = Float64[]
        mean_per_15_days_future_85 = Float64[]
        std_per_15_days_past_45 = Float64[]
        std_per_15_days_future_45 = Float64[]
        std_per_15_days_past_85 = Float64[]
        std_per_15_days_future_85 = Float64[]

        mean_per_15_days_past_45_pf = Float64[]
        mean_per_15_days_future_45_pf = Float64[]
        mean_per_15_days_past_85_pf = Float64[]
        mean_per_15_days_future_85_pf = Float64[]
        std_per_15_days_past_45_pf = Float64[]
        std_per_15_days_future_45_pf = Float64[]
        std_per_15_days_past_85_pf = Float64[]
        std_per_15_days_future_85_pf = Float64[]

        for i in collect(0:15:366)
            current_past_45 = period_15_days_past_45[findall(x->x==i, day_range_past_45)]
            current_future_45 = period_15_days_future_45[findall(x->x==i, day_range_future_45)]
            append!(mean_per_15_days_past_45, mean(current_past_45)*100)
            append!(mean_per_15_days_future_45, mean(current_future_45)*100)
            append!(std_per_15_days_past_45, std(current_past_45)*100)
            append!(std_per_15_days_future_45, std(current_future_45)*100)
            current_past_85 = period_15_days_past_85[findall(x->x==i, day_range_past_85)]
            current_future_85 = period_15_days_future_85[findall(x->x==i, day_range_future_85)]
            append!(mean_per_15_days_past_85, mean(current_past_85)*100)
            append!(mean_per_15_days_future_85, mean(current_future_85)*100)
            append!(std_per_15_days_past_85, std(current_past_85)*100)
            append!(std_per_15_days_future_85, std(current_future_85)*100)
            current_past_45_pf = period_15_days_past_45_pf[findall(x->x==i, day_range_past_45_pf)]
            current_future_45_pf = period_15_days_future_45_pf[findall(x->x==i, day_range_future_45_pf)]
            append!(mean_per_15_days_past_45_pf, mean(current_past_45_pf)*100)
            append!(mean_per_15_days_future_45_pf, mean(current_future_45_pf)*100)
            append!(std_per_15_days_past_45_pf, std(current_past_45_pf)*100)
            append!(std_per_15_days_future_45_pf, std(current_future_45_pf)*100)
            current_past_85_pf = period_15_days_past_85_pf[findall(x->x==i, day_range_past_85_pf)]
            current_future_85_pf = period_15_days_future_85_pf[findall(x->x==i, day_range_future_85_pf)]
            append!(mean_per_15_days_past_85_pf, mean(current_past_85_pf)*100)
            append!(mean_per_15_days_future_85_pf, mean(current_future_85_pf)*100)
            append!(std_per_15_days_past_85_pf, std(current_past_85_pf)*100)
            append!(std_per_15_days_future_85_pf, std(current_future_85_pf)*100)

        end
        #print(size(mean_per_15_days_past))
        xaxix_days = collect(7.5:15:370)
        labels=["Past", "Past", "RCP 4.5 Sr,clim,stat", "RCP 4.5 Sr,clim,adapt", "RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"]

        if errorbounds == true
            Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["gray27"], linewidth=3, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.2,  label=:none)
            # Plots.plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["gray27"], linewidth=3, ribbon = (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2, fillalpha=.2,  label=:none)

            Plots.plot!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[2]], linewidth=3, ribbon=std_per_15_days_future_85, fillalpha=.2,  label=:none)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[1]], linewidth=3, ribbon=std_per_15_days_future_85_pf, fillalpha=.2,  label=:none)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[2]], linewidth=3, ribbon=std_per_15_days_future_45, fillalpha=.2,  label=:none)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[1]], linewidth=3, ribbon=std_per_15_days_future_45_pf, fillalpha=.2,  label=:none)
            if j==1
                scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[1])
                # scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[2])

                scatter!(xaxix_days, mean_per_15_days_future_45_pf, leg=false, size=(1500,800), color=[Farben_45[1]], markersize=7, markerstrokecolor=[Farben_45[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[3])
                scatter!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), color=[Farben_45[2]], markersize=8, markerstrokecolor=[Farben_45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[4])
                scatter!(xaxix_days, mean_per_15_days_future_85_pf, leg=false, size=(1500,800), color=[Farben_85[1]], markersize=7, markerstrokecolor=[Farben_85[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[5])
                scatter!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), color=[Farben_85[2]], markersize=8, markerstrokecolor=[Farben_85[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=labels[6])



            else
                scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                # scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)

                scatter!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), color=[Farben_85[2]], markersize=8, markerstrokecolor=[Farben_85[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, mean_per_15_days_future_85_pf, leg=false, size=(1500,800), color=[Farben_85[1]], markersize=7, markerstrokecolor=[Farben_85[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), color=[Farben_45[2]], markersize=8, markerstrokecolor=[Farben_45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)
                scatter!(xaxix_days, mean_per_15_days_future_45_pf, leg=false, size=(1500,800), color=[Farben_45[1]], markersize=7, markerstrokecolor=[Farben_45[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label=false)

            end

        elseif errorbounds == false
            # Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["gray27"], linewidth=3, label=:none)#, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3)
            # scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), markercolor=["gray27"], markersize=7, markerstrokecolor=["gray27"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            # Plots.plot!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[2]], linewidth=3,  label=:none)#, ribbon=std_per_15_days_future_45, fillalpha=.3)
            # scatter!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), color=[Farben_45[2]], markersize=7, markerstrokecolor=[Farben_45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            # Plots.plot!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[2]], linewidth=3,  label=:none)#, ribbon=std_per_15_days_future_85, fillalpha=.3)
            # scatter!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), color=[Farben_85[2]], markersize=7, markerstrokecolor=[Farben_85[2]])#, left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        end
        if j==3
            ylabel!("Fraction of Occurance of AMF in 30 years [%]", yguidefontsize=12)
        end
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Palten ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        ylims!((0,41))
        # if j in [1,3,5]
        yticks!([0:5:40;])
        # else
        #     yticks!([0:5:40;], ["","","","","","","","",""])
        # end
        # if j in [5,6]
        xticks!([15, 45, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349], ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])
        # else
        #     xticks!([15, 45, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349], ["", "", "", "", "","", "", "", "", "", "", ""])
        # end
        xlims!((1,370))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12),  framestyle = :box)
        push!(all_boxplots, box)

        mean_per_15days_past = hcat(mean_per_15days_past, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2)
        mean_per_15days_future_45 = hcat(mean_per_15days_future_45, mean_per_15_days_future_45)
        mean_per_15days_future_85 = hcat(mean_per_15days_future_85, mean_per_15_days_future_85)
        mean_per_15days_past_pf = hcat(mean_per_15days_past_pf, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2)
        mean_per_15days_future_45_pf = hcat(mean_per_15days_future_45_pf, mean_per_15_days_future_45_pf)
        mean_per_15days_future_85_pf = hcat(mean_per_15days_future_85_pf, mean_per_15_days_future_85_pf)
        std_per_15days_past = hcat(std_per_15days_past, (std_per_15_days_past_45+std_per_15_days_past_85) / 2)
        std_per_15days_future_45 = hcat(std_per_15days_future_45, std_per_15_days_future_45)
        std_per_15days_future_85 = hcat(std_per_15days_future_85, std_per_15_days_future_85)
        std_per_15days_past_pf = hcat(std_per_15days_past_pf, (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2)
        std_per_15days_future_45_pf = hcat(std_per_15days_future_45_pf, std_per_15_days_future_45_pf)
        std_per_15days_future_85_pf = hcat(std_per_15days_future_85_pf, std_per_15_days_future_85_pf)


    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=true, legendfontsize= 12, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px,
    yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, legendfont = font(20), grid=false, xrotation=0)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    # if errorbounds == true
    #     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_with_std_legend.png")
    # else
    #     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_without_std_past.png")
    # end
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_timing_mean_plot.png")
    println(size(mean_per_15days_past))
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_mean_past_tot.csv", mean_per_15days_past[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_mean_future_45_tot.csv", mean_per_15days_future_45[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_mean_future_85_tot.csv", mean_per_15days_future_85[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_mean_past_tot.csv", mean_per_15days_past_pf[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_mean_future_45_tot.csv", mean_per_15days_future_45_pf[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_mean_future_85_tot.csv", mean_per_15days_future_85_pf[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_std_past_tot.csv", std_per_15days_past[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_std_future_45_tot.csv", std_per_15days_future_45[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/NS_AMF_timing_std_future_85_tot.csv", std_per_15days_future_85[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_std_past_tot.csv", std_per_15days_past_pf[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_std_future_45_tot.csv", std_per_15days_future_45_pf[:,2:end])
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/PforF_AMF_timing_std_future_85_tot.csv", std_per_15days_future_85_pf[:,2:end])


end

# plot_timing_changes_AMF_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)

#------ Unused functions

function plot_changes_monthly_discharge_all_catchments(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_85 = palette(:reds)
    Farben_45 = palette(:blues)
    all_boxplots = []
    all_info = zeros(12)


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = convertDischarge(monthly_changes_85[:,2], Area_Catchments[i])
        Monthly_Discharge_future_85  = convertDischarge(monthly_changes_85[:,3], Area_Catchments[i])
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = convertDischarge(monthly_changes_45[:,2], Area_Catchments[i])
        Monthly_Discharge_future_45  = convertDischarge(monthly_changes_45[:,3], Area_Catchments[i])
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past = (Monthly_Discharge_past_45 + Monthly_Discharge_past_85) .* 0.5
        change_45 = Monthly_Discharge_future_45 - Monthly_Discharge_past_45
        change_85 = Monthly_Discharge_future_85 - Monthly_Discharge_past_85

        box = []
        mean_Monthly_Discharge_Past = Float64[]
        mean_Monthly_Discharge_Future_45 = Float64[]
        mean_Monthly_Discharge_Future_85 = Float64[]
        days_month = [31,28.25, 31,30,31,30,31,31,30,31,30,31]
        for month in 1:12
            # append!(mean_Monthly_Discharge_Past, mean(Monthly_Discharge_past[findall(x-> x == month, months_45)])*days_month[month])
            # append!(mean_Monthly_Discharge_Future_45, mean(Monthly_Discharge_future_45[findall(x-> x == month, months_45)])*days_month[month])
            # append!(mean_Monthly_Discharge_Future_85, mean(Monthly_Discharge_future_85[findall(x-> x == month, months_45)])*days_month[month])
            append!(mean_Monthly_Discharge_Future_45, mean(Monthly_Discharge_future_45[findall(x-> x == month, months_45)] - Monthly_Discharge_past_45[findall(x-> x == month, months_45)])*days_month[month])
            append!(mean_Monthly_Discharge_Future_85, mean(Monthly_Discharge_future_85[findall(x-> x == month, months_45)] - Monthly_Discharge_past_85[findall(x-> x == month, months_45)])*days_month[month])

        end


        Plots.plot()
        box = []
        for month in 1:12
            boxplot!([xaxis_45[month]],relative_error(Monthly_Discharge_future_45[findall(x-> x == month, months_45)], Monthly_Discharge_past_45[findall(x-> x == month, months_45)])*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            boxplot!([xaxis_85[month]],relative_error(Monthly_Discharge_future_85[findall(x-> x == month, months_45)], Monthly_Discharge_past_85[findall(x-> x == month, months_45)])*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        end
        ylabel!("[%]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))
        if Catchment_Name == Catchment_Name == "Pitztal"# || "Defreggental"
            ylims!((-100,850))
            yticks!([-100:100:750;])
        elseif Catchment_Name == "Pitten" || Catchment_Name == "Palten"
            ylims!((-100,100))
            yticks!([-100:50:100;])
        else
            ylims!((-100,275))
            yticks!([-100:50:275;])
        end
        hline!([0], color=["grey"], linestyle = :dash)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
        # all_info = hcat(all_info, round.(mean_Monthly_Discharge_Past, digits=1))
        all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_45, digits=1))
        all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_85, digits=1))

    end
    println(size(all_info))
    # Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_discharges_all_catchments_different_scales.png")
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/mean_change_monthly_discharges_new.csv", all_info)
end
# plot_changes_monthly_discharge_all_catchments_absolute(Catchment_Names_new, Catchment_Height, Area_Catchments)


function plot_changes_monthly_discharge_all_catchments_absolute_boxplot(All_Catchment_Names, Elevation, Area_Catchments)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp85_NS.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_rcp45_NS.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past_45 = convertDischarge(Monthly_Discharge_past_45, Area_Catchments[i])
        Monthly_Discharge_past_85 = convertDischarge(Monthly_Discharge_past_85, Area_Catchments[i])
        Monthly_Discharge_future_45 = convertDischarge(Monthly_Discharge_future_45, Area_Catchments[i])
        Monthly_Discharge_future_85 = convertDischarge(Monthly_Discharge_future_85, Area_Catchments[i])
        Plots.plot()
        box = []
        for month in 1:12
            boxplot!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)] - Monthly_Discharge_past_45[findall(x-> x == month, months_45)] , size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="RCP 4.5", outlier=false)
            boxplot!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_85)] - Monthly_Discharge_past_85[findall(x-> x == month, months_85)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
        end
        ylabel!("[mm/d]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)

        ylims!((-3.5,3.5))
        yticks!([-3:1:3;])

        hline!([0], color=["grey"], linestyle = :dash)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorgrid=true, gridlinewidth=4, minorgridlinewidth=2)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/monthly_discharges_all_catchments_absolute_change.png")
end
# plot_changes_monthly_GW_all_catchments_absolute(Catchment_Names_new, Catchment_Height, Area_Catchments)

# function plot_changes_monthly_temp_all_catchments(All_Catchment_Names, Elevation)
#     xaxis_45 = collect(1:2:23)
#     xaxis_85 = collect(2:2:24)
#     Sunhours_Vienna = [8.83, 10.26, 11.95, 13.75, 15.28, 16.11, 15.75, 14.36, 12.63, 10.9, 9.28, 8.43]
#     # ----------------- Plot Absolute Change ------------------
#     Plots.plot()
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#     all_boxplots_prec = []
#     all_boxplots_temp = []
#     all_info = zeros(12)
#     for (h,Catchment_Name) in enumerate(All_Catchment_Names)
#         Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
#         Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
#         #Timeseries_end = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt", ',')
#         path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
#         path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
#         Name_Projections_45 = readdir(path_45)
#         Name_Projections_85 = readdir(path_85)
#         # if path_to_projections[end-2:end-1] == "45"
#         #     index = 1
#         #     rcp = "45"
#         #     print(rcp, " ", path_to_projections)
#         # elseif path_to_projections[end-2:end-1] == "85"
#         #     index = 2
#         #     rcp="85"
#         #     print(rcp, " ", path_to_projections)
#         # end
#
#         all_months_all_runs = Float64[]
#         average_monthly_Precipitation_past45 = Float64[]
#         average_monthly_Precipitation_future45 = Float64[]
#         average_monthly_Precipitation_past85 = Float64[]
#         average_monthly_Precipitation_future85 = Float64[]
#         average_monthly_Temperature_past45 = Float64[]
#         average_monthly_Temperature_past85 = Float64[]
#         average_monthly_Temperature_future45 = Float64[]
#         average_monthly_Temperature_future85 = Float64[]
#         average_monthly_Epot_future85 = Float64[]
#         average_monthly_Epot_future45 = Float64[]
#         average_monthly_Epot_past85 = Float64[]
#         average_monthly_Epot_past45 = Float64[]
#
#         if Catchment_Name == "Gailtal"
#             ID_Prec_Zones = [113589, 113597, 113670, 114538]
#             # size of the area of precipitation zones
#             Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
#             Temp_Elevation = 1140.0
#             Mean_Elevation_Catchment = 1500
#             ID_temp = 113597
#             Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Palten"
#             ID_Prec_Zones = [106120, 111815, 9900]
#             Area_Zones = [198175943.0, 56544073.0, 115284451.3]
#             ID_temp = 106120
#             Temp_Elevation = 1265.0
#             Mean_Elevation_Catchment = 1300 # in reality 1314
#             Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Feistritz"
#             ID_Prec_Zones = [109967]
#             Area_Zones = [115496400.]
#             ID_temp = 10510
#             Mean_Elevation_Catchment = 900 # in reality 917
#             Temp_Elevation = 488.0
#             Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Defreggental"
#             ID_Prec_Zones = [17700, 114926]
#             Area_Zones = [235811198.0, 31497403.0]
#             ID_temp = 17700
#             Mean_Elevation_Catchment =  2300 # in reality 2233.399986
#             Temp_Elevation = 1385.
#             Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Silbertal"
#             ID_Prec_Zones = [100206]
#             Area_Zones = [100139168.]
#             ID_temp = 14200
#             Mean_Elevation_Catchment = 1700
#             Temp_Elevation = 670.
#             Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Pitztal"
#             ID_Prec_Zones = [102061, 102046]
#             Area_Zones = [20651736.0, 145191864.0]
#             ID_temp = 14620
#             Mean_Elevation_Catchment =  2500 # in reality 2233.399986
#             Temp_Elevation = 1410.
#             Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
#         end
#         Area_Catchment = sum(Area_Zones)
#         Area_Zones_Percent = Area_Zones / Area_Catchment
#         All_Precipitation_Past = zeros(10957)
#         All_Precipitation_Future = zeros(10957)
#         for (i, name) in enumerate(Name_Projections_45)
#             Timeseries_Future = collect(Date(Timeseries_End[i,1]-29,1,1):Day(1):Date(Timeseries_End[i,1],12,31))
#             #print(size(Timeseries_Past), size(Timeseries_Future))
#             Timeseries_Proj = readdlm(path_45*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
#             Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
#             Temperature = readdlm(path_45*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
#             Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
#             # get the temperature data at the mean elevation to calculate the mean potential evaporation
#             Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
#
#             indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
#             # get potential evaporation
#             Potential_Evaporation_Past = getEpot_Daily_thornthwaite(Temperature_Past, Timeseries_Past, Sunhours_Vienna)
#             #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
#             indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
#             Potential_Evaporation_Future = getEpot_Daily_thornthwaite(Temperature_Future, Timeseries_Future, Sunhours_Vienna)
#             # calculate monthly mean temperature
#             Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
#             Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
#             Monthly_Epot_Past, Month = monthly_precipitation(Potential_Evaporation_Past, Timeseries_Past)
#             Monthly_Epot_Future, Month_future = monthly_precipitation(Potential_Evaporation_Future, Timeseries_Future)
#             #-------- PRECIPITATION ------------------
#             Precipitation_All_Zones = Array{Float64, 1}[]
#             Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
#             for j in 1: length(ID_Prec_Zones)
#                     # get precipitation projections for the precipitation measurement
#                     Precipitation_Zone = readdlm(path_45*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
#                     #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
#                     push!(Precipitation_All_Zones, Precipitation_Zone ./10)
#                     Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
#             end
#             #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
#             # All_Precipitation_Past = hcat(All_Precipitation_Past, Total_Precipitation_Proj[indexstart_past:indexend_past])
#             # All_Precipitation_Future = hcat(All_Precipitation_Future, Total_Precipitation_Proj[indexstart_future:indexend_future])
#             Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
#             Precipitation_Future =  Total_Precipitation_Proj[indexstart_future:indexend_future]
#
#             Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
#             Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
#
#             # take average over all months in timeseries
#             for month in 1:12
#                 current_Month_Temperature = Monthly_Temperature_Past[findall(x->x == month, Month)]
#                 current_Month_Temperature_future = Monthly_Temperature_Future[findall(x->x == month, Month_future)]
#                 current_Month_Temperature = mean(current_Month_Temperature)
#                 current_Month_Temperature_future = mean(current_Month_Temperature_future)
#                 append!(average_monthly_Temperature_past45, current_Month_Temperature)
#                 append!(average_monthly_Temperature_future45, current_Month_Temperature_future)
#                 append!(average_monthly_Epot_past45, mean(Monthly_Epot_Past[findall(x->x == month, Month)]))
#                 append!(average_monthly_Epot_future45, mean(Monthly_Epot_Future[findall(x->x == month, Month)]))
#                 append!(all_months_all_runs, month)
#
#                 current_Month_Precipitation = Monthly_Precipitation_Past[findall(x->x == month, Month)]
#                 current_Month_Precipitation_future = Monthly_Precipitation_Future[findall(x->x == month, Month_future)]
#                 current_Month_Precipitation = mean(current_Month_Precipitation)
#                 current_Month_Precipitation_future = mean(current_Month_Precipitation_future)
#                 #error = relative_error(current_Month_Discharge_future, current_Month_Discharge)
#                 append!(average_monthly_Precipitation_past45, current_Month_Precipitation)
#                 append!(average_monthly_Precipitation_future45, current_Month_Precipitation_future)
#             end
#         end
#         # println(size(All_Precipitation_Past))
#         # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Inputs/prec_past_45.txt", All_Precipitation_Past[:, 2:end], ",")
#         # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Inputs/prec_future_45.txt", All_Precipitation_Future[:,2:end], ",")
#         # All_Precipitation_Past = zeros(10957)
#         # All_Precipitation_Future = zeros(10957)
#         for (i, name) in enumerate(Name_Projections_85)
#             Timeseries_Future = collect(Date(Timeseries_End[i,2]-29,1,1):Day(1):Date(Timeseries_End[i,2],12,31))
#             #print(size(Timeseries_Past), size(Timeseries_Future))
#             Timeseries_Proj = readdlm(path_85*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
#             Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
#             Temperature = readdlm(path_85*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
#             Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
#             # get the temperature data at the mean elevation to calculate the mean potential evaporation
#             Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
#
#             indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
#             #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
#             indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
#             # calculate monthly mean temperature
#             Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
#             Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
#
#             Potential_Evaporation_Past = getEpot_Daily_thornthwaite(Temperature_Past, Timeseries_Past, Sunhours_Vienna)
#             Potential_Evaporation_Future = getEpot_Daily_thornthwaite(Temperature_Future, Timeseries_Future, Sunhours_Vienna)
#             Monthly_Epot_Past, Month = monthly_precipitation(Potential_Evaporation_Past, Timeseries_Past)
#             Monthly_Epot_Future, Month_future = monthly_precipitation(Potential_Evaporation_Future, Timeseries_Future)
#
#             #-------- PRECIPITATION ------------------
#             Precipitation_All_Zones = Array{Float64, 1}[]
#             Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
#             for j in 1: length(ID_Prec_Zones)
#                     # get precipitation projections for the precipitation measurement
#                     Precipitation_Zone = readdlm(path_85*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
#                     #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
#                     push!(Precipitation_All_Zones, Precipitation_Zone ./10)
#                     Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
#             end
#             # #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
#             # All_Precipitation_Past = hcat(All_Precipitation_Past, Total_Precipitation_Proj[indexstart_past:indexend_past])
#             # All_Precipitation_Future = hcat(All_Precipitation_Future, Total_Precipitation_Proj[indexstart_future:indexend_future])
#
#             Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
#             Precipitation_Future =  Total_Precipitation_Proj[indexstart_future:indexend_future]
#
#             Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
#             Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
#             # statistics_all_Zones_Proj_Past = monthly_storm_statistics(Precipitation_Past, Timeseries_Past)
#             # statistics_all_Zones_Proj_Future = monthly_storm_statistics(Precipitation_Future, Timeseries_Future)
#             # take average over all months in timeseries
#             for month in 1:12
#                 current_Month_Temperature = Monthly_Temperature_Past[findall(x->x == month, Month)]
#                 current_Month_Temperature_future = Monthly_Temperature_Future[findall(x->x == month, Month_future)]
#                 current_Month_Temperature = mean(current_Month_Temperature)
#                 current_Month_Temperature_future = mean(current_Month_Temperature_future)
#                 append!(average_monthly_Temperature_past85, current_Month_Temperature)
#                 append!(average_monthly_Temperature_future85, current_Month_Temperature_future)
#                 append!(average_monthly_Epot_past85, mean(Monthly_Epot_Past[findall(x->x == month, Month)]))
#                 append!(average_monthly_Epot_future85, mean(Monthly_Epot_Future[findall(x->x == month, Month)]))
#                 #append!(all_months_all_runs, month)
#
#                 current_Month_Precipitation = Monthly_Precipitation_Past[findall(x->x == month, Month)]
#                 current_Month_Precipitation_future = Monthly_Precipitation_Future[findall(x->x == month, Month_future)]
#                 # cuurent_Month_Precipitation_Intensity = statistics_all_Zones_Proj_Past[findall(x->x == month, Month)]
#                 current_Month_Precipitation = mean(current_Month_Precipitation)
#                 current_Month_Precipitation_future = mean(current_Month_Precipitation_future)
#                 #error = relative_error(current_Month_Discharge_future, current_Month_Discharge)
#                 append!(average_monthly_Precipitation_past85, current_Month_Precipitation)
#                 append!(average_monthly_Precipitation_future85, current_Month_Precipitation_future)
#             end
#         end
#
#             # println(size(All_Precipitation_Past))
#             # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Inputs/prec_past_85.txt", All_Precipitation_Past[:, 2:end], ",")
#             # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Inputs/prec_future_85.txt", All_Precipitation_Future[:, 2:end], ",")
#         Plots.plot()
#         Monthly_Discharge_past = (average_monthly_Precipitation_past45 + average_monthly_Precipitation_past85) .* 0.5
#         # change_45 = average_monthly_Precipitation_future45 - average_monthly_Precipitation_past45
#         # change_85 = average_monthly_Precipitation_future85 - average_monthly_Precipitation_past85
#         change_45 = average_monthly_Epot_future45 - average_monthly_Epot_past45
#         change_85 = average_monthly_Epot_future85 - average_monthly_Epot_past85
#         mean_Monthly_Discharge_Past = Float64[]
#         mean_Monthly_Discharge_Future_45 = Float64[]
#         mean_Monthly_Discharge_Future_85 = Float64[]
#         for month in 1:12
#             # append!(mean_Monthly_Discharge_Past, median(Monthly_Discharge_past[findall(x-> x == month, all_months_all_runs)]))
#             append!(mean_Monthly_Discharge_Future_45, median(average_monthly_Precipitation_future45[findall(x-> x == month, all_months_all_runs)]))
#             append!(mean_Monthly_Discharge_Future_85, median(average_monthly_Precipitation_future85[findall(x-> x == month, all_months_all_runs)]))
#             # append!(mean_Monthly_Discharge_Future_45, mean(change_45[findall(x-> x == month, all_months_all_runs)]))
#             # append!(mean_Monthly_Discharge_Future_85, mean(change_85[findall(x-> x == month, all_months_all_runs)]))
#         end
#
#         box_prec = []
#         xaxis_1 = collect(1:1:12)
#         for month in 1:12
#             boxplot!([xaxis_45[month]], average_monthly_Precipitation_future45[findall(x-> x == month, all_months_all_runs)] - average_monthly_Precipitation_past45[findall(x-> x == month, all_months_all_runs)], size=(2000,800), leg=false, color=[Farben_45[1]], alpha=0.3)
#             boxplot!([xaxis_85[month]],average_monthly_Precipitation_future85[findall(x-> x == month, all_months_all_runs)] - average_monthly_Precipitation_past85[findall(x-> x == month, all_months_all_runs)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         end
#         ylabel!("[mm/month]", yguidefontsize=20)
#         #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
#         if Catchment_Name == "Pitten"
#             title!("Feistritztal ("*string(Elevation[h])*"m)", titlefont = font(20))
#         elseif Catchment_Name == "IllSugadin"
#             title!("Silbertal ("*string(Elevation[h])*"m)", titlefont = font(20))
#         else
#             title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20))
#         end
#         boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))
#         ylims!((-100,75))
#         yticks!([-100:25:75;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
#         box_prec = boxplot!()
#         push!(all_boxplots_prec, box_prec)
#         # ------------ temp ------------
#         Plots.plot()
#         box_temp = []
#         xaxis_1 = collect(1:1:12)
#         for month in 1:12
#             boxplot!([xaxis_45[month]], average_monthly_Temperature_future45[findall(x-> x == month, all_months_all_runs)] - average_monthly_Temperature_past45[findall(x-> x == month, all_months_all_runs)], size=(2000,800), leg=false, color=[Farben_85[1]], alpha=0.3)
#             boxplot!([xaxis_85[month]],average_monthly_Temperature_future85[findall(x-> x == month, all_months_all_runs)] - average_monthly_Temperature_past85[findall(x-> x == month, all_months_all_runs)], size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         end
#         ylabel!("[°C]", yguidefontsize=20)
#         #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
#         if Catchment_Name == "Pitten"
#             title!("Feistritztal ("*string(Elevation[h])*"m)", titlefont = font(20))
#         elseif Catchment_Name == "IllSugadin"
#             title!("Silbertal ("*string(Elevation[h])*"m)", titlefont = font(20))
#         else
#             title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20))
#         end
#         boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))
#         ylims!((0,8))
#         yticks!([0:2:8;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
#         box_temp = boxplot!()
#         push!(all_boxplots_temp, box_temp)
#
#         #all_info = hcat(all_info, round.(mean_Monthly_Discharge_Past, digits=1))
#         all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_45, digits=1))
#         all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_85, digits=1))
#     end
#     # Plots.plot(all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
#     # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_precipitation_all_catchments_absolute_change_new.png")
#     # Plots.plot()
#     # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
#     # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_temperature_all_catchments_absolute_change.png")
#     writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/median_monthly_prec_future.csv", all_info)
# end




# function plot_changes_prec_temp_discharge_all_catchments(All_Catchment_Names, Elevation, nr_runs)
#     Plots.plot()
#     Farben_45= palette(:reds)
#     Farben_85= palette(:blues)
#     Farben_proj = palette(:tab20)
#     all_boxplots_prec = []
#     all_boxplots_temp = []
#     all_boxplots_q = []
#     all_boxplots_q_85 = []
#
#     for (h,Catchment_Name) in enumerate(All_Catchment_Names)
#         println(Catchment_Name)
#         Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
#         Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
#         path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
#         path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
#         Name_Projections_45 = readdir(path_45)
#         Name_Projections_85 = readdir(path_85)
#         #all_months_all_runs = Float64[]
#         average_monthly_Precipitation_past45 = Float64[]
#         average_monthly_Precipitation_future45 = Float64[]
#         average_monthly_Precipitation_past85 = Float64[]
#         average_monthly_Precipitation_future85 = Float64[]
#         average_monthly_Temperature_past45 = Float64[]
#         average_monthly_Temperature_past85 = Float64[]
#         average_monthly_Temperature_future45 = Float64[]
#         average_monthly_Temperature_future85 = Float64[]
#
#         if Catchment_Name == "Gailtal"
#             ID_Prec_Zones = [113589, 113597, 113670, 114538]
#             # size of the area of precipitation zones
#             Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
#             Temp_Elevation = 1140.0
#             Mean_Elevation_Catchment = 1500
#             ID_temp = 113597
#             Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Palten"
#             ID_Prec_Zones = [106120, 111815, 9900]
#             Area_Zones = [198175943.0, 56544073.0, 115284451.3]
#             ID_temp = 106120
#             Temp_Elevation = 1265.0
#             Mean_Elevation_Catchment = 1300 # in reality 1314
#             Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name=="Feistritz"
#             ID_Prec_Zones = [109967]
#             Area_Zones = [115496400.]
#             ID_temp = 10510
#             Mean_Elevation_Catchment = 900 # in reality 917
#             Temp_Elevation = 488.0
#             Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Defreggental"
#             ID_Prec_Zones = [17700, 114926]
#             Area_Zones = [235811198.0, 31497403.0]
#             ID_temp = 17700
#             Mean_Elevation_Catchment =  2300 # in reality 2233.399986
#             Temp_Elevation = 1385.
#             Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name=="Silbertal"
#             ID_Prec_Zones = [100206]
#             Area_Zones = [100139168.]
#             ID_temp = 14200
#             Mean_Elevation_Catchment = 1700
#             Temp_Elevation = 670.
#             Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
#         elseif Catchment_Name == "Pitztal"
#             ID_Prec_Zones = [102061, 102046]
#             Area_Zones = [20651736.0, 145191864.0]
#             ID_temp = 14620
#             Mean_Elevation_Catchment =  2500 # in reality 2233.399986
#             Temp_Elevation = 1410.
#             Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
#         end
#         Area_Catchment = sum(Area_Zones)
#         Area_Zones_Percent = Area_Zones / Area_Catchment
#         for (i, name) in enumerate(Name_Projections_45)
#             Timeseries_Future = collect(Date(Timeseries_End[i,1]-29,1,1):Day(1):Date(Timeseries_End[i,1],12,31))
#             #print(size(Timeseries_Past), size(Timeseries_Future))
#             Timeseries_Proj = readdlm(path_45*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
#             Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
#             Temperature = readdlm(path_45*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
#             Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
#             # get the temperature data at the mean elevation to calculate the mean potential evaporation
#             Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
#
#             indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
#             #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
#             indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
#             # calculate monthly mean temperature
#             Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
#             Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
#
#             #-------- PRECIPITATION ------------------
#             Precipitation_All_Zones = Array{Float64, 1}[]
#             Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
#             for j in 1: length(ID_Prec_Zones)
#                     # get precipitation projections for the precipitation measurement
#                     Precipitation_Zone = readdlm(path_45*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
#                     #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
#                     push!(Precipitation_All_Zones, Precipitation_Zone ./10)
#                     Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
#             end
#             #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
#             Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
#             Precipitation_Future = Total_Precipitation_Proj[indexstart_future:indexend_future]
#
#
#
#             Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
#             Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
#             append!(average_monthly_Temperature_past45, mean(Monthly_Temperature_Past))
#             append!(average_monthly_Temperature_future45, mean(Monthly_Temperature_Future))
#             append!(average_monthly_Precipitation_past45, mean(Monthly_Precipitation_Past)*12)
#             append!(average_monthly_Precipitation_future45, mean(Monthly_Precipitation_Future)*12)
#         end
#         for (i, name) in enumerate(Name_Projections_85)
#             Timeseries_Future = collect(Date(Timeseries_End[i,2]-29,1,1):Day(1):Date(Timeseries_End[i,2],12,31))
#             #print(size(Timeseries_Past), size(Timeseries_Future))
#             Timeseries_Proj = readdlm(path_85*name*"/"*Catchment_Name*"/pr_model_timeseries.txt")
#             Timeseries_Proj = Date.(Timeseries_Proj, Dates.DateFormat("y,m,d"))
#             Temperature = readdlm(path_85*name*"/"*Catchment_Name*"/tas_"*string(ID_temp)*"_sim1.txt", ',')[:,1]
#             Elevation_Zone_Catchment, Temperature_Elevation_Catchment, Total_Elevationbands_Catchment = gettemperatureatelevation(Elevations_Catchment, Temperature)
#             # get the temperature data at the mean elevation to calculate the mean potential evaporation
#             Temperature = Temperature_Elevation_Catchment[:,findfirst(x-> x==Mean_Elevation_Catchment, Elevation_Zone_Catchment)]
#
#             indexstart_past = findfirst(x-> x == Dates.year(Timeseries_Past[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_past = findlast(x-> x == Dates.year(Timeseries_Past[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Past = Temperature[indexstart_past:indexend_past] ./ 10
#             #print(Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj[end]))
#             indexstart_future = findfirst(x-> x == Dates.year(Timeseries_Future[1]), Dates.year.(Timeseries_Proj))[1]
#             indexend_future = findlast(x-> x == Dates.year(Timeseries_Future[end]), Dates.year.(Timeseries_Proj))[1]
#             Temperature_Future = Temperature[indexstart_future:indexend_future] ./ 10
#             # calculate monthly mean temperature
#             Monthly_Temperature_Past, Month = monthly_discharge(Temperature_Past, Timeseries_Past)
#             Monthly_Temperature_Future, Month_future = monthly_discharge(Temperature_Future, Timeseries_Future)
#
#             #-------- PRECIPITATION ------------------
#             Precipitation_All_Zones = Array{Float64, 1}[]
#             Total_Precipitation_Proj = zeros(length(Timeseries_Proj))
#             for j in 1: length(ID_Prec_Zones)
#                     # get precipitation projections for the precipitation measurement
#                     Precipitation_Zone = readdlm(path_85*name*"/"*Catchment_Name*"/pr_"*string(ID_Prec_Zones[j])*"_sim1.txt", ',')[:,1]
#                     #print(size(Precipitation_Zone), typeof(Precipitation_Zone))
#                     push!(Precipitation_All_Zones, Precipitation_Zone ./10)
#                     Total_Precipitation_Proj += Precipitation_All_Zones[j].*Area_Zones_Percent[j]
#             end
#             #Total_Precipitation_Proj = Precipitation_All_Zones[1].*Area_Zones_Percent[1] + Precipitation_All_Zones[2].*Area_Zones_Percent[2] + Precipitation_All_Zones[3].*Area_Zones_Percent[3] + Precipitation_All_Zones[4].*Area_Zones_Percent[4]
#             Precipitation_Past = Total_Precipitation_Proj[indexstart_past:indexend_past]
#             Precipitation_Future = Total_Precipitation_Proj[indexstart_future:indexend_future]
#
#             Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
#             Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
#
#             Monthly_Precipitation_Past, Month = monthly_precipitation(Precipitation_Past, Timeseries_Past)
#             Monthly_Precipitation_Future, Month_future = monthly_precipitation(Precipitation_Future, Timeseries_Future)
#             append!(average_monthly_Temperature_past85, mean(Monthly_Temperature_Past))
#             append!(average_monthly_Temperature_future85, mean(Monthly_Temperature_Future))
#             append!(average_monthly_Precipitation_past85, mean(Monthly_Precipitation_Past)*12)
#             append!(average_monthly_Precipitation_future85, mean(Monthly_Precipitation_Future)*12)
#
#             # take average over all months in timeseries
#             # for month in 1:12
#             #     current_Month_Temperature = Monthly_Temperature_Past[findall(x->x == month, Month)]
#             #     current_Month_Temperature_future = Monthly_Temperature_Future[findall(x->x == month, Month_future)]
#             #     current_Month_Temperature = mean(current_Month_Temperature)
#             #     current_Month_Temperature_future = mean(current_Month_Temperature_future)
#             #     append!(average_monthly_Temperature_past85, current_Month_Temperature)
#             #     append!(average_monthly_Temperature_future85, current_Month_Temperature_future)
#             #     #append!(all_months_all_runs, month)
#             #
#             #     current_Month_Precipitation = Monthly_Precipitation_Past[findall(x->x == month, Month)]
#             #     current_Month_Precipitation_future = Monthly_Precipitation_Future[findall(x->x == month, Month_future)]
#             #     current_Month_Precipitation = mean(current_Month_Precipitation)
#             #     current_Month_Precipitation_future = mean(current_Month_Precipitation_future)
#             #     #error = relative_error(current_Month_Discharge_future, current_Month_Discharge)
#             #     append!(average_monthly_Precipitation_past85, current_Month_Precipitation)
#             #     append!(average_monthly_Precipitation_future85, current_Month_Precipitation_future)
#             # end
#         end
#         Plots.plot()
#         box_prec = []
#         # xaxis_1 = collect(1:1:12)
#         # boxPlots.plot([1], relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color=Farben_85[2])
#         # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black")
#         # violin!([2], relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85) * 100, color=Farben_45[2])
#         # scatter!(ones(14)*2,relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)*100, color="black")#, minorticks=true, minorgrid=true)#, grid_linewidth=1, minorticks=true)
#         #title!(Catchment_Name, titlefont = font(20))
#         relative_error_P_85 = relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)
#         relative_error_P_45 = relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)
#         # writedlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_4.5.csv", hcat(relative_error_P_45, average_monthly_Precipitation_past45, average_monthly_Precipitation_future45), ',')
#         # writedlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_8.5.csv", hcat(relative_error_P_85,average_monthly_Precipitation_past85, average_monthly_Precipitation_future85), ',')
#         violin!([1],relative_error_P_45*100, color=Farben_45[2], yticks=:none, xticks=:none)
#         # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black", yticks=:none,xticks=:none)
#         violin!([2],  relative_error_P_85*100, color=Farben_85[2],yticks=:none,xticks=:none)
#         # scatter!(ones(14)*2, relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black",yticks=:none,xticks=:none)
#
#
#
#         ylims!((-18,30))
#         if h==1||h==6
#             yticks!([-10:10:30;])
#         end
#         box_prec = violin!(framestyle = :box)
#         xticks!([1:1:2;], ["RCP 4.5","RCP 8.5"])
#         #,  aspect_ratio=1)#aspect_ratio=1)
#         push!(all_boxplots_prec, box_prec)
#         if h==1
#             ylabel!("∆ Precipitation [%]", yguidefontsize=20)
#         end
#         # ------------ temp ------------
#         Plots.plot()
#
#         box_temp = []
#         relative_error_T_85 = relative_error(average_monthly_Temperature_future85, average_monthly_Temperature_past85)
#         relative_error_T_45 = relative_error(average_monthly_Temperature_future45, average_monthly_Temperature_past45)
#         writedlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_4.5.csv", hcat(relative_error_P_45, average_monthly_Temperature_past45, average_monthly_Temperature_future45), ',')
#         writedlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_8.5.csv", hcat(relative_error_P_85,average_monthly_Temperature_past85, average_monthly_Temperature_future85), ',')
#
#         violin!([1],average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[2], yticks=:none, xticks=:none)
#         # scatter!(ones(14), average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color="black")
#         violin!([2],average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[2], yticks=:none, xticks=:none)#,grid_linewidth=1, minorticks=true)
#         # scatter!(ones(14)*2, average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color="black")#,minorticks=true, minorgrid=true)
#         ylims!((1,7))
#
#         if h==1 || h==6
#             yticks!([1:1:7;])
#         end
#         title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20), margin=20px)
#         box_temp = violin!(framestyle = :box)#, aspect_ratio=1)
#         push!(all_boxplots_temp, box_temp)
#         if h==1
#             ylabel!("∆ Temperature [°C]", yguidefontsize=20, left_margin=50px)
#         end
#         #discharge
#         #for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#         monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
#         relative_change_85 = monthly_changes_85[:,1]
#         Total_Discharge_Past_85 = monthly_changes_85[:,2]
#         Total_Discharge_Future_85  = monthly_changes_85[:,3]
#         monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
#         relative_change_45 = monthly_changes_45[:,1]
#         Total_Discharge_Past_45 = monthly_changes_45[:,2]
#         Total_Discharge_Future_45  = monthly_changes_45[:,3]
#         monthly_changes_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_PforF.txt", ',')
#         monthly_changes_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_PforF.txt", ',')
#
#         relative_change_85_PforF = monthly_changes_85_PforF[:,1]
#         Total_Discharge_Past_85_PforF = monthly_changes_85_PforF[:,2]
#         Total_Discharge_Future_85_PforF  = monthly_changes_85_PforF[:,3]
#         relative_change_45_PforF = monthly_changes_45_PforF[:,1]
#         Total_Discharge_Past_45_PforF = monthly_changes_45_PforF[:,2]
#         Total_Discharge_Future_45_PforF  = monthly_changes_45_PforF[:,3]
#
#         #
#         # for annual discharge
#         # relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchment, nr_runs[h])
#         # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs[h])
#         # boxPlots.plot([1],relative_change_45*100, color=Farben_85[2])
#         # violin!([2],relative_change_85*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
#         # boxPlots.plot([1], relative_error(Total_Discharge_Future_45, Total_Discharge_Past_45)*100, color=Farben_85[2])
#         # violin!([2], relative_error(Total_Discharge_Future_85, Total_Discharge_Past_85)*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
#         Plots.plot()
#         box_q = []
#         violin!([1], relative_change_45_PforF*100, color=Farben_45[1], yticks=:none)#, minorticks=true, minorgrid=true)
#         violin!([2], relative_change_45*100, color=Farben_45[2], yticks=:none)
#
#             if Catchment_Name == "Pitztal"
#                 ylims!((-45,90))
#                 yticks!([-40:20:80;])
#             else
#                 ylims!((-45,45))
#                 if h==1
#                     yticks!([-45:20:45;])
#                 end
#             end
#
#         box_q = violin!(framestyle = :box)#, aspect_ratio=1)#, yticks=:none)#aspect_ratio=1)
#         if h==1
#             ylabel!("∆Q RCP 4.5 [%]", yguidefontsize=20)
#         end
#         push!(all_boxplots_q, box_q)
#
#         #
#         # for annual discharge
#         # relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchment, nr_runs[h])
#         # relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs[h])
#         # boxPlots.plot([1],relative_change_45*100, color=Farben_85[2])
#         # violin!([2],relative_change_85*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
#         # boxPlots.plot([1], relative_error(Total_Discharge_Future_45, Total_Discharge_Past_45)*100, color=Farben_85[2])
#         # violin!([2], relative_error(Total_Discharge_Future_85, Total_Discharge_Past_85)*100, color=Farben_45[2])#, minorticks=true, minorgrid=true)
#         Plots.plot()
#         box_q_85 = []
#         violin!([2], relative_change_85*100, color=Farben_85[2], yticks=:none)
#         violin!([1], relative_change_85_PforF*100, color=Farben_85[1], yticks=:none)#, minorticks=true, minorgrid=true)
#         xticks!([1:1:2;], ["Stat","Adapt"])
#
#             if Catchment_Name == "Pitztal"
#                 ylims!((-45,90))
#                 yticks!([-40:20:80;])
#             else
#                 ylims!((-45,45))
#                 if h==1
#                     yticks!([-45:20:45;])
#                 end
#             end
#
#         box_q_85 = violin!(framestyle = :box)#, aspect_ratio=1)#, yticks=:none)#aspect_ratio=1)
#         if h==1
#             ylabel!("∆Q RCP 8.5 [%]", yguidefontsize=20)
#         end
#         push!(all_boxplots_q_85, box_q_85)
#
#         #end
#     end
#     Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
#         all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
#         all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
#         all_boxplots_q_85[1], all_boxplots_q_85[2], all_boxplots_q_85[3], all_boxplots_q_85[4], all_boxplots_q_85[5], all_boxplots_q_85[6],
#         layout= (4,6), legend = false, size=(2600,1500), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorticks=true, minorgrid=true, minorgridlinewidth=2)
#     #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
#     # Plots.plot()
#     # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/monthly_temperature_prec_Discharge_all_catchments_absolute_proj_grid_PF.png")
# end
# plot_changes_prec_temp_discharge_all_catchments_type(Catchment_Names_new, Catchment_Height, 2450)

function plot_changes_precipitation_intensitiy(All_Catchment_Names, Elevation, statistic, change, mean_max)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp45/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp85/rcp85/"
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    all_info = zeros(12)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        # returns an array of 6x5040 entrys, the first row is the months
        # 6 rows for: storm_length, interstorm_length, storm_intensity, Total_Precipitation, Nr_Rain_Days
        Prec_statistics_past_45, Prec_statistics_future_45 = monthly_prec_statistics(path_45, Catchment_Name, mean_max)
        Prec_statistics_past_85, Prec_statistics_future_85 = monthly_prec_statistics(path_85, Catchment_Name, mean_max)
        Plots.plot()
        prec_intensity_change_45 = []
        prec_intensity_change_85 = []
        for month in 1:12
            index_month = findall(x-> x == month, repeat(collect(1:12),14))
            append!(prec_intensity_change_45, mean(relative_error(Prec_statistics_future_45[3, index_month], Prec_statistics_past_45[3, index_month])*100))
            append!(prec_intensity_change_85, mean(relative_error(Prec_statistics_future_85[3, index_month], Prec_statistics_past_85[3, index_month])*100))
        end
        for month in 1:12
            # make repeat(collect(1:12), 14) und das als index month
            index_month = findall(x-> x == month, repeat(collect(1:12),14))
            if statistic =="intensity"
                index = 3
                ylabel!("[mm/d]", yguidefontsize=12)
            elseif statistic == "total_prec"
                index = 4
                ylabel!("[mm/month]", yguidefontsize=12)
            elseif statistic == "days"
                index = 5
                ylabel!("[days]", yguidefontsize=12)
            elseif statistic == "storm_length"
                index = 1
                ylabel!("[days]", yguidefontsize=12)
            elseif statistic == "max_daily_rain"
                index = 6
                ylabel!("[mm/d]", yguidefontsize=12)
            end
            if change == "absolute"
                boxplot!([xaxis_45[month]], Prec_statistics_future_45[index, index_month] - Prec_statistics_past_45[index, index_month], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, outliers=false)
                scatter!(ones(14)*xaxis_45[month], Prec_statistics_future_45[index, index_month] - Prec_statistics_past_45[index, index_month], color="black")
                boxplot!([xaxis_85[month]],Prec_statistics_future_85[index, index_month] - Prec_statistics_past_85[index, index_month], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, outliers=false, framestyle = :box)
                scatter!(ones(14)*xaxis_85[month], Prec_statistics_future_85[index, index_month] - Prec_statistics_past_85[index, index_month], color="black")
            elseif change == "relative"
                boxplot!([xaxis_45[month]], relative_error(Prec_statistics_future_45[index, index_month], Prec_statistics_past_45[index, index_month])*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, outliers=false)
                scatter!(ones(14)*xaxis_45[month], relative_error(Prec_statistics_future_45[index, index_month], Prec_statistics_past_45[index, index_month])*100, color="black")
                boxplot!([xaxis_85[month]], relative_error(Prec_statistics_future_85[index, index_month], Prec_statistics_past_85[index, index_month])*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, outliers=false, framestyle = :box)
                scatter!(ones(14)*xaxis_85[month], relative_error(Prec_statistics_future_85[index, index_month], Prec_statistics_past_85[index, index_month])*100, color="black")
            end
        end
        hline!([0], color=["grey"], linestyle = :dash)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        # ylims!((-0.4,0.7))
        # yticks!([-0.4:0.2:0.6;])
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box_prec = boxplot!()
        push!(all_boxplots, box_prec)
        println("all info siz ",size(all_info))
        all_info = hcat(all_info, prec_intensity_change_45)
        all_info = hcat(all_info, prec_intensity_change_85)
    end
    # Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/precipitation_"*statistic*"_"*change*"_"*mean_max*"_mean_all_years.png")
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/mean_rel_change_max_monthly_prec_intensity_max_all_years.csv", all_info)
end

function plot_changes_precipitation_intensitiy_all_years(All_Catchment_Names, Elevation, statistic, mean_max)
    past = collect(1:3:34)
    xaxis_45 = collect(2:3:35)
    xaxis_85 = collect(3:3:36)
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp45/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp85/rcp85/"
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        # returns an array of 6x5040 entrys, the first row is the months
        # 6 rows for: month,storm_length, interstorm_length, storm_intensity, Total_Precipitation, Nr_Rain_Days, max_daily_rain
        Prec_statistics_past_45, Prec_statistics_future_45 = monthly_prec_statistics_all_years(path_45, Catchment_Name, mean_max)
        Prec_statistics_past_85, Prec_statistics_future_85 = monthly_prec_statistics_all_years(path_85, Catchment_Name, mean_max)
        Plots.plot()
        @assert repeat(collect(1:12),14*30) == Prec_statistics_past_45[1,:]

        for month in 1:12
            # make repeat(collect(1:12), 14) und das als index month
            index_month = findall(x-> x == month, repeat(collect(1:12),14*30))
            if statistic =="intensity"
                index = 4
                ylabel!("[mm/d]", yguidefontsize=12)
            elseif statistic == "total_prec"
                index = 5
                ylabel!("[mm/month]", yguidefontsize=12)
            elseif statistic == "days"
                index = 6
                ylabel!("[days]", yguidefontsize=12)
            elseif statistic == "storm_length"
                index = 2
                ylabel!("[days]", yguidefontsize=12)
            elseif statistic == "max_daily_rain"
                index = 7
                ylabel!("[mm/d]", yguidefontsize=12)
            end
            violin!([past[month]], (Prec_statistics_past_45[index, index_month]  + Prec_statistics_past_85[index, index_month]) ./ 2, size=(2000,800), leg=false, color=["grey"], alpha=0.3, outliers=false)
            violin!([xaxis_45[month]], Prec_statistics_future_45[index, index_month], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, outliers=false)
            violin!([xaxis_85[month]],Prec_statistics_future_85[index, index_month], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, outliers=false, framestyle = :box)

        end
        #hline!([0], color=["grey"], linestyle = :dash)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end

        xticks!([2:3:35;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box_prec = boxplot!()
        push!(all_boxplots, box_prec)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/precipitation_"*statistic*"_"*mean_max*"_all_years_violin.png")
end

function plot_monthly_runoff_coefficient(All_Catchment_Names, Elevation, nr_runs)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_violins = []
    all_violins_85 = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_runoff_coef_45_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
        monthly_runoff_coef_past_45_NS = monthly_runoff_coef_45_NS[:,1]
        monthly_runoff_coef_future_45_NS = monthly_runoff_coef_45_NS[:,2]
        months_45_NS  = monthly_runoff_coef_45_NS[:,3]
        monthly_runoff_coef_85_NS = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
        monthly_runoff_coef_past_85_NS = monthly_runoff_coef_85_NS[:,1]
        monthly_runoff_coef_future_85_NS = monthly_runoff_coef_85_NS[:,2]
        months_85_NS  = monthly_runoff_coef_85_NS[:,3]
        monthly_runoff_coef_45_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
        monthly_runoff_coef_past_45_PforF = monthly_runoff_coef_45_PforF[:,1]
        monthly_runoff_coef_future_45_PforF = monthly_runoff_coef_45_PforF[:,2]
        months_45_PforF  = monthly_runoff_coef_45_PforF[:,3]
        monthly_runoff_coef_85_PforF = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
        monthly_runoff_coef_past_85_PforF = monthly_runoff_coef_85_PforF[:,1]
        monthly_runoff_coef_future_85_PforF = monthly_runoff_coef_85_PforF[:,2]
        months_85_PforF  = monthly_runoff_coef_85_PforF[:,3]

        Plots.plot()
        box = []
        avg_monthly_runoff_coef_future_45_PforF = zeros(12,3)
        avg_monthly_runoff_coef_future_45_NS = zeros(12,3)
        avg_monthly_runoff_coef_future_85_PforF= zeros(12,3)
        avg_monthly_runoff_coef_future_85_NS= zeros(12,3)
        avg_monthly_runoff_coef_past_45_PforF = zeros(12,3)
        avg_monthly_runoff_coef_past_45_NS = zeros(12,3)
        avg_monthly_runoff_coef_past_85_PforF= zeros(12,3)
        avg_monthly_runoff_coef_past_85_NS= zeros(12,3)

        for month in 1:12
            monthly_runoff_coef_past_45_PforF_ =   monthly_runoff_coef_past_45_PforF[findall(x-> x == month, months_45_PforF)]
            monthly_runoff_coef_future_45_PforF_ = monthly_runoff_coef_future_45_PforF[findall(x-> x == month, months_45_PforF)]
            monthly_runoff_coef_past_85_PforF_ = monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_45_PforF)]
            monthly_runoff_coef_future_85_PforF_ = monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_45_PforF)]
            monthly_runoff_coef_past_45_NS_ = monthly_runoff_coef_past_45_NS[findall(x-> x == month, months_45_NS)]
            monthly_runoff_coef_future_45_NS_ = monthly_runoff_coef_future_45_NS[findall(x-> x == month, months_45_NS)]
            monthly_runoff_coef_past_85_NS_ = monthly_runoff_coef_past_85_NS[findall(x-> x == month, months_45_NS)]
            monthly_runoff_coef_future_85_NS_ = monthly_runoff_coef_future_85_NS[findall(x-> x == month, months_45_NS)]
            avg_monthly_runoff_coef_future_45_PforF[month,:] .= mean(monthly_runoff_coef_future_45_PforF_[:,1]), minimum(monthly_runoff_coef_future_45_PforF_[:,1]), maximum(monthly_runoff_coef_future_45_PforF_[:,1])
            avg_monthly_runoff_coef_future_45_NS[month,:] .= mean(monthly_runoff_coef_future_45_NS_[:,1]), minimum(monthly_runoff_coef_future_45_NS_[:,1]), maximum(monthly_runoff_coef_future_45_NS_[:,1])
            avg_monthly_runoff_coef_future_85_PforF[month,:].= mean(monthly_runoff_coef_future_85_PforF_[:,1]), minimum(monthly_runoff_coef_future_85_PforF_[:,1]), maximum(monthly_runoff_coef_future_85_PforF_[:,1])
            avg_monthly_runoff_coef_future_85_NS[month,:] .= mean(monthly_runoff_coef_future_85_NS_[:,1]), minimum(monthly_runoff_coef_future_85_NS_[:,1]), maximum(monthly_runoff_coef_future_85_NS_[:,1])
            avg_monthly_runoff_coef_past_45_PforF[month,:] .= mean(monthly_runoff_coef_past_45_PforF_[:,1]), minimum(monthly_runoff_coef_past_45_PforF_[:,1]), maximum(monthly_runoff_coef_past_45_PforF_[:,1])
            avg_monthly_runoff_coef_past_45_NS[month,:] .= mean(monthly_runoff_coef_past_45_NS_[:,1]), minimum(monthly_runoff_coef_past_45_NS_[:,1]), maximum(monthly_runoff_coef_past_45_NS_[:,1])
            avg_monthly_runoff_coef_past_85_PforF[month,:].= mean(monthly_runoff_coef_past_85_PforF_[:,1]), minimum(monthly_runoff_coef_past_85_PforF_[:,1]), maximum(monthly_runoff_coef_past_85_PforF_[:,1])
            avg_monthly_runoff_coef_past_85_NS[month,:] .= mean(monthly_runoff_coef_past_85_NS_[:,1]), minimum(monthly_runoff_coef_past_85_NS_[:,1]), maximum(monthly_runoff_coef_past_85_NS_[:,1])
        end

        for month in 1:12
            plot!(avg_monthly_runoff_coef_future_45_PforF[:,1], ribbon = [avg_monthly_runoff_coef_future_45_PforF[:,1]-avg_monthly_runoff_coef_future_45_PforF[:,2], avg_monthly_runoff_coef_future_45_PforF[:,3]-avg_monthly_runoff_coef_future_45_PforF[:,1]], color=Farben_45[2], label="Cl,past RCP4.5")
            plot!(avg_monthly_runoff_coef_future_45_NS[:,1], ribbon = [avg_monthly_runoff_coef_future_45_NS[:,1]-avg_monthly_runoff_coef_future_45_NS[:,2], avg_monthly_runoff_coef_future_45_NS[:,3]-avg_monthly_runoff_coef_future_45_NS[:,1]], color=Farben_45[1], label="Cl,fut RCP4.5")
            plot!(avg_monthly_runoff_coef_future_85_PforF[:,1], ribbon = [avg_monthly_runoff_coef_future_85_PforF[:,1]-avg_monthly_runoff_coef_future_85_PforF[:,2], avg_monthly_runoff_coef_future_85_PforF[:,3]-avg_monthly_runoff_coef_future_85_PforF[:,1]], color=Farben_85[2], label="Cl,past RCP8.5")
            plot!(avg_monthly_runoff_coef_future_85_NS[:,1], ribbon = [avg_monthly_runoff_coef_future_85_NS[:,1]-avg_monthly_runoff_coef_future_85_NS[:,2], avg_monthly_runoff_coef_future_85_NS[:,3]-avg_monthly_runoff_coef_future_85_NS[:,1]], color=Farben_85[1], label="Cl,fut RCP8.5")

            # violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="Past", outlier=false)
            # violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
        end
        ylabel!("[mm/d]", yguidefontsize=20)
        ylims!((0,5))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = violin!()
        push!(all_violins, box)
        # for RCP 8.5
        Plots.plot()
        box = []
        for month in 1:12
            violin!([xaxis_45[month]],monthly_runoff_coef_past_85_PforF[findall(x-> x == month, months_85_PforF)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="Past", outlier=false)
            violin!([xaxis_85[month]],monthly_runoff_coef_future_85_PforF[findall(x-> x == month, months_85_PforF)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
        end
        ylabel!("[mm/d]", yguidefontsize=20)
        ylims!((0,10))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = violin!()
        push!(all_violins_85, box)
    end
    #Plots.plot(all_violins[1], all_violins[2], layout= (2,1), legend = true, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/monthly_runoff_coefficient_past_future_45_scaled_line.png")
    #Plots.plot(all_violins_85[1], all_violins_85[2], layout= (2,1), legend = true, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/monthly_runoff_coefficient_past_future_85_scaled_line.png")
end

# plot_monthly_runoff_coefficient(Catchment_Names_new, Catchment_Height, nr_runs)

function plot_monthly_runoff_coefficient_violins(All_Catchment_Names, Elevation, nr_runs)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_violins = []
    all_violins_85 = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        monthly_runoff_coef_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
        monthly_runoff_coef_past_45 = monthly_runoff_coef_45[:,1]
        monthly_runoff_coef_future_45 = monthly_runoff_coef_45[:,2]
        months_45  = monthly_runoff_coef_45[:,3]
        monthly_runoff_coef_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')
        monthly_runoff_coef_past_85 = monthly_runoff_coef_85[:,1]
        monthly_runoff_coef_future_85 = monthly_runoff_coef_85[:,2]
        months_85  = monthly_runoff_coef_85[:,3]
        Plots.plot()
        box = []

        for month in 1:12
            violin!([xaxis_45[month]],monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="Past", outlier=false)
            violin!([xaxis_85[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
        end
        ylabel!("[mm/d]", yguidefontsize=20)
        ylims!((0,5))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = violin!()
        push!(all_violins, box)
        # for RCP 8.5
        Plots.plot()
        box = []
        for month in 1:12
            violin!([xaxis_45[month]],monthly_runoff_coef_past_85[findall(x-> x == month, months_85)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="Past", outlier=false)
            violin!([xaxis_85[month]],monthly_runoff_coef_future_85[findall(x-> x == month, months_85)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="Future", outlier=false)
        end
        ylabel!("[mm/d]", yguidefontsize=20)
        ylims!((0,5))
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = violin!()
        push!(all_violins_85, box)
    end
    #Plots.plot(all_violins[1], all_violins[2], layout= (2,1), legend = true, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/monthly_runoff_coefficient_past_future_45_scaled.png")
    #Plots.plot(all_violins_85[1], all_violins_85[2], layout= (2,1), legend = true, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/monthly_runoff_coefficient_past_future_85_scaled.png")
end

function plot_monthly_runoff_coefficient_change_violins(All_Catchment_Names, Elevation, nr_runs, seasonal_month)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_85 = palette(:reds)
    Farben_45 = palette(:blues)
    all_violins = []
    all_violins_85 = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        if seasonal_month == "month"
            monthly_runoff_coef_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_4.5_new.txt", ',')
            monthly_runoff_coef_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_monthly_runoff_coefficient_8.5_new.txt", ',')

        elseif seasonal_month == "seasonal"
            monthly_runoff_coef_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_4.5.txt", ',')
            monthly_runoff_coef_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/NS_seasonal_runoff_coefficient_8.5.txt", ',')

        end
        monthly_runoff_coef_past_45 = monthly_runoff_coef_45[:,1]
        monthly_runoff_coef_future_45 = monthly_runoff_coef_45[:,2]
        months_45  = monthly_runoff_coef_45[:,3]

        monthly_runoff_coef_past_85 = monthly_runoff_coef_85[:,1]
        monthly_runoff_coef_future_85 = monthly_runoff_coef_85[:,2]
        months_85  = monthly_runoff_coef_85[:,3]

        if seasonal_month == "month"
            Plots.plot()
            box = []
            #absolute change
            for month in 1:12
                violin!([xaxis_45[month]],monthly_runoff_coef_future_45[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="RCP 4.5", outlier=false)
                violin!([xaxis_85[month]],monthly_runoff_coef_future_85[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            end
            ylabel!("absolute ∆Q/P [-]", yguidefontsize=20)
            ylims!((0,2))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Pitten"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "IllSugadin"
                title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
            xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            box = violin!()
            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            for month in 1:12
                violin!([xaxis_45[month]], 100*relative_error(monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], monthly_runoff_coef_past_45[findall(x-> x == month, months_45)]), size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="RCP 4.5", outlier=false)
                violin!([xaxis_85[month]],100*relative_error(monthly_runoff_coef_future_85[findall(x-> x == month, months_45)], monthly_runoff_coef_past_85[findall(x-> x == month, months_45)]), size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            end
            ylabel!("absolute ∆Q/P [-]", yguidefontsize=20)
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Pitten"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "IllSugadin"
                title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
            xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            box = violin!()
            push!(all_violins_85, box)
        elseif seasonal_month == "seasonal"
            Plots.plot()
            box = []
            #absolute change
            for month in 1:4
                violin!(monthly_runoff_coef_future_45[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_45[findall(x-> x == month, months_45)], size=(1500,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="RCP 4.5", outlier=false)
                violin!(monthly_runoff_coef_future_85[findall(x-> x == month, months_45)]- monthly_runoff_coef_past_85[findall(x-> x == month, months_45)], size=(1500,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false, margin=5mm)
            end
            #ylabel!("abs. change monthly Q/P", yguidefontsize=20)
            if Catchment_Name != "Pitztal" && Catchment_Name !="Defreggental" && Catchment_Name !="IllSugadin"
                ylims!((-0.5,0.5))
            else
                ylims!((-0.6,0.9))
                yticks!([-0.5:0.25:0.75;], ["-0.50","-0.25","0", "0.25", "0.50", "0.75"])
            end
            #
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Pitten"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "IllSugadin"
                title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "Palten"
                title!("Palten ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
            xticks!([1.3:0.8:3.7;], ["Spring", "Summer", "Autumn", "Winter"])
            box = violin!()
            push!(all_violins, box)
            # for RCP 8.5
            Plots.plot()
            box = []
            # relative chagne
            for month in 1:4
                violin!(100*relative_error(monthly_runoff_coef_future_45[findall(x-> x == month, months_45)], monthly_runoff_coef_past_45[findall(x-> x == month, months_45)]), size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, label="RCP 4.5", outlier=false)
                violin!(100*relative_error(monthly_runoff_coef_future_85[findall(x-> x == month, months_45)], monthly_runoff_coef_past_85[findall(x-> x == month, months_45)]), size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box, label="RCP 8.5", outlier=false)
            end
            ylabel!("∆Q/P [%]", yguidefontsize=20)
            #ylims!((0,5))
            #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
            if Catchment_Name == "Pitten"
                title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
            elseif Catchment_Name == "IllSugadin"
                title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
            else
                title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
            end
            violin!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20), outlier=false)
            xticks!([1.3:0.8:3.7;], ["Spring", "Summer", "Autumn", "Winter"])
            box = violin!()
            push!(all_violins_85, box)
        end
    end
    if seasonal_month == "month"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = 200px, right_margin = 20px,bottom_margin = 100px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/NS_monthly_runoff_coefficient_abs_change.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = 200px, right_margin = 100px,bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/NS_monthly_runoff_coefficient_past_future_rel_change.png")
    elseif seasonal_month == "seasonal"
        Plots.plot(all_violins[1], all_violins[2], all_violins[3], all_violins[4], all_violins[5], all_violins[6], layout= (2,3), legend = false, size=(2000,1000), left_margin = 200px, bottom_margin = 20px, right_margin = 100px,yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/NS_seasonal_runoff_coefficient_abs_change_new_2.png")
        Plots.plot(all_violins_85[1], all_violins_85[2], all_violins_85[3], all_violins_85[4], all_violins_85[5], all_violins_85[6], layout= (2,3), legend = false, size=(2500,800), left_margin = 200px, right_margin = 100px, bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
        Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Runoff/NS_seasonal_runoff_coefficient_past_future_rel_change_season.png")
    end
end

# plot_monthly_runoff_coefficient_change(Catchment_Names_new, Catchment_Height, "seasonal")
# # plot_monthly_runoff_coefficient_violins(Catchment_Names_new, Catchment_Height, nr_runs)
# #
# # plot_monthly_runoff_coefficient_change_violins(Catchment_Names_new2, Catchment_Height, nr_runs, "seasonal")
# #plot_monthly_runoff_coefficient_change(Catchment_Names_new2, Catchment_Height_new2, nr_runs, "month")
# # plot_monthly_runoff_coefficient_change(Catchment_Names_new2, Catchment_Height, nr_runs, "seasonal")

# change_prec = "relative"
# mean_max = "max"
# @time begin
#plot_changes_precipitation_intensitiy(Catchment_Names,Catchment_Height, "intensity", change_prec, mean_max)
# end
# plot_changes_precipitation_intensitiy(Catchment_Names,Catchment_Height, "days",change_prec)
# plot_changes_precipitation_intensitiy(Catchment_Names,Catchment_Height, "storm_length", change_prec, mean_max)
# plot_changes_precipitation_intensitiy(Catchment_Names,Catchment_Height, "total_prec", change_prec)
# plot_changes_precipitation_intensitiy(Catchment_Names,Catchment_Height, "max_daily_rain", change_prec, mean_max)

# plot_changes_precipitation_intensitiy_all_years(Catchment_Names,Catchment_Height, "intensity", mean_max)
# plot_changes_precipitation_intensitiy_all_years(Catchment_Names,Catchment_Height, "days",mean_max)
# plot_changes_precipitation_intensitiy_all_years(Catchment_Names,Catchment_Height, "storm_length",  mean_max)
# plot_changes_precipitation_intensitiy_all_years(Catchment_Names,Catchment_Height, "total_prec", mean_max)
# plot_changes_precipitation_intensitiy_all_years(Catchment_Names,Catchment_Height, "max_daily_rain", mean_max)
# plot_changes_monthly_discharge_all_catchments_past(Catchment_Names, Catchment_Height, Area_Catchments)
#plot_changes_monthly_discharge_all_catchments(Catchment_Names, Catchment_Height, Area_Catchments)
#plot_changes_monthly_discharge_all_catchments_absolute(Catchment_Names, Catchment_Height, Area_Catchments)
#plot_changes_monthly_temp_all_catchments(Catchment_Names, Catchment_Height)
#plot_changes_prec_temp_discharge_all_catchments(Catchment_Names, Catchment_Height, nr_runs)



"""
Plots annual discharge violin plots with median

$(SIGNATURES)
"""
# function plot_changes_annual_discharge_all_catchments(All_Catchment_Names, Area_Catchments, nr_runs)
#     Plots.plot()
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#         monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_8.5.txt", ',')
#         months_85 = monthly_changes_85[:,1]
#         Monthly_Discharge_past_85 = monthly_changes_85[:,2]
#         Monthly_Discharge_future_85  = monthly_changes_85[:,3]
#         monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_4.5.txt", ',')
#         months_45 = monthly_changes_45[:,1]
#         Monthly_Discharge_past_45 = monthly_changes_45[:,2]
#         Monthly_Discharge_future_45  = monthly_changes_45[:,3]
#         Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
#
#         # for annual discharge
#         relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_45_NS.csv", ',')
#         #relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = annual_discharge_new(Monthly_Discharge_past_85, Monthly_Discharge_future_85, Area_Catchment, nr_runs)
#         #boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]]
#         if Catchment_Name == "Pitten"
#             Catchment_Name = "Feistritz"
#         elseif Catchment_Name == "IllSugadin"
#             Catchment_Name = "Silbertal"
#         end
#         violin!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
#         #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
#         #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
#         #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
#         ylims!((-35,35))
#         yticks!([-35:10:35;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         #ylabel!("Relative Change in Average Annual Discharge [%]")
#         ylabel!("[%]")
#         title!("Relative Change in Average Annual Discharge for RCP 4.5")
#     end
#     box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
#     Plots.plot()
#     for (i,Catchment_Name) in enumerate(All_Catchment_Names)
#         # monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_8.5.txt", ',')
#         # months_85 = monthly_changes_85[:,1]
#         # Monthly_Discharge_past_85 = monthly_changes_85[:,2]
#         # Monthly_Discharge_future_85  = monthly_changes_85[:,3]
#         # monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Monthly_Discharge/discharge_months_4.5.txt", ',')
#         # months_45 = monthly_changes_45[:,1]
#         # Monthly_Discharge_past_45 = monthly_changes_45[:,2]
#         # Monthly_Discharge_future_45  = monthly_changes_45[:,3]
#         # Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
#
#         # for annual discharge
#         #relative_change_45, Total_Discharge_Past_45, Total_Discharge_Future_45 = annual_discharge_new(Monthly_Discharge_past_45, Monthly_Discharge_future_45, Area_Catchments[i], nr_runs[i])
#         relative_change_85, Total_Discharge_Past_85, Total_Discharge_Future_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Discharge/annual_discharge_85_NS.csv", ',')
#         #boxplot!([Catchment_Name], relative_change_45*100, size=(2000,800), leg=false, color=[Farben_85[2]]
#         if Catchment_Name == "Pitten"
#             Catchment_Name = "Feistritz"
#             println("works")
#         elseif Catchment_Name == "IllSugadin"
#             Catchment_Name = "Silbertal"
#         end
#         violin!([Catchment_Name], relative_change_85*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
#         boxplot!([Catchment_Name], relative_change_85*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
#         #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
#         #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
#         #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
#         ylims!((-35,35))
#         yticks!([-35:10:35;])
#         hline!([0], color=["grey"], linestyle = :dash)
#         #ylabel!("Relative Change in Average Annual Discharge [%]")
#         ylabel!("[%]")
#         title!("Relative Change in Average Annual Discharge for RCP 4.5")
#     end
#     box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
#     Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
#
#     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_discharges_all_catchments_45_85.png")
# end

# nr_runs=3000
# @time begin
# # plot_changes_annual_discharge_all_catchments(Catchment_Names_new2, Area_Catchments_new2, nr_runs)
# end

function plot_max_magnitude_changes_AMF_all_catchments_S(All_Catchment_Names, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        Date_Past_45 = max_discharge_prob_45[:,4]
        Date_Future_45 = max_discharge_prob_45[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_85[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        ylims!((-35,50))
        yticks!([-30:10:50;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    box_45 = boxplot!(left_margin = [20mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt",',')
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        Date_Past_85 = max_discharge_prob_85[:,4]
        Date_Future_85 = max_discharge_prob_85[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_85[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_85[1+(run-1)*30:30*run]))
        end

        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_45[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3,  minorticks=true)
        ylims!((-35,55))
        yticks!([-30:10:55;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[j])*"m)")
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[j])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)")
        end

        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 8.5")
    end
    box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Discharge/maxHQ_annual_discharges_all_catchments_45_85.png")
end
function plot_max_magnitude_changes_AMF_all_catchments(All_Catchment_Names, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        Date_Past_45 = max_discharge_prob_45[:,4]
        Date_Future_45 = max_discharge_prob_45[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_85[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        ylims!((-35,50))
        yticks!([-30:10:50;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt",',')
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        Date_Past_85 = max_discharge_prob_85[:,4]
        Date_Future_85 = max_discharge_prob_85[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_85[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_85[1+(run-1)*30:30*run]))
        end

        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_45[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3,  minorticks=true)
        ylims!((-35,55))
        yticks!([-30:10:55;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 8.5")
    end
    box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Discharge/maxHQ_annual_discharges_all_catchments_45_85.png")
end

function plot_mean_magnitude_changes_AMF_all_catchments(All_Catchment_Names, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        Date_Past_45 = max_discharge_prob_45[:,4]
        Date_Future_45 = max_discharge_prob_45[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, mean(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, mean(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_85[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        ylims!((-35,50))
        yticks!([-30:10:50;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt",',')
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        Date_Past_85 = max_discharge_prob_85[:,4]
        Date_Future_85 = max_discharge_prob_85[:,5]
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, mean(max_Discharge_Past_85[1+(run-1)*30:30*run]))
            append!(max_discharge_future, mean(max_Discharge_Future_85[1+(run-1)*30:30*run]))
        end

        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        violin!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100,color=[Farben_45[2]])
        boxplot!([Catchment_Name], relative_error(max_discharge_future, max_discharge_past)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3,  minorticks=true)
        ylims!((-35,55))
        yticks!([-30:10:55;])
        ylabel!("[%]")
        hline!([0], color=["grey"], linestyle = :dash)
        title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 8.5")
    end
    box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/meanHQ_annual_discharges_all_catchments_45_85.png")
end
# plot_mean_magnitude_changes_AMF_all_catchments(Catchment_Names_new, nr_runs)


function plot_timing_changes_AMF_all_Catchments_fraction(All_Catchment_Names, Elevation, nr_runs, rcp_name)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        if rcp_name == "45"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
            Farben = palette(:blues)
        elseif rcp_name == "85"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
            Farben = palette(:reds)
        end
        Date_Past = max_discharge_prob[:,4]
        Date_Future = max_discharge_prob[:,5]
        period_15_days_past, day_range_past = get_distributed_dates(Date_Past, 15, nr_runs[j])
        period_15_days_future, day_range_future = get_distributed_dates(Date_Future, 15, nr_runs[j])

        Plots.plot()
        for i in collect(0:15:366)
            current_past = period_15_days_past[findall(x->x==i, day_range_future)]
            current_future = period_15_days_future[findall(x->x==i, day_range_future)]
            #print(current_past[1:10])
            #Plots.plot!(mean(current_past)*100, leg=false, size=(1500,800), color=[Farben[1]])
            #scatter!([count, mean(current_past)*100], leg=false, size=(1500,800), color=[Farben[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            #Plots.plot!(mean(current_future)*100, leg=false, size=(1500,800), color=[Farben[2]])
            #scatter!([count+1,mean(current_future)*100], leg=false, size=(1500,800), color=[Farben[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            boxplot!(current_past*100, leg=false, size=(1500,800), color=[Farben[1]])
            boxplot!(current_future*100, leg=false, size=(1500,800), color=[Farben[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            #count+=2
        end
        ylabel!("[%]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)")
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        if Catchment_Name == "Defreggental" || Catchment_Name == "Pitztal"
            ylims!((0,65))
            yticks!([0:10:60;])
        else
            ylims!((0,45))
            yticks!([0:10:40;])
        end
        xticks!([2.5:4:47.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        xlims!((0,52))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_"*rcp_name*"_new.png")
end
#plot_magnitude_changes_AMF_all_catchments(Catchment_Names, Area_Catchments)
# plot_timing_changes_AMF_all_catchments(Catchment_Names)
# plot_max_magnitude_changes_AMF_all_catchments(Catchment_Names, nr_runs)
function plot_timing_changes_AMF_all_Catchments_fraction_new(All_Catchment_Names, Elevation, nr_runs, rcp_name)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        if rcp_name == "45"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
            Farben = palette(:blues)
        elseif rcp_name == "85"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
            Farben = palette(:reds)
        end
        Date_Past = max_discharge_prob[:,4]
        Date_Future = max_discharge_prob[:,5]
        period_15_days_past, day_range_past = get_distributed_dates(Date_Past, 15, nr_runs[j])
        period_15_days_future, day_range_future = get_distributed_dates(Date_Future, 15, nr_runs[j])

        Plots.plot()
        #print(size(period_15_days_future))
        mean_per_15_days_past = Float64[]
        mean_per_15_days_future = Float64[]
        for i in collect(0:15:366)
            current_past = period_15_days_past[findall(x->x==i, day_range_future)]
            current_future = period_15_days_future[findall(x->x==i, day_range_future)]
            append!(mean_per_15_days_past, mean(current_past)*100)
            append!(mean_per_15_days_future, mean(current_future)*100)
        end
        print(size(mean_per_15_days_past))
        Plots.plot!(mean_per_15_days_past, leg=false, size=(1500,800), linestyle = :dash, color=[Farben[1]])
        scatter!(mean_per_15_days_past, leg=false, size=(1500,800), markercolor=[Farben[1]], markersize=7, markerstrokecolor=[Farben[1]],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        Plots.plot!(mean_per_15_days_future, leg=false, size=(1500,800), linestyle = :dash,color=[Farben[2]])
        scatter!(mean_per_15_days_future, leg=false, size=(1500,800), color=[Farben[2]],markersize=7, markerstrokecolor=[Farben[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)


        ylabel!("[%]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)")
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        ylims!((0,35))
        yticks!([0:5:35;])
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        xlims!((0,25))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_"*rcp_name*"_different_new.png")
end

"""
Plots the distribution of timing of annual maximum discharges all in one plot

$(SIGNATURES)

"""
function plot_timing_changes_AMF_all_Catchments_fraction_4585(All_Catchment_Names, Elevation, nr_runs, errorbounds)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    Plots.plot()
    mean_per_15days_past = zeros(25)
    mean_per_15days_future_45 = zeros(25)
    mean_per_15days_future_85 = zeros(25)
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
        Farben_45= palette(:blues)
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
        Farben_85= palette(:reds)
        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
        Farben_45= palette(:blues)
        max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
        Farben_85= palette(:reds)
        println(Catchment_Name)
        println(size(max_discharge_prob_45), size(max_discharge_prob_85), size(max_discharge_prob_45_pf), size(max_discharge_prob_85_pf))
        Date_Past_45 = max_discharge_prob_45[:,4]
        Date_Future_45 = max_discharge_prob_45[:,5]
        Date_Past_85 = max_discharge_prob_85[:,4]
        Date_Future_85 = max_discharge_prob_85[:,5]
        period_15_days_past_45, day_range_past_45 = get_distributed_dates(Date_Past_45, 15, nr_runs[j], 30)
        period_15_days_future_45, day_range_future_45 = get_distributed_dates(Date_Future_45, 15, nr_runs[j], 30)
        period_15_days_past_85, day_range_past_85 = get_distributed_dates(Date_Past_85, 15, nr_runs[j], 30)
        period_15_days_future_85, day_range_future_85 = get_distributed_dates(Date_Future_85, 15, nr_runs[j], 30)
        Date_Past_45_pf = max_discharge_prob_45_pf[:,4]
        Date_Future_45_pf = max_discharge_prob_45_pf[:,5]
        Date_Past_85_pf = max_discharge_prob_85_pf[:,4]
        Date_Future_85_pf = max_discharge_prob_85_pf[:,5]
        period_15_days_past_45_pf, day_range_past_45_pf = get_distributed_dates(Date_Past_45_pf, 15, nr_runs[j], 30)
        period_15_days_future_45_pf, day_range_future_45_pf = get_distributed_dates(Date_Future_45_pf, 15, nr_runs[j], 30)
        period_15_days_past_85_pf, day_range_past_85_pf = get_distributed_dates(Date_Past_85_pf, 15, nr_runs[j], 30)
        period_15_days_future_85_pf, day_range_future_85_pf = get_distributed_dates(Date_Future_85_pf, 15, nr_runs[j], 30)

        Plots.plot()
        #print(size(period_15_days_future))
        mean_per_15_days_past_45 = Float64[]
        mean_per_15_days_future_45 = Float64[]
        mean_per_15_days_past_85 = Float64[]
        mean_per_15_days_future_85 = Float64[]
        std_per_15_days_past_45 = Float64[]
        std_per_15_days_future_45 = Float64[]
        std_per_15_days_past_85 = Float64[]
        std_per_15_days_future_85 = Float64[]
        mean_per_15_days_past_45_pf = Float64[]
        mean_per_15_days_future_45_pf = Float64[]
        mean_per_15_days_past_85_pf = Float64[]
        mean_per_15_days_future_85_pf = Float64[]
        std_per_15_days_past_45_pf = Float64[]
        std_per_15_days_future_45_pf = Float64[]
        std_per_15_days_past_85_pf = Float64[]
        std_per_15_days_future_85_pf = Float64[]

        for i in collect(0:15:366)
            current_past_45 = period_15_days_past_45[findall(x->x==i, day_range_past_45)]
            current_future_45 = period_15_days_future_45[findall(x->x==i, day_range_future_45)]
            append!(mean_per_15_days_past_45, mean(current_past_45)*100)
            append!(mean_per_15_days_future_45, mean(current_future_45)*100)
            append!(std_per_15_days_past_45, std(current_past_45)*100)
            append!(std_per_15_days_future_45, std(current_future_45)*100)
            current_past_85 = period_15_days_past_85[findall(x->x==i, day_range_past_85)]
            current_future_85 = period_15_days_future_85[findall(x->x==i, day_range_future_85)]
            append!(mean_per_15_days_past_85, mean(current_past_85)*100)
            append!(mean_per_15_days_future_85, mean(current_future_85)*100)
            append!(std_per_15_days_past_85, std(current_past_85)*100)
            append!(std_per_15_days_future_85, std(current_future_85)*100)
            current_past_45_pf = period_15_days_past_45_pf[findall(x->x==i, day_range_past_45_pf)]
            current_future_45_pf = period_15_days_future_45_pf[findall(x->x==i, day_range_future_45_pf)]
            append!(mean_per_15_days_past_45_pf, mean(current_past_45_pf)*100)
            append!(mean_per_15_days_future_45_pf, mean(current_future_45_pf)*100)
            append!(std_per_15_days_past_45_pf, std(current_past_45_pf)*100)
            append!(std_per_15_days_future_45_pf, std(current_future_45_pf)*100)
            current_past_85_pf = period_15_days_past_85_pf[findall(x->x==i, day_range_past_85_pf)]
            current_future_85_pf = period_15_days_future_85_pf[findall(x->x==i, day_range_future_85_pf)]
            append!(mean_per_15_days_past_85_pf, mean(current_past_85_pf)*100)
            append!(mean_per_15_days_future_85_pf, mean(current_future_85_pf)*100)
            append!(std_per_15_days_past_85_pf, std(current_past_85_pf)*100)
            append!(std_per_15_days_future_85_pf, std(current_future_85_pf)*100)

        end
        #print(size(mean_per_15_days_past))
        xaxix_days = collect(7.5:15:370)
        if errorbounds == true
            Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["black"], linewidth=3, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), markercolor=["black"], markersize=7, markerstrokecolor=["black"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Past")
            Plots.plot!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[2]], linewidth=3, ribbon=std_per_15_days_future_45, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), color=[Farben_45[2]], markersize=7, markerstrokecolor=[Farben_45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Future RCP 4.5")
            # Plots.plot!(mean_per_15_days_past_85, leg=false, size=(1500,800), linestyle = :dash, color=["grey"], linewidth=3)
            # scatter!(mean_per_15_days_past_85, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[2]], linewidth=3, ribbon=std_per_15_days_future_85, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), color=[Farben_85[2]], markersize=7, markerstrokecolor=[Farben_85[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Future RCP 8.5")

            Plots.plot!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["black"], linewidth=3, ribbon = (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2, leg=false, size=(1500,800), markercolor=["black"], markersize=7, markerstrokecolor=["black"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Past")
            Plots.plot!(xaxix_days, mean_per_15_days_future_45_pf, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[1]], linewidth=3, ribbon=std_per_15_days_future_45_pf, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, mean_per_15_days_future_45_pf, leg=false, size=(1500,800), color=[Farben_45[1]], markersize=7, markerstrokecolor=[Farben_45[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Future RCP 4.5")
            # Plots.plot!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), linestyle = :dash, color=["grey"], linewidth=3)
            # scatter!(mean_per_15_days_past_85_pf, leg=false, size=(1500,800), markercolor=["grey"], markersize=7, markerstrokecolor=["grey"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85_pf, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[1]], linewidth=3, ribbon=std_per_15_days_future_85_pf, fillalpha=.2,  label=:none)
            scatter!(xaxix_days, mean_per_15_days_future_85_pf, leg=false, size=(1500,800), color=[Farben_85[1]], markersize=7, markerstrokecolor=[Farben_85[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60, label="Future RCP 8.5")

        elseif errorbounds == false
            Plots.plot!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), linestyle = :dash, color=["black"], linewidth=3, label=:none)#, ribbon = (std_per_15_days_past_45+std_per_15_days_past_85) / 2, fillalpha=.3)
            scatter!(xaxix_days, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2, leg=false, size=(1500,800), markercolor=["black"], markersize=7, markerstrokecolor=["black"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_45[2]], linewidth=3,  label=:none)#, ribbon=std_per_15_days_future_45, fillalpha=.3)
            scatter!(xaxix_days, mean_per_15_days_future_45, leg=false, size=(1500,800), color=[Farben_45[2]], markersize=7, markerstrokecolor=[Farben_45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            Plots.plot!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), linestyle = :dash,color=[Farben_85[2]], linewidth=3,  label=:none)#, ribbon=std_per_15_days_future_85, fillalpha=.3)
            scatter!(xaxix_days, mean_per_15_days_future_85, leg=false, size=(1500,800), color=[Farben_85[2]], markersize=7, markerstrokecolor=[Farben_85[2]])#, left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        end

        #ylabel!("[%]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Palten ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        ylims!((0,41))
        yticks!([0:5:40;])
        xticks!([15, 45, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        xlims!((1,370))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        push!(all_boxplots, box)

        mean_per_15days_past = hcat(mean_per_15days_past, (mean_per_15_days_past_45+mean_per_15_days_past_85) / 2)
        mean_per_15days_future_45 = hcat(mean_per_15days_future_45, mean_per_15_days_future_45)
        mean_per_15days_future_85 = hcat(mean_per_15days_future_85, mean_per_15_days_future_85)
        mean_per_15days_past_pf = hcat(mean_per_15days_past_pf, (mean_per_15_days_past_45_pf+mean_per_15_days_past_85_pf) / 2)
        mean_per_15days_future_45_pf = hcat(mean_per_15days_future_45_pf, mean_per_15_days_future_45_pf)
        mean_per_15days_future_85_pf = hcat(mean_per_15days_future_85_pf, mean_per_15_days_future_85_pf)
        std_per_15days_past = hcat(std_per_15days_past, (std_per_15_days_past_45+std_per_15_days_past_85) / 2)
        std_per_15days_future_45 = hcat(std_per_15days_future_45, std_per_15_days_future_45)
        std_per_15days_future_85 = hcat(std_per_15days_future_85, std_per_15_days_future_85)
        std_per_15days_past_pf = hcat(std_per_15days_past_pf, (std_per_15_days_past_45_pf+std_per_15_days_past_85_pf) / 2)
        std_per_15days_future_45_pf = hcat(std_per_15days_future_45_pf, std_per_15_days_future_45_pf)
        std_per_15days_future_85_pf = hcat(std_per_15days_future_85_pf, std_per_15_days_future_85_pf)


    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=true, legendfontsize= 12, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, legendfont = font(16))#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    # if errorbounds == true
    #     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_with_std_legend.png")
    # else
    #     Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_all_catchments_without_std_past.png")
    # end
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/AMF_timing_mean_plot.png")
    println(size(mean_per_15days_past))
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_mean_past_tot.csv", mean_per_15days_past[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_mean_future_45_tot.csv", mean_per_15days_future_45[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_mean_future_85_tot.csv", mean_per_15days_future_85[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_mean_past_tot.csv", mean_per_15days_past_pf[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_mean_future_45_tot.csv", mean_per_15days_future_45_pf[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_mean_future_85_tot.csv", mean_per_15days_future_85_pf[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_std_past_tot.csv", std_per_15days_past[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_std_future_45_tot.csv", std_per_15days_future_45[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/NS_AMF_timing_std_future_85_tot.csv", std_per_15days_future_85[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_std_past_tot.csv", std_per_15days_past_pf[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_std_future_45_tot.csv", std_per_15days_future_45_pf[:,2:end])
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/PforF_AMF_timing_std_future_85_tot.csv", std_per_15days_future_85_pf[:,2:end])


end

# plot_timing_changes_AMF_all_Catchments_fraction(Catchment_Names, Catchment_Height, nr_runs, "45")
# plot_timing_changes_AMF_all_Catchments_fraction_new(Catchment_Names, Catchment_Height, nr_runs, "85")
function plot_magnitude_changes_AMF_all_catchments_scatter(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    all_scatterplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_4.5.txt",',')
        average_max_Discharge_past_45 = annual_max_flow_45[:,1]
        average_max_Discharge_future_45 = annual_max_flow_45[:,2]
        average_max_Discharge_past_45 = convertDischarge(average_max_Discharge_past_45, Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(average_max_Discharge_future_45, Area_Catchments[i])
        Plots.plot()
        current_plot = scatter!(average_max_Discharge_past_45, average_max_Discharge_future_45,color=[Farben_85[2]],leg=false, alpha=0.3,markerstrokewidth= 0, minorticks=true, framestyle = :box)
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(average_max_Discharge_past_45), minimum(average_max_Discharge_future_45))
        max_value = max(maximum(average_max_Discharge_past_45), maximum(average_max_Discharge_future_45))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"])
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), legend = false, left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), size=(2000,3000))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/max_annual_discharges_magnitude_scatter_45_new.png")
    all_scatterplots = []
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_8.5.txt",',')
        average_max_Discharge_past_45 = annual_max_flow_45[:,1]
        average_max_Discharge_future_45 = annual_max_flow_45[:,2]
        average_max_Discharge_past_45 = convertDischarge(average_max_Discharge_past_45, Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(average_max_Discharge_future_45, Area_Catchments[i])
        Plots.plot()
        current_plot = scatter!(average_max_Discharge_past_45, average_max_Discharge_future_45,color=[Farben_45[2]],leg=false, alpha=0.3, markerstrokewidth= 0,minorticks=true, framestyle = :box)
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(average_max_Discharge_past_45), minimum(average_max_Discharge_future_45))
        max_value = max(maximum(average_max_Discharge_past_45), maximum(average_max_Discharge_future_45))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"])
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot85 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), legend = false, left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), size=(2000,3000))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/max_annual_discharges_magnitude_scatter_85.png")
end
function plot_magnitude_changes_AMF_all_catchments_scatter_gcm(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    all_scatterplots = []
    gcm_names = ["CNRM-CM5", "EC-EARTH", "CM5A-MR", "HadGEM2-ES", "MPI-ESM-LR"]
    Farben_gcm = ["green", Farben_85[2], Farben_45[2], "grey", "yellow"]
    simulation_start = [1,4,8,10,13]
    simulation_end = [3,7,9,12,14]
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_4.5.txt",',')
        average_max_Discharge_past_45 = annual_max_flow_45[:,1]
        average_max_Discharge_future_45 = annual_max_flow_45[:,2]
        average_max_Discharge_past_45 = convertDischarge(average_max_Discharge_past_45, Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(average_max_Discharge_future_45, Area_Catchments[i])
        Plots.plot()

        for gcm in 1:5
            println(simulation_start[gcm])
            println(simulation_start[gcm])
            scatter!(average_max_Discharge_past_45[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]], average_max_Discharge_future_45[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]],label = gcm_names[gcm], markerstrokewidth= 0, color =[Farben_gcm[gcm]], alpha=0.3, minorticks=true, framestyle = :box)
        end
        current_plot = scatter!()
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(average_max_Discharge_past_45), minimum(average_max_Discharge_future_45))
        max_value = max(maximum(average_max_Discharge_past_45), maximum(average_max_Discharge_future_45))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"], leg=false)
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, legend=:bottomright, xtickfont = font(20), ytickfont = font(20), size=(2000,3000), dpi=150)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/max_annual_discharges_magnitude_scatter_45_gcm.png")
    all_scatterplots = []
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        annual_max_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_8.5.txt",',')
        average_max_Discharge_past_45 = annual_max_flow_45[:,1]
        average_max_Discharge_future_45 = annual_max_flow_45[:,2]
        average_max_Discharge_past_45 = convertDischarge(average_max_Discharge_past_45, Area_Catchments[i])
        average_max_Discharge_future_45 = convertDischarge(average_max_Discharge_future_45, Area_Catchments[i])
        Plots.plot()
        for gcm in 1:5
            println(simulation_start[gcm])
            println(simulation_start[gcm])
            scatter!(average_max_Discharge_past_45[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]], average_max_Discharge_future_45[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]],label = gcm_names[gcm], markerstrokewidth= 0, color =[Farben_gcm[gcm]], alpha=0.3, minorticks=true, framestyle = :box)
        end
        current_plot = scatter!()
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(average_max_Discharge_past_45), minimum(average_max_Discharge_future_45))
        max_value = max(maximum(average_max_Discharge_past_45), maximum(average_max_Discharge_future_45))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"], leg=false)
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, legend=:bottomright, xtickfont = font(20), ytickfont = font(20), size=(2000,3000), dpi=150)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/max_annual_discharges_magnitude_scatter_85_gcm.png")
end
# plot_magnitude_changes_AMF_all_catchments_scatter(Catchment_Names, Catchment_Height, Area_Catchments, nr_runs)
# plot_magnitude_changes_AMF_all_catchments_scatter_gcm(Catchment_Names, Catchment_Height, Area_Catchments, nr_runs)

function plot_magnitude_changes_max_AMF_all_catchments_scatter_gcm(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    all_scatterplots = []
    gcm_names = ["CNRM-CM5", "EC-EARTH", "CM5A-MR", "HadGEM2-ES", "MPI-ESM-LR"]
    Farben_gcm = ["green", Farben_85[2], Farben_45[2], "grey", "yellow"]
    simulation_start = [1,4,8,10,13]
    simulation_end = [3,7,9,12,14]
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        max_Discharge_Past_45 = convertDischarge(max_Discharge_Past_45, Area_Catchments[i])
        max_Discharge_Future_45 = convertDischarge(max_Discharge_Future_45, Area_Catchments[i])
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        Plots.plot()

        for gcm in 1:5
            println(simulation_start[gcm])
            println(simulation_start[gcm])
            scatter!(max_discharge_past[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]], max_discharge_future[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]],label = gcm_names[gcm], markerstrokewidth= 0, color =[Farben_gcm[gcm]], alpha=0.3, minorticks=true, framestyle = :box)
        end
        current_plot = scatter!()
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(max_discharge_past), minimum(max_discharge_future))
        max_value = max(maximum(max_discharge_past), maximum(max_discharge_future))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"], leg=false)
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, legend=:bottomright, xtickfont = font(20), ytickfont = font(20), size=(2000,3000), dpi=150)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/HQmax_max_annual_discharges_magnitude_scatter_45_gcm.png")
    all_scatterplots = []
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        max_Discharge_Past_45 = convertDischarge(max_Discharge_Past_45, Area_Catchments[i])
        max_Discharge_Future_45 = convertDischarge(max_Discharge_Future_45, Area_Catchments[i])
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        Plots.plot()

        for gcm in 1:5
            println(simulation_start[gcm])
            println(simulation_start[gcm])
            scatter!(max_discharge_past[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]], max_discharge_future[1+(simulation_start[gcm]-1)*nr_runs[i]:simulation_end[gcm]*nr_runs[i]],label = gcm_names[gcm], markerstrokewidth= 0, color =[Farben_gcm[gcm]], alpha=0.3, minorticks=true, framestyle = :box)
        end
        current_plot = scatter!()
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(max_discharge_past), minimum(max_discharge_future))
        max_value = max(maximum(max_discharge_past), maximum(max_discharge_future))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"], leg=false)
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, legend=:bottomright, xtickfont = font(20), ytickfont = font(20), size=(2000,3000), dpi=150)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/HQ_max_max_annual_discharges_magnitude_scatter_85_gcm.png")
end

function plot_magnitude_changes_max_AMF_all_catchments_scatter(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    Plots.plot()
    all_scatterplots = []
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        max_Discharge_Past_45 = convertDischarge(max_Discharge_Past_45, Area_Catchments[i])
        max_Discharge_Future_45 = convertDischarge(max_Discharge_Future_45, Area_Catchments[i])
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        Plots.plot()
        current_plot = scatter!(max_discharge_past, max_discharge_future,color=[Farben_85[2]],leg=false, alpha=0.3,markerstrokewidth= 0, minorticks=true, framestyle = :box)
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(max_discharge_past), minimum(max_discharge_future))
        max_value = max(maximum(max_discharge_past), maximum(max_discharge_future))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"])
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot45 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), legend = false, left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), size=(2000,3000))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/maxHQ_max_annual_discharges_magnitude_scatter_45_new.png")
    all_scatterplots = []
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt",',')
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        max_Discharge_Past_45 = convertDischarge(max_Discharge_Past_45, Area_Catchments[i])
        max_Discharge_Future_45 = convertDischarge(max_Discharge_Future_45, Area_Catchments[i])
        max_discharge_past = Float64[]
        max_discharge_future = Float64[]
        for run in 1:14*nr_runs[i]
            append!(max_discharge_past, maximum(max_Discharge_Past_45[1+(run-1)*30:30*run]))
            append!(max_discharge_future, maximum(max_Discharge_Future_45[1+(run-1)*30:30*run]))
        end
        Plots.plot()
        current_plot = scatter!(max_discharge_past, max_discharge_future,color=[Farben_45[2]],leg=false, alpha=0.3,markerstrokewidth= 0, minorticks=true, framestyle = :box)
        ylabel!("Future")
        xlabel!("Past")
        # ylims!((0,20))
        # yticks!([0:5:20;])
        # xlims!((0,20))
        # xticks!([0:5:20;])
        min_value = min(minimum(max_discharge_past), minimum(max_discharge_future))
        max_value = max(maximum(max_discharge_past), maximum(max_discharge_future))
        Plots.plot!([min_value,max_value],[min_value,max_value], color=["black"])
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)")
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)")
        end
        push!(all_scatterplots, current_plot)
        #title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
    end
    plot85 = Plots.plot(all_scatterplots[1], all_scatterplots[2], all_scatterplots[3], all_scatterplots[4], all_scatterplots[5], all_scatterplots[6], layout= (3,2), legend = false, left_margin = [5mm 0mm], xguidefontsize=20, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), size=(2000,3000))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/maxHQ_max_annual_discharges_magnitude_scatter_85.png")
end

# plot_magnitude_changes_max_AMF_all_catchments_scatter(Catchment_Names, Catchment_Height, Area_Catchments, nr_runs)
# plot_magnitude_changes_max_AMF_all_catchments_scatter_gcm(Catchment_Names, Catchment_Height, Area_Catchments, nr_runs)



function plot_magnitude_AMF_return_periods(All_Catchment_Names, Elevation, Area_Catchments, type, change)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_4.5.txt", ',')
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/change_max_Annual_Discharge_prob_distr_8.5.txt", ',')
        Farben_45= palette(:reds)
        Farben_85= palette(:blues)

        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        Max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        Max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        Plots.plot()
        mean_change = Float64[]
        mean_past = Float64[]
        mean_change_85 = Float64[]
        std_change_45 = Float64[]
        std_change_85 = Float64[]
        std_past = Float64[]
        for exceedance in Exceedance_Probability_45[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45)

            past_45 = convertDischarge(max_Discharge_Past_45[index], Area_Catchments[j])
            future_45 = convertDischarge(Max_Discharge_Future_45[index], Area_Catchments[j])
            past_85 = convertDischarge(max_Discharge_Past_85[index], Area_Catchments[j])
            future_85 = convertDischarge(Max_Discharge_Future_85[index], Area_Catchments[j])

            append!(mean_past, (mean(past_45) + mean(past_85)) /2)
            append!(mean_change, mean(future_45))
            # append!(max_change, maximum(change_45))
            # append!(min_change, minimum(change_45))
            append!(mean_change_85, mean(future_85))
            # append!(max_change_85, maximum(change_85))
            # append!(min_change_85, minimum(change_85))
            append!(std_change_45, std(future_45))
            append!(std_change_85, std(future_85))
            append!(std_past, (std(past_45) + std(past_85)) /2)
        end
        Plots.plot()
        return_period = (31 ./ collect(1:30))

        percentage = (collect(1/31:1/31:30/31)*100)
        if type == "percentage"
            Plots.plot(percentage, (mean_past), color=["black"], label="past", ribbon = std_past, linewidth=3, fillalpha=.3)
            Plots.plot!(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", ribbon = std_change_45, linewidth=3, fillalpha=.3)
            Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", ribbon = std_change_85, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)
            # Plots.plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", linewidth=3)
            # Plots.plot!(percentage, mean_change - std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # Plots.plot!(percentage, mean_change + std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", size=(1500,800), xflip=true, linewidth=3)
            # Plots.plot!(percentage, mean_change_85 - std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            # Plots.plot!(percentage, mean_change_85 + std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            ylabel!("[%]", yguidefontsize=12)
            xlabel!("Exceedance Probability [%]", xguidefontsize=12)
            if Catchment_Name == "Pitztal"
                ylims!((-30,130))
                yticks!([-20:20:130;])
            else
                ylims!((-30,90))
                yticks!([-20:10:90;])
            end
        elseif type == "return period"
            Plots.plot(return_period, (mean_past), color=["black"], label="past", linestyle = :dot,ribbon = std_past, linewidth=3, fillalpha=.3)
            Plots.plot!(return_period, (mean_change), color=[Farben45[2]], label="RCP 4.5", linestyle = :dot,  ribbon = std_change_45, linewidth=3, fillalpha=.3)
            Plots.plot!(return_period, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", linestyle = :dot, size=(1500,800), ribbon = std_change_85, linewidth=3, fillalpha=.3)
            scatter!(return_period, (mean_past), color=["black"], label="RCP 4.5", markersize=6, markerstrokewidth= 0)
            scatter!(return_period, (mean_change), color=[Farben45[2]], label="RCP 4.5", markersize=6, markerstrokewidth= 0)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85), color=[Farben85[2]], label="RCP 8.5",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
            xlabel!("Return period [yrs]", xguidefontsize=12)
            xticks!([1,2,5,10,20,30], ["1", "2", "5", "10", "20", "30"])


        end

        title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [20mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_magnitude_all_Catchments_all_years_return_period_log_past_future.png")
end

function plot_changes_magnitude_AMF_return_periods_sarah(All_Catchment_Names, Elevation, Area_Catchments, type, change)
    all_boxplots = []
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')[1:12*14*2950,:]
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/NS_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')[1:12*14*2950,:]
        Farben_45= palette(:reds)
        Farben_85= palette(:blues)
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        Max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        Max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        plot()
        mean_change = Float64[]
        max_change = Float64[]
        min_change = Float64[]
        mean_change_85 = Float64[]
        max_change_85 = Float64[]
        min_change_85 = Float64[]
        std_change_45 = Float64[]
        std_change_85 = Float64[]
        for exceedance in Exceedance_Probability_45[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45)
            index_ = findall(x->x == exceedance, Exceedance_Probability_85)

            if change == "relative"
                change_45 = relative_error(Max_Discharge_Future_45[index], max_Discharge_Past_45[index])*100
                change_85 = relative_error(Max_Discharge_Future_85[index_], max_Discharge_Past_85[index_])*100
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
            elseif change === "absolute"
                change_45 = convertDischarge(Max_Discharge_Future_45[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45[index], Area_Catchments[j])
                change_85 = convertDischarge(Max_Discharge_Future_85[index_], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85[index_], Area_Catchments[j])
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
            end
        end

        max_discharge_prob_45_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_4.5.txt", ',')[1:12*14*2950,:]
        max_discharge_prob_85_pf = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Annual_Max_Discharge/PforF_change_max_Annual_Discharge_prob_distr_8.5.txt", ',')[1:12*14*2950,:]
        max_Discharge_Past_45_pf = max_discharge_prob_45_pf[:,1]
        Max_Discharge_Future_45_pf = max_discharge_prob_45_pf[:,2]
        Exceedance_Probability_45_pf = max_discharge_prob_45_pf[:,3]
        max_Discharge_Past_85_pf = max_discharge_prob_85_pf[:,1]
        Max_Discharge_Future_85_pf = max_discharge_prob_85_pf[:,2]
        Exceedance_Probability_85_pf = max_discharge_prob_85_pf[:,3]
        plot()
        mean_change_pf = Float64[]
        max_change_pf = Float64[]
        min_change_pf = Float64[]
        mean_change_85_pf = Float64[]
        max_change_85_pf = Float64[]
        min_change_85_pf = Float64[]
        std_change_45_pf = Float64[]
        std_change_85_pf = Float64[]
        for exceedance in Exceedance_Probability_45_pf[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45_pf)
            index_ = findall(x->x == exceedance, Exceedance_Probability_85_pf)

            if change == "relative"
                change_45_pf = relative_error(Max_Discharge_Future_45_pf[index], max_Discharge_Past_45_pf[index])*100
                change_85_pf = relative_error(Max_Discharge_Future_85_pf[index_], max_Discharge_Past_85_pf[index_])*100
                append!(mean_change_pf, mean(change_45_pf))
                append!(max_change_pf, maximum(change_45_pf))
                append!(min_change_pf, minimum(change_45_pf))
                append!(mean_change_85_pf, mean(change_85_pf))
                append!(max_change_85_pf, maximum(change_85_pf))
                append!(min_change_85_pf, minimum(change_85_pf))
                append!(std_change_45_pf, std(change_45_pf))
                append!(std_change_85_pf, std(change_85_pf))
            elseif change === "absolute"
                change_45_pf = convertDischarge(Max_Discharge_Future_45_pf[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45_pf[index], Area_Catchments[j])
                change_85_pf = convertDischarge(Max_Discharge_Future_85_pf[index_], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85_pf[index_], Area_Catchments[j])
                append!(mean_change_pf, mean(change_45_pf))
                append!(max_change_pf, maximum(change_45_pf))
                append!(min_change_pf, minimum(change_45_pf))
                append!(mean_change_85_pf, mean(change_85_pf))
                append!(max_change_85_pf, maximum(change_85_pf))
                append!(min_change_85_pf, minimum(change_85_pf))
                append!(std_change_45_pf, std(change_45_pf))
                append!(std_change_85_pf, std(change_85_pf))
            end
        end

        plot()
        return_period = (31 ./ collect(1:30))

        percentage = (collect(1/31:1/31:30/31)*100)
        if type == "percentage"
            plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", ribbon = std_change_45, linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", ribbon = std_change_85, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_pf), color=Farben_45[1], label="RCP 4.5", ribbon = std_change_45_pf, linewidth=3, fillalpha=.3)
            plot!(percentage, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5", ribbon = std_change_85_pf, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)

            # plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", linewidth=3)
            # plot!(percentage, mean_change - std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # plot!(percentage, mean_change + std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", size=(1500,800), xflip=true, linewidth=3)
            # plot!(percentage, mean_change_85 - std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            # plot!(percentage, mean_change_85 + std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            ylabel!("[%]", yguidefontsize=12)
            xlabel!("Exceedance Probability [%]", xguidefontsize=12)
            if Catchment_Name == "Pitztal"
                ylims!((-30,130))
                yticks!([-20:20:130;])
            else
                ylims!((-30,90))
                yticks!([-20:10:90;])
            end
        elseif type == "return period"
            plot(return_period, (mean_change), color=[Farben45[2]], label=false, linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45, xticks=:none, yticks=:none)#ribbon = (mean_change-min_change, max_change - mean_change))#
            plot!(return_period, (mean_change_85), color=[Farben85[2]], label=false, linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85,xticks=:none, yticks=:none)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
            scatter!(return_period, (mean_change), color=[Farben45[2]], label=false, markersize=7, markerstrokewidth= 0,xticks=:none, yticks=:none)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85), color=[Farben85[2]], label=false,size=(1500,800), markersize=7, markerstrokewidth= 0, xscale=:log10,xticks=:none, yticks=:none)#, ribbon = std_change_85)
            plot!(return_period, (mean_change_pf), color=Farben_45[1], label=false, linestyle = :dot,  linewidth=3, fillalpha=.3, ribbon= std_change_45_pf,xticks=:none, yticks=:none)#ribbon = (mean_change-min_change, max_change - mean_change))#
            plot!(return_period, (mean_change_85_pf), color=Farben_85[1], label=false, linestyle = :dot, size=(1500,800), linewidth=3, fillalpha=.3, ribbon = std_change_85_pf,xticks=:none, yticks=:none)#ribbon = (mean_change_85-min_change_85, max_change_85 - mean_change_85))#
            scatter!(return_period, (mean_change_pf), color=Farben_45[1], label=false, markersize=6, markerstrokewidth= 0,xticks=:none, yticks=:none)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label=false,size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10,xticks=:none, yticks=:none)#, ribbon = std_change_85)
            if j==1
                scatter!(return_period, (mean_change_pf), color=Farben_45[1], label="RCP 4.5 Cl,clim,stat", markersize=6, markerstrokewidth= 0,xticks=:none, yticks=:none)#, ribbon = std_change_45)
                scatter!(return_period, (mean_change), color=[Farben45[2]], label="RCP 4.5 Cl,clim,adapt", markersize=6, markerstrokewidth= 0,xticks=:none, yticks=:none)#, ribbon = std_change_45)
                scatter!(return_period, (mean_change_85_pf), color=Farben_85[1], label="RCP 8.5 Cl,clim,stat",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10,xticks=:none, yticks=:none)#, ribbon = std_change_85)
                scatter!(return_period, (mean_change_85), color=[Farben85[2]], label="RCP 8.5 Cl,clim,adapt",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10,xticks=:none, yticks=:none)#, ribbon = std_change_85)
            end
            if change == "relative"
                ylabel!("[%]", yguidefontsize=12)
                ylims!((-30,90))
                yticks!([-20:20:80;])
            elseif change == "absolute"
                if j==3
                    ylabel!("Absolute change in magnitude of AMF [mm/d]", yguidefontsize=12)
                end
                if Catchment_Name == "Gailtal"
                    ylims!((-10,20))
                    yticks!([-10:5:20;])
                else
                    ylims!((-1.5,6))
                    yticks!([-1:1:6;])
                end
            end
            if j==5||j==6
                xlabel!("Return period [yrs]", xguidefontsize=12)
                xticks!([1,2,5,10,20,30], ["1", "2", "5", "10", "20", "30"])
            end

        end

        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = plot!(left_margin = [20mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        push!(all_boxplots, box)
    end
    plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=:topright, legendfontsize= 12, size=(2200,1500), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Max_Discharge/AMF_magnitude_all_Catchments_all_years_return_period_ribbon_min_max.png")
end
# plot_changes_magnitude_AMF_return_periods_sarah(Catchment_Names_new, Catchment_Height, Area_Catchments, "return period", "absolute")
# plot_magnitude_AMF_return_periods(Catchment_Names, Catchment_Height, Area_Catchments, "return period", "absolute")
# plot_magnitude_AMF_return_periods(Catchment_Names_new, Catchment_Height, Area_Catchments, "return period", "absolute")
#------------------- LOW FLOWS --------------------------

function plot_monthly_deficit_all_catchments(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)

    all_boxplots = []
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    all_info = zeros(12)
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        months = repeat([1,2,3,4,5,6,7,8,9,10,11,12],14*nr_runs[j])
        Deficits_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/monthly_days_deficit_Q90_4.5.txt", ',')
        Deficits_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Drought/monthly_days_deficit_Q90_8.5.txt", ',')
        Deficit_monthly_past_45 = Deficits_45[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_45 = Deficits_45[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_45 = Deficits_45[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        Deficit_monthly_past_85 = Deficits_85[:,14*nr_runs[j]*2+1:14*nr_runs[j]*3]
        Deficit_monthly_future_85 = Deficits_85[:,14*nr_runs[j]*3+1:14*nr_runs[j]*4]
        Threshold_85 = Deficits_85[:,14*nr_runs[j]*4+1:14*nr_runs[j]*5]
        println(size(Deficit_monthly_past_45), size(Deficit_monthly_future_45))
        # Deficit_monthly_past_45 = Deficit_monthly_past_45 ./ Threshold_45
        # Deficit_monthly_future_45 = Deficit_monthly_future_45 ./ Threshold_45
        # Deficit_monthly_past_85 = Deficit_monthly_past_85 ./ Threshold_85
        # Deficit_monthly_future_85 = Deficit_monthly_future_85 ./ Threshold_85
        # plot
        Plots.plot()
        change_45 = []
        change_85 = []
        for month in 1:12
            append!(change_45,median(Deficit_monthly_future_45[findall(x-> x == month, months)] - Deficit_monthly_past_45[findall(x-> x == month, months)]))
            append!(change_85,median(Deficit_monthly_future_85[findall(x-> x == month, months)] - Deficit_monthly_past_85[findall(x-> x == month, months)]))
            boxplot!([xaxis_45[month]], Deficit_monthly_future_45[findall(x-> x == month, months)] - Deficit_monthly_past_45[findall(x-> x == month, months)], size=(2000,800), leg=false, color=Farben_85[2], outliers=false)
            boxplot!([xaxis_85[month]],Deficit_monthly_future_85[findall(x-> x == month, months)] - Deficit_monthly_past_85[findall(x-> x == month, months)], size=(2000,800), leg=false, color=Farben_45[2], left_margin = [5mm 0mm], outliers=false)
        end
        # hline!([0], color=["grey"], linestyle = :dash)
        # #ylabel!("Change in Mean Deficit [mm]")
        #
        # ylabel!("[mm]", yguidefontsize=12)
        # #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        # if Catchment_Name == "Pitten"
        #     title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        # elseif Catchment_Name == "IllSugadin"
        #     title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        # else
        #     title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        # end
        # #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        # if Catchment_Name == "Defreggental" || Catchment_Name == "Pitztal"
        #     ylims!((0,1.5))
        #     yticks!([-0:0.5:1.5;])
        # else
        #     ylims!((0,4))
        #     yticks!([-0:1:4;])
        # end
        # xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        # xlims!((0,25))
        # #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        # box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        # push!(all_boxplots, box)
        all_info = hcat(all_info, change_45)
        all_info = hcat(all_info, change_85)
    end
    # Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Drought_Monthly_Deficit_Q90_no_outliers_new.png")
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/median_change_deficit_low_flows_without_loss.csv", all_info)
end


# plot_monthly_deficit_all_catchments(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)

function calculate_Q90_Prec_all_catchments_PforF(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
    # Catchment_Name = "Pitztal"
    # i = 6
        if i==6
            path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
            Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation_PforF(path_45, Area_Catchments[i], Catchment_Name)
            writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100,',')
            # if Catchment_Name == "Pitten"
            #     Catchment_Name = "Feistritz"
            # elseif Catchment_Name == "IllSugadin"
            #     Catchment_Name = "Silbertal"
            # end
            # violin!([Catchment_Name], relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            # boxplot!([Catchment_Name], relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            # #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
            # #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
            # #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
            # # ylims!((-35,35))
            # # yticks!([-35:10:35;])
            # hline!([0], color=["grey"], linestyle = :dash)
            # #ylabel!("Relative Change in Average Annual Discharge [%]")
            # ylabel!("absolute change Q90/P")
            # title!("Absolute Change in for RCP 4.5")
        #end
        # box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
        # Plots.plot()
        # for (i,Catchment_Name) in enumerate(All_Catchment_Names)
            path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
            Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation_PforF(path_85, Area_Catchments[i], Catchment_Name)
            writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100,',')
    #     if Catchment_Name == "Pitten"
    #         Catchment_Name = "Feistritz"
    #     elseif Catchment_Name == "IllSugadin"
    #         Catchment_Name = "Silbertal"
    #     end
    #     violin!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
    #     boxplot!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
    #     println(Catchment_Name)
    #     println("45 ", relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100)
    #     println("85 ", relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100)
    #     #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
    #     #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
    #     #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
    #     # ylims!((-35,35))
    #     # yticks!([-35:10:35;])
    #     hline!([0], color=["grey"], linestyle = :dash)
    #     #ylabel!("Relative Change in Average Annual Discharge [%]")
    #     ylabel!("absolute change Q90/P")
    #     title!("Absolute Change in for RCP 8.5")
        end
    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end

function calculate_Q90_Prec_all_catchments_NS(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
    # Catchment_Name = "Pitztal"
    # i = 6
        println(Catchment_Name)
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        Q90_Prec_Past45, Q90_Prec_Future45 = Q90_precipitation(path_45, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100,',')
        # if Catchment_Name == "Pitten"
        #     Catchment_Name = "Feistritz"
        # elseif Catchment_Name == "IllSugadin"
        #     Catchment_Name = "Silbertal"
        # end
        # violin!([Catchment_Name], relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        # boxplot!([Catchment_Name], relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
        # #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
        # #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
        # #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
        # # ylims!((-35,35))
        # # yticks!([-35:10:35;])
        # hline!([0], color=["grey"], linestyle = :dash)
        # #ylabel!("Relative Change in Average Annual Discharge [%]")
        # ylabel!("absolute change Q90/P")
        # title!("Absolute Change in for RCP 4.5")
    #end
    # box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot()
    # for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Q90_Prec_Past85, Q90_Prec_Future85 = Q90_precipitation(path_85, Area_Catchments[i], Catchment_Name)
        writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100,',')
    #     if Catchment_Name == "Pitten"
    #         Catchment_Name = "Feistritz"
    #     elseif Catchment_Name == "IllSugadin"
    #         Catchment_Name = "Silbertal"
    #     end
    #     violin!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
    #     boxplot!([Catchment_Name], relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
    #     println(Catchment_Name)
    #     println("45 ", relative_error(Q90_Prec_Future45, Q90_Prec_Past45)*100)
    #     println("85 ", relative_error(Q90_Prec_Future85, Q90_Prec_Past85)*100)
    #     #boxplot!([rcps[2]], relative_change_85*100, size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]])
    #     #violin!([rcps[1]], relative_change_45*100, size=(2000,800), leg=false, color=[Farben45[2]], alpha=0.3)
    #     #violin!([rcps[2]], relative_change_85*100,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=[Farben85[2]], alpha=0.3)
    #     # ylims!((-35,35))
    #     # yticks!([-35:10:35;])
    #     hline!([0], color=["grey"], linestyle = :dash)
    #     #ylabel!("Relative Change in Average Annual Discharge [%]")
    #     ylabel!("absolute change Q90/P")
    #     title!("Absolute Change in for RCP 8.5")
    end
    # box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    # Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    #
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q95__all_catchments_45_85_rel_change.png")
end


function plot_Q90_Prec_all_catchments_NS(All_Catchment_Names, Elevation, Area_Catchments, nr_runs)
    all_boxplots=[]
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)

        Plots.plot()
        RE_Q90_NS_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_4.5_Prec.txt",',')
        RE_Q90_NS_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/NS_Q90_8.5_Prec.txt",',')
        RE_Q90_PforF_45=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_4.5_Prec.txt",',')
        RE_Q90_PforF_85=readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/PforF_Q90_8.5_Prec.txt",',')


        # if Catchment_Name == "Pitten"
        #     Catchment_Name = "Feistritz"
        # elseif Catchment_Name == "IllSugadin"
        #     Catchment_Name = "Silbertal"
        # end
        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end
        # violin!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100,color=[Farben_85[2]])
        # boxplot!([Catchment_Name], relative_error(average_max_Discharge_future_45, average_max_Discharge_past_45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3, minorticks=true)
        # if i!=6
            violin!([1], RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none, label=false)
            violin!([2], RE_Q90_NS_45[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label=false)
            violin!([3], RE_Q90_PforF_85[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label=false)
            violin!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label=false)
        # else
        if i==6
            scatter!([1],  RE_Q90_PforF_45[:,1],color=[Farben_45[1]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([2],  RE_Q90_NS_85[:,1],color=[Farben_45[2]], xticks=:none,yticks=:none,label="RCP 4.5 Sr,clim,adapt", markerstrokewidth=0)
            scatter!([3], RE_Q90_NS_45[:,1],color=[Farben_85[1]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,stat", markerstrokewidth=0)
            scatter!([4], RE_Q90_NS_85[:,1],color=[Farben_85[2]], xticks=:none,yticks=:none,label="RCP 8.5 Sr,clim,adapt", markerstrokewidth=0)
        end
        println(size(RE_Q90_PforF_85)[1])
        # for j in 1:size(RE_Q90_PforF_85)[1]
        # scatter!([ones(length(RE_Q90_PforF_85))], [RE_Q90_PforF_45[:,1]],color=["black"], markersize=5, markershape=:circle, xticks=:none,yticks=:none, label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*2], [RE_Q90_NS_45[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*3], [RE_Q90_PforF_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)
        # scatter!([ones(length(RE_Q90_PforF_85)).*4], [RE_Q90_NS_85[:,1]],color=["black"], markersize=5, markershape=:circle,xticks=:none,yticks=:none,label=false)

        ylims!((-55,80))
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px )
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[i])*"m)", titlefont = font(20),margin=10px)
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20), margin=10px)
        end
        # xticks!([1:1:4;], ["RCP 4.5 Sr,clim,stat","RCP 4.5 Sr,clim,adapt","RCP 8.5 Sr,clim,stat","RCP 8.5 Sr,clim,adapt"])
        if i==1 || i==4
            ylabel!("∆Q90 [%]")
            # yticks!([-50:25:75;])
        end
        if i in 1:3
            ylims!((-45,65))
            yticks!([-40:20:60;])
        else
            ylims!((-30,130))
            yticks!([-20:20:120;])
        end
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # title!("Relative Change in Average Magnitude of Maximum Annual Flow for RCP 4.5")
        box_85 = boxplot!(left_margin = [20mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, legendfontsize=20, legend=:bottomright)
        push!(all_boxplots,box_85)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2],all_boxplots[3],all_boxplots[4],all_boxplots[5],all_boxplots[6], layout=(2,3), size=(2200,1200), minorgrid = true, minorgridlinewidth=2, framestyle = :box, left_margin=[20mm 0mm 0mm])
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/Q90_all_catchments_45_85_relative.png")

end


# calculate_Q90_Prec_all_catchments_PforF(Catchment_Names_new, Catchment_Height, Area_Catchments, nr_runs_new)

# plot the change in timing and magnitude of average yearly 7 day discharge

function plot_magnitude_low_flows(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change)
    Plots.plot()
    xaxis = collect(1:12)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year4.5.txt",',')
        Low_Flows_past45 = low_flow_45[:,1]
        Low_Flows_future45 = low_flow_45[:,2]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year8.5.txt",',')
        Low_Flows_past85 = low_flow_85[:,1]
        Low_Flows_future85 = low_flow_85[:,2]

        if change == "relative"
            violin!([xaxis[i*2-1]], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2-1]], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            violin!([xaxis[i*2]], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2]], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
            ylabel!("Relative change [%]")

        elseif change == "absolute"
            violin!([xaxis[i*2-1]], (Low_Flows_future45 - Low_Flows_past45), size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2-1]], (Low_Flows_future45 - Low_Flows_past45), size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            violin!([xaxis[i*2]], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2]], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
            # println(Catchment_Name)
            # println("Change 45 ", median((Low_Flows_future45 - Low_Flows_past45)))
            # println("Change 85 ", median((Low_Flows_future85 - Low_Flows_past85)))
            ylabel!("Absolute change  [mm]")

        end
        # ylims!((-35,35))
        # yticks!([-35:10:35;])
        hline!([0], color=["grey"], linestyle = :dash)
        #ylabel!("Relative Change in Average Annual Discharge [%]")
        title!("Magnitude 7day low flow")
    end
    box_magnitude = boxplot!(left_margin = [20mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, size=(2200,1200))

    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year4.5.txt",',')
        Timing_Low_Flows_Past_45  = low_flow_45[:,3]
        Timing_Low_Flows_Future_45  = low_flow_45[:,4]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year8.5.txt",',')
        Timing_Low_Flows_Past_85  = low_flow_85[:,3]
        Timing_Low_Flows_Future_85  = low_flow_85[:,4]
        # for timing it has to be considered that year is circular
        Timing_abs_change_85 = Timing_Low_Flows_Future_85 - Timing_Low_Flows_Past_85
        # find all values with change slarger than half a year
        too_large = findall(x->x> 183, Timing_abs_change_85)
        too_small = findall(x->x< -183, Timing_abs_change_85)
        # println(Catchment_Name)
        # println("timing highest", Timing_abs_change_85[1595])
        # println("max ", argmax(Timing_abs_change_85)," ", maximum(Timing_abs_change_85))
        # println(maximum(Timing_abs_change_85[too_large])," ", minimum(Timing_abs_change_85[too_large]))
        # if there are changes larger than half a year change them to changes less than half a year
        if too_large != Int64[]
            Timing_abs_change_85[too_large] = -(365 .- Timing_Low_Flows_Future_85[too_large] .+  Timing_Low_Flows_Past_85[too_large])
        end

        # println("extreme ", Timing_Low_Flows_Future_85[1595], " ", Timing_Low_Flows_Past_85[1595])
        # println(maximum(Timing_abs_change_85[too_small]), minimum(Timing_abs_change_85[too_small]))
        if too_small != Int64[]
            Timing_abs_change_85[too_small] = (365 .- Timing_Low_Flows_Past_85[too_small] .+  Timing_Low_Flows_Future_85[too_small])
            print("index ", too_small, "before ", Timing_abs_change_85[too_small], )
        end
        # println(maximum(Timing_abs_change_85[too_small]), minimum(Timing_abs_change_85[too_small]))
        # println("max ", argmax(Timing_abs_change_85)," ", maximum(Timing_abs_change_85))
        #break

        Timing_abs_change_45 = Timing_Low_Flows_Future_45 - Timing_Low_Flows_Past_45
        too_large = findall(x->x> 182, Timing_abs_change_45)
        too_small = findall(x->x< -182, Timing_abs_change_45)
        if too_large != Int64[]
            Timing_abs_change_45[too_large] = -(365 .- Timing_Low_Flows_Future_45[too_large] +  Timing_Low_Flows_Past_45[too_large])
        end
        if too_small != Int64[]
            Timing_abs_change_45[too_small] = (365 .- Timing_Low_Flows_Past_45[too_small] +  Timing_Low_Flows_Future_45[too_small])
        end
        violin!([xaxis[i*2-1]], Timing_abs_change_45, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        boxplot!([xaxis[i*2-1]], Timing_abs_change_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
        violin!([xaxis[i*2]], Timing_abs_change_85, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        boxplot!([xaxis[i*2]], Timing_abs_change_85, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
        # ylims!((-35,35))
        # yticks!([-35:10:35;])
        hline!([0], color=["grey"], linestyle = :dash)
        #ylabel!("Relative Change in Average Annual Discharge [%]")
        ylabel!("Absolute change [days]")
        title!("Timing 7day low flow")
    end
    xticks!([1.5:2:11.5;], ["Feistritztal", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal"])
    box_timing = boxplot!(left_margin = [20mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, size=(2200,1200))

    Plots.plot(box_magnitude ,box_timing, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/low_flows_magnitude_"*change*"_change_timing_withous_loss.png")
end
function plot_magnitude_low_flows_Q90(All_Catchment_Names, Elevation, Area_Catchments, nr_runs, change)
    Plots.plot()
    xaxis = collect(1:12)
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year4.5.txt",',')
        Low_Flows_past45 = low_flow_45[:,1]
        Low_Flows_future45 = low_flow_45[:,2]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year8.5.txt",',')
        Low_Flows_past85 = low_flow_85[:,1]
        Low_Flows_future85 = low_flow_85[:,2]

        if change == "relative"
            violin!([xaxis[i*2-1]], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2-1]], relative_error(Low_Flows_future45, Low_Flows_past45)*100, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            violin!([xaxis[i*2]], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2]], relative_error(Low_Flows_future85, Low_Flows_past85)*100, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
            ylabel!("Relative change [%]")

        elseif change == "absolute"
            violin!([xaxis[i*2-1]], (Low_Flows_future45 - Low_Flows_past45), size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2-1]], (Low_Flows_future45 - Low_Flows_past45), size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            violin!([xaxis[i*2]], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            boxplot!([xaxis[i*2]], (Low_Flows_future85 - Low_Flows_past85), size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
            # println(Catchment_Name)
            # println("Change 45 ", median((Low_Flows_future45 - Low_Flows_past45)))
            # println("Change 85 ", median((Low_Flows_future85 - Low_Flows_past85)))
            ylabel!("Absolute change  [mm]")

        end
        # ylims!((-35,35))
        # yticks!([-35:10:35;])
        hline!([0], color=["grey"], linestyle = :dash)
        #ylabel!("Relative Change in Average Annual Discharge [%]")
        title!("Magnitude 7day low flow")
    end
    box_magnitude = boxplot!(left_margin = [20mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, size=(2200,1200))

    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        low_flow_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year4.5.txt",',')
        Timing_Low_Flows_Past_45  = low_flow_45[:,3]
        Timing_Low_Flows_Future_45  = low_flow_45[:,4]
        low_flow_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_whole_year8.5.txt",',')
        Timing_Low_Flows_Past_85  = low_flow_85[:,3]
        Timing_Low_Flows_Future_85  = low_flow_85[:,4]
        # for timing it has to be considered that year is circular
        Timing_abs_change_85 = Timing_Low_Flows_Future_85 - Timing_Low_Flows_Past_85
        # find all values with change slarger than half a year
        too_large = findall(x->x> 183, Timing_abs_change_85)
        too_small = findall(x->x< -183, Timing_abs_change_85)
        # println(Catchment_Name)
        # println("timing highest", Timing_abs_change_85[1595])
        # println("max ", argmax(Timing_abs_change_85)," ", maximum(Timing_abs_change_85))
        # println(maximum(Timing_abs_change_85[too_large])," ", minimum(Timing_abs_change_85[too_large]))
        # if there are changes larger than half a year change them to changes less than half a year
        if too_large != Int64[]
            Timing_abs_change_85[too_large] = -(365 .- Timing_Low_Flows_Future_85[too_large] .+  Timing_Low_Flows_Past_85[too_large])
        end

        # println("extreme ", Timing_Low_Flows_Future_85[1595], " ", Timing_Low_Flows_Past_85[1595])
        # println(maximum(Timing_abs_change_85[too_small]), minimum(Timing_abs_change_85[too_small]))
        if too_small != Int64[]
            Timing_abs_change_85[too_small] = (365 .- Timing_Low_Flows_Past_85[too_small] .+  Timing_Low_Flows_Future_85[too_small])
            print("index ", too_small, "before ", Timing_abs_change_85[too_small], )
        end
        # println(maximum(Timing_abs_change_85[too_small]), minimum(Timing_abs_change_85[too_small]))
        # println("max ", argmax(Timing_abs_change_85)," ", maximum(Timing_abs_change_85))
        #break

        Timing_abs_change_45 = Timing_Low_Flows_Future_45 - Timing_Low_Flows_Past_45
        too_large = findall(x->x> 182, Timing_abs_change_45)
        too_small = findall(x->x< -182, Timing_abs_change_45)
        if too_large != Int64[]
            Timing_abs_change_45[too_large] = -(365 .- Timing_Low_Flows_Future_45[too_large] +  Timing_Low_Flows_Past_45[too_large])
        end
        if too_small != Int64[]
            Timing_abs_change_45[too_small] = (365 .- Timing_Low_Flows_Past_45[too_small] +  Timing_Low_Flows_Future_45[too_small])
        end
        violin!([xaxis[i*2-1]], Timing_abs_change_45, size=(2000,800), leg=false, color=[Farben_85[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        boxplot!([xaxis[i*2-1]], Timing_abs_change_45, size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
        violin!([xaxis[i*2]], Timing_abs_change_85, size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        boxplot!([xaxis[i*2]], Timing_abs_change_85, size=(2000,800), leg=false, color=[Farben_45[2]], alpha=0.3)
        # ylims!((-35,35))
        # yticks!([-35:10:35;])
        hline!([0], color=["grey"], linestyle = :dash)
        #ylabel!("Relative Change in Average Annual Discharge [%]")
        ylabel!("Absolute change [days]")
        title!("Timing 7day low flow")
    end
    xticks!([1.5:2:11.5;], ["Feistritztal", "Palten", "Gailtal", "Silbertal", "Defreggental", "Pitztal"])
    box_timing = boxplot!(left_margin = [20mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60, size=(2200,1200))

    Plots.plot(box_magnitude ,box_timing, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Low_Flows/low_flows_magnitude_"*change*"_change_timing_withous_loss.png")
end




function plot_timing_changes_low_flows_all_Catchments_fraction(All_Catchment_Names, Elevation, nr_runs, rcp_name)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        if rcp_name == "45"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_prob_distr_4.5.txt", ',')
            Farben = palette(:reds)
        elseif rcp_name == "85"
            max_discharge_prob = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_prob_distr_8.5.txt", ',')
            Farben = palette(:blues)
        end
        Date_Past = max_discharge_prob[:,4]
        Date_Future = max_discharge_prob[:,5]
        period_15_days_past, day_range_past = get_distributed_dates(Date_Past, 15, nr_runs[j], 29)
        period_15_days_future, day_range_future = get_distributed_dates(Date_Future, 15, nr_runs[j], 29)

        Plots.plot()
        for i in collect(0:15:366)
            current_past = period_15_days_past[findall(x->x==i, day_range_future)]
            current_future = period_15_days_future[findall(x->x==i, day_range_future)]
            #print(current_past[1:10])
            #Plots.plot!(mean(current_past)*100, leg=false, size=(1500,800), color=[Farben[1]])
            #scatter!([count, mean(current_past)*100], leg=false, size=(1500,800), color=[Farben[1]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            #Plots.plot!(mean(current_future)*100, leg=false, size=(1500,800), color=[Farben[2]])
            #scatter!([count+1,mean(current_future)*100], leg=false, size=(1500,800), color=[Farben[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            boxplot!(current_past*100, leg=false, size=(1500,800), color=[Farben[1]])
            boxplot!(current_future*100, leg=false, size=(1500,800), color=[Farben[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
            #count+=2
        end
        ylabel!("[%]", yguidefontsize=12)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Freistritz"
            title!("Feistritztal ("*string(Elevation[j])*"m)")
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[j])*"m)")
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)")
        end
        boxplot!(left_margin = [20mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        if Catchment_Name == "Defreggental" || Catchment_Name == "Pitztal"
            ylims!((0,65))
            yticks!([0:10:60;])
        else
            ylims!((0,45))
            yticks!([0:10:40;])
        end
        xticks!([2.5:4:47.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        xlims!((0,52))
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px)#, yguidefontsize=20, xtickfont = font(15), ytickfont = font(15))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/low_flows_timing_all_catchments_"*rcp_name*".png")
end

function plot_changes_magnitude_low_flows_return_periods(All_Catchment_Names, Elevation, Area_Catchments, type, change)
    all_boxplots = []
    Plots.plot()
    for (j,Catchment_Name) in enumerate(All_Catchment_Names)
        max_discharge_prob_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_prob_distr_4.5.txt", ',')
        Farben_45= palette(:reds)
        max_discharge_prob_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/LowFlows/low_flows_prob_distr_8.5.txt", ',')
        Farben_85= palette(:blues)
        max_Discharge_Past_45 = max_discharge_prob_45[:,1]
        Max_Discharge_Future_45 = max_discharge_prob_45[:,2]
        Exceedance_Probability_45 = max_discharge_prob_45[:,3]
        max_Discharge_Past_85 = max_discharge_prob_85[:,1]
        Max_Discharge_Future_85 = max_discharge_prob_85[:,2]
        Exceedance_Probability_85 = max_discharge_prob_85[:,3]
        Plots.plot()
        mean_change = Float64[]
        max_change = Float64[]
        min_change = Float64[]
        mean_change_85 = Float64[]
        max_change_85 = Float64[]
        min_change_85 = Float64[]
        std_change_45 = Float64[]
        std_change_85 = Float64[]
        for exceedance in Exceedance_Probability_45[1:30]
            index = findall(x->x == exceedance, Exceedance_Probability_45)
            if change == "relative"
                change_45 = relative_error(Max_Discharge_Future_45[index], max_Discharge_Past_45[index])*100
                change_85 = relative_error(Max_Discharge_Future_85[index], max_Discharge_Past_85[index])*100
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
            elseif change === "absolute"
                println("works1")
                change_45 = convertDischarge(Max_Discharge_Future_45[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_45[index], Area_Catchments[j])
                change_85 = convertDischarge(Max_Discharge_Future_85[index], Area_Catchments[j]) - convertDischarge(max_Discharge_Past_85[index], Area_Catchments[j])
                println(size(change_45))
                append!(mean_change, mean(change_45))
                append!(max_change, maximum(change_45))
                append!(min_change, minimum(change_45))
                append!(mean_change_85, mean(change_85))
                append!(max_change_85, maximum(change_85))
                append!(min_change_85, minimum(change_85))
                append!(std_change_45, std(change_45))
                append!(std_change_85, std(change_85))
                println("works")
            end
        end
        Plots.plot()
        return_period = reverse(31 ./ collect(1:30))

        percentage = reverse(collect(1/31:1/31:30/31)*100)
        if type == "percentage"
            Plots.plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", ribbon = std_change_45, linewidth=3, fillalpha=.3)
            Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", ribbon = std_change_85, size=(1500,800), xflip=true,linewidth=3, fillalpha=.3)
            # Plots.plot(percentage, (mean_change), color=[Farben45[2]], label="RCP 4.5", linewidth=3)
            # Plots.plot!(percentage, mean_change - std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # Plots.plot!(percentage, mean_change + std_change_45, linestyle = :dot, color=[Farben45[2]], linewidth=3)
            # Plots.plot!(percentage, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", size=(1500,800), xflip=true, linewidth=3)
            # Plots.plot!(percentage, mean_change_85 - std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            # Plots.plot!(percentage, mean_change_85 + std_change_85, linestyle = :dot, color=[Farben85[2]], linewidth=3)
            ylabel!("[%]", yguidefontsize=12)
            xlabel!("Exceedance Probability [%]", xguidefontsize=12)
            if Catchment_Name == "Pitztal"
                ylims!((-30,130))
                yticks!([-20:20:130;])
            else
                ylims!((-30,90))
                yticks!([-20:10:90;])
            end
        elseif type == "return period"
            Plots.plot(return_period, (mean_change), color=[Farben45[2]], label="RCP 4.5", linestyle = :dot,  ribbon = std_change_45, linewidth=3, fillalpha=.3)
            Plots.plot!(return_period, (mean_change_85), color=[Farben85[2]], label="RCP 8.5", linestyle = :dot, size=(1500,800), ribbon = std_change_85, linewidth=3, fillalpha=.3)
            scatter!(return_period, (mean_change), color=[Farben45[2]], label="RCP 4.5", markersize=6, markerstrokewidth= 0)#, ribbon = std_change_45)
            scatter!(return_period, (mean_change_85), color=[Farben85[2]], label="RCP 8.5",size=(1500,800), markersize=6, markerstrokewidth= 0, xscale=:log10)#, ribbon = std_change_85)
            if change == "relative"
                ylabel!("[%]", yguidefontsize=12)
                # ylims!((-30,90))
                # yticks!([-20:20:80;])
            elseif change == "absolute"
                ylabel!("[mm/d]", yguidefontsize=12)
                if Catchment_Name == "Gailtal"
                    # ylims!((-10,20))
                    # yticks!([-10:5:20;])
                else
                    # ylims!((-1.5,6))
                    # yticks!([-1:1:6;])
                end
            end
            xlabel!("Return period [yrs]", xguidefontsize=12)
            xticks!([1,2,5,10,20,30], ["1", "2", "5", "10", "20", "30"])


        end

        title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[j])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[j])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[j])*"m)", titlefont = font(20))
        end
        #boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        #xticks!([1.5:2:48.5;],["Begin Jan", "End Jan", "Begin Feb", "End Feb", "Begin Mar", "End Mar", "Begin Apr", "End Apr", "Begin May", "End May", "Begin June", "End June","Begin Jul", "End Jul", "Begin Aug", "Eng Aug", "Begin Sep", "End Sep", "Begin Oct", "End Oct", "Begin Nov", "End Nov", "Begin Dec", "End Dec"])
        box = Plots.plot!(left_margin = [5mm 0mm], bottom_margin = 20px, minorticks = true, xtickfont = font(12), ytickfont = font(12), gridlinewidth=2, framestyle = :box)
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend=false, legendfontsize= 12, size=(2200,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/low_flows_magnitude_all_Catchments_all_years_return_period_log_absolute_Pitztal_snow_redistr.png")
end
# plot_timing_changes_high_flows_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)
# plot_timing_changes_low_flows_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)

# plot_timing_changes_low_flows_all_Catchments_fraction_4585(Catchment_Names_new, Catchment_Height, nr_runs_new, true)
# plot_timing_changes_low_flows_all_Catchments_fraction(Catchment_Names, Catchment_Height, nr_runs, "45")
# plot_timing_changes_low_flows_all_Catchments_fraction(Catchment_Names, Catchment_Height, nr_runs, "85")
#plot_changes_magnitude_low_flows_return_periods(Catchment_Names, Catchment_Height, Area_Catchments, "return period", "absolute")

# ------------------- Budyko Framework -------------------------

function budyko_framework_all_catchments(All_Catchment_Names, Area_Catchments)
    Farben = palette(:tab10)
    Marker_Time = [:rect, :circle, :dtriangle]
    Plots.plot(collect(0:1),collect(0:1), color="darkblue", label="Energy Limit", size=(2200,1200))
    Plots.plot!(collect(1:5), ones(5), color=Farben_85[1], label="Water Limit")
    Epot_Prec = collect(0:0.1:5)
    Budyko_Eact_P = ( Epot_Prec .* tanh.(1 ./Epot_Prec) .* (ones(length(Epot_Prec)) - exp.(-Epot_Prec))).^0.5
    Plots.plot!(Epot_Prec, Budyko_Eact_P, label="Budyko", color="grey")
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp45/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp85/rcp85/"
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        # aridity_past45, aridity_future_45, evaporative_past_45, evaporative_future_45 = aridity_evaporative_index(path_45, Area_Catchments[i], Catchment_Name)
        # aridity_past85, aridity_future_85, evaporative_past_85, evaporative_future_85 = aridity_evaporative_index(path_85, Area_Catchments[i], Catchment_Name)
        evaporative_past_45, evaporative_future_45, evaporative_past_85, evaporative_future_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/evaporative_past_future_4585.txt",',')
        aridity_past45, aridity_future_45, aridity_past85, aridity_future_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/aridity_past_future_4585.txt", ',')
        # take mean of all simulations and all runs
        aridity_past = (mean(aridity_past45) + mean(aridity_past85)) / 2
        evaporative_past = (mean(evaporative_past_45) + mean(evaporative_past_85)) / 2
        # plot into Budyko framework
        scatter!([aridity_past], [evaporative_past], label="Past", color=[Farben[i]], markershape=Marker_Time[1], markersize= 7,  markerstrokewidth= 0)
        scatter!([mean(aridity_future_45)], [mean(evaporative_future_45)], label = "RCP 4.5", color=[Farben[i]], markershape=Marker_Time[2], markersize= 7, markerstrokewidth= 0)
        scatter!([mean(aridity_future_85)], [mean(evaporative_future_85)], label = "RCP 8.5", color=[Farben[i]], markershape=Marker_Time[3], markersize= 7,  markerstrokewidth= 0)
    end
    xlabel!("Epot/P")
    ylabel!("Eact/P")
    #vline!([0.406])
    xlims!((0,1))
    ylims!((0.2,0.6))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/budyko_all_catchments_pitztal_snowredistribution.png")
end
# @time begin
# #budyko_framework_all_catchments(Catchment_Names, Area_Catchments)
# end

function budyko_framework_per_decade(All_Catchment_Names, Area_Catchments)
    Farben = palette(:tab10)
    Marker_Time = [:rect, :circle, :dtriangle]
    all_plots = []
    Plots.plot(collect(0:1),collect(0:1), color="darkblue", label="Energy Limit")
    Plots.plot!(collect(1:5), ones(5), color=Farben_85[1], label="Water Limit")
    Epot_Prec = collect(0:0.1:5)
    Budyko_Eact_P = ( Epot_Prec .* tanh.(1 ./Epot_Prec) .* (ones(length(Epot_Prec)) - exp.(-Epot_Prec))).^0.5
    Plots.plot!(Epot_Prec, Budyko_Eact_P, label="Budyko", color="grey")
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp45/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/new_station_data_rcp85/rcp85/"
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        # Plots.plot()
        # Plots.plot!(collect(0:1),collect(0:1), color="darkblue", label="Energy Limit", size=(2200,1200))
        # Plots.plot!(Epot_Prec, Budyko_Eact_P, label="Budyko", color="grey")
        # aridity_past45, aridity_future_45, evaporative_past_45, evaporative_future_45 = aridity_evaporative_index_each_decade(path_45, Area_Catchments[i], Catchment_Name)
        # aridity_past85, aridity_future_85, evaporative_past_85, evaporative_future_85 = aridity_evaporative_index_each_decade(path_85, Area_Catchments[i], Catchment_Name)
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/aridity_past_future_decade_4585.txt",vcat(aridity_past45, aridity_future_45, aridity_past85, aridity_future_85),',')
        # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/evaporative_past_future_decade_4585.txt",vcat(evaporative_past_45, evaporative_future_45, evaporative_past_85, evaporative_future_85),',')
        aridity_index = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/aridity_past_future_decade_4585.txt", ',')
        aridity_past45 = aridity_index[1:3,:]
        aridity_future_45 = aridity_index[4:6,:]
        aridity_past85 = aridity_index[7:9,:]
        aridity_future_85 = aridity_index[10:12,:]
        evaporative_index = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Budyko/evaporative_past_future_decade_4585.txt", ',')
        evaporative_past_45 = evaporative_index[1:3,:]
        evaporative_future_45 = evaporative_index[4:6,:]
        evaporative_past_85 = evaporative_index[7:9,:]
        evaporative_future_85 = evaporative_index[10:12,:]
        println("evap", size(evaporative_future_85))
        println("aridity", size(aridity_future_85))
        println(size(mean(aridity_past45, dims=2)))
        # get mean for both pasts
        # aridity_past = (mean(aridity_past45, dims=2) + mean(aridity_past85, dims=2)) / 2
        # evaporative_past = (mean(evaporative_past_45, dims=2) + mean(evaporative_past_85, dims=2)) / 2
        aridity_past = (mean(aridity_past45) + mean(aridity_past85)) / 2
        evaporative_past = (mean(evaporative_past_45) + mean(evaporative_past_85)) / 2
        #println("arid past", aridity_past45[:,1:10], "evap past", evaporative_past_45[:,1:5])
        # plot into Budyko framework
        if Catchment_Name == "Pitten"
            Catchment_Name = "Feistritztal"
        elseif Catchment_Name == "IllSugadin"
            Catchment_Name = "Silbertal"
        end
        #println(size(aridity_future_45))
        scatter!([aridity_past], [evaporative_past], label=Catchment_Name, color=[Farben[i]], markershape=Marker_Time[1], markersize= 5,  markerstrokewidth= 0)
        # scatter!([mean(aridity_future_45, dims=2)], [mean(evaporative_future_45, dims=2)], label = "RCP 4.5", color=[Farben[i]], markershape=Marker_Time[2], markersize= 7, markerstrokewidth= 0)
        # scatter!([mean(aridity_future_85, dims=2)], [mean(evaporative_future_85, dims=2)], label = "RCP 8.5", color=[Farben[i]], markershape=Marker_Time[3], markersize= 7,  markerstrokewidth= 0)
        scatter!([mean(aridity_future_45)], [mean(evaporative_future_45)], label = "RCP 4.5", color=[Farben[i]], markershape=Marker_Time[2], markersize= 5, markerstrokewidth= 0)
        scatter!([mean(aridity_future_85)], [mean(evaporative_future_85)], label = "RCP 8.5", color=[Farben[i]], markershape=Marker_Time[3], markersize= 5,  markerstrokewidth= 0,  aspect_ratio=1)
        xlims!((0.25,0.75))
        ylims!((0.25,0.6))
        xticks!([0.25:0.05:0.75;])
        yticks!([0.25:0.05:0.6;])
        xlabel!("Aridity Index (Epot/P) [-]")
        ylabel!("Evaporative Index (Eact/P) [-]")
        println(Catchment_Name)
        println("aridity past ", aridity_past, "45 ", mean(aridity_future_45), "85 ", mean(aridity_future_85), "difference ", round(mean(aridity_future_45) - aridity_past, digits=4), " ", round(mean(aridity_future_85) - aridity_past, digits=4))
        println("evaporative past ", evaporative_past, "45 ", mean(evaporative_future_45), "85 ", mean(evaporative_future_85), "difference ", round(mean(evaporative_future_45) - evaporative_past, digits=4), " ", round(mean(evaporative_future_85) - evaporative_past, digits=4))
        #plot_catchment = Plots.plot!()
        #plot_catchment = Plots.plot!(legend = true, size=(1000,750), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=12, xguidefontsize=12, xtickfont = font(12), ytickfont = font(12), dpi=300, minorticks=true, grid_linewidth=1, framestyle = :box, legendfontsize=12)
        #push!(all_plots, plot_catchment)
    end
    #Plots.plot!([0.405775182694531], [0.3415231281206972], color="black",markershape=Marker_Time[1], markersize= 7,  markerstrokewidth= 0, label="Pitztal Calibration")

    #vline!([0.406])
    groesse = 11
    Plots.plot!(size(3500,3500),  aspect_ratio=1, legend = false, left_margin = [7mm 0mm], right_margin = [7mm 0mm], bottom_margin = 15px, yguidefontsize=groesse, xtickfont = font(groesse), ytickfont = font(groesse), xguidefontsize=groesse, dpi=300, minorticks=true, grid_linewidth=1, framestyle = :box, legendfontsize=8, minorgrid=true, minorgridlinewidth=2)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/budyko_all_catchments_final_grid.png")
end

# @time begin
# #budyko_framework_per_decade(Catchment_Names, Area_Catchments)
# end


# snow melt contirbution

function plot_monthly_snowmelt_all_catchments_absolute_change(All_Catchment_Names, Elevation)
    xaxis_45 = collect(1:2:23)
    xaxis_85 = collect(2:2:24)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        # in mm/month
        Plots.plot()
        box = []
        for month in 1:12
            boxplot!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)] - Monthly_Discharge_past_45[findall(x-> x == month, months_45)] , size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            boxplot!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_45)] - Monthly_Discharge_past_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        end
        ylabel!("[mm/month]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))

        # ylims!((-3.5,3.5))
        # yticks!([-3:1:3;])

        hline!([0], color=["grey"], linestyle = :dash)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        xticks!([1.5:2:23.5;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_snow_storage_all_catchments_absolute_change.png")
end

function plot_monthly_snowmelt_all_catchments(All_Catchment_Names, Elevation)
    past = collect(1:3:34)
    xaxis_45 = collect(2:3:35)
    xaxis_85 = collect(3:3:36)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []


    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past = (Monthly_Discharge_past_45 + Monthly_Discharge_past_85) .* 0.5
        # in mm/month
        Plots.plot()
        box = []
        divide = [31,28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if Catchment_Name == "IllSugadin" || Catchment_Name == "Pitztal"
            for month in 1:12
                boxplot!([past[month]], Monthly_Discharge_past[findall(x-> x == month, months_45)], color =["grey"])
                boxplot!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
                boxplot!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_45)], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            end
        else
            for month in 1:12
                boxplot!([past[month]], Monthly_Discharge_past[findall(x-> x == month, months_45)] ./ divide[month], color =["grey"])
                boxplot!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
                boxplot!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
            end
        end
        ylabel!("[mm/month]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))

        hline!([0], color=["grey"], linestyle = :dash)
        #hline!([100], color=["grey"], linestyle = :dash)
        #hline!([50], color=["grey"], linestyle = :dash)
        #hline!([-25], color=["grey"], linestyle = :dash)
        xticks!([2:3:35;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = boxplot!()
        push!(all_boxplots, box)
    end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, minorticks=true)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_snow_storage_all_catchments_correct.png")
end


function plot_monthly_snowmelt_all_catchments_std(All_Catchment_Names, Elevation)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    all_boxplots = []
    all_info = zeros(12)
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_melt_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_melt_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past = (Monthly_Discharge_past_45 + Monthly_Discharge_past_85) .* 0.5
        # in mm/month
        Plots.plot()
        box = []
        mean_Monthly_Discharge_Past = Float64[]
        mean_Monthly_Discharge_Future_45 = Float64[]
        mean_Monthly_Discharge_Future_85 = Float64[]
        std_Monthly_Discharge_Past = Float64[]
        std_Monthly_Discharge_Future_45 = Float64[]
        std_Monthly_Discharge_Future_85 = Float64[]
        for month in 1:12
            append!(mean_Monthly_Discharge_Past, mean(Monthly_Discharge_past[findall(x-> x == month, months_45)]))
            append!(mean_Monthly_Discharge_Future_45, mean(Monthly_Discharge_future_45[findall(x-> x == month, months_45)]))
            append!(mean_Monthly_Discharge_Future_85, mean(Monthly_Discharge_future_85[findall(x-> x == month, months_45)]))
            append!(std_Monthly_Discharge_Past, std(Monthly_Discharge_past[findall(x-> x == month, months_45)]))
            append!(std_Monthly_Discharge_Future_45, std(Monthly_Discharge_future_45[findall(x-> x == month, months_45)]))
            append!(std_Monthly_Discharge_Future_85, std(Monthly_Discharge_future_85[findall(x-> x == month, months_45)]))
        end

        Months = collect(1:12)
        Plots.plot!(Months, mean_Monthly_Discharge_Past, leg=false, size=(1500,800), linestyle = :dash, color=["black"], linewidth=3, ribbon = std_Monthly_Discharge_Past, fillalpha=.3)
        scatter!(Months, mean_Monthly_Discharge_Past, leg=false, size=(1500,800), markercolor=["black"], markersize=7, markerstrokecolor=["black"],left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        Plots.plot!(Months, mean_Monthly_Discharge_Future_45, leg=false, size=(1500,800), linestyle = :dash,color=[Farben45[2]], linewidth=3, ribbon=std_Monthly_Discharge_Future_45, fillalpha=.3)
        scatter!(Months, mean_Monthly_Discharge_Future_45, leg=false, size=(1500,800), color=[Farben45[2]], markersize=7, markerstrokecolor=[Farben45[2]], left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        Plots.plot!(Months, mean_Monthly_Discharge_Future_85, leg=false, size=(1500,800), linestyle = :dash,color=[Farben85[2]], linewidth=3, ribbon=std_Monthly_Discharge_Future_85, fillalpha=.3)
        scatter!(Months, mean_Monthly_Discharge_Future_85, leg=false, size=(1500,800), color=[Farben85[2]], markersize=7, markerstrokecolor=[Farben85[2]], framestyle = :box)#, left_margin = [5mm 0mm], bottom_margin = 20px, xrotation = 60)
        #ylabel!("[mm/month]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
        if Catchment_Name == "Pitten"
            title!("Feistritztal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "IllSugadin"
            title!("Silbertal ("*string(Elevation[i])*"m)", titlefont = font(20))
        elseif Catchment_Name == "Palten"
            title!("Palten ("*string(Elevation[i])*"m)", titlefont = font(20))
        else
            title!(Catchment_Name*" ("*string(Elevation[i])*"m)", titlefont = font(20))
        end
        boxplot!(left_margin = [5mm 0mm], bottom_margin = 20px, xtickfont = font(20), ytickfont = font(20))

        if Catchment_Name != "Pitten"
            ylims!((0,175))
            yticks!([0:50:150;])
        else
            # ylims!((0,50))
            # yticks!([0:10:150;])
        end
        xticks!([1:1:12;], ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        box = boxplot!()
        push!(all_boxplots, box)

        mean_Monthly_Discharge_Future_45 = Float64[]
        mean_Monthly_Discharge_Future_85 = Float64[]
        change_45 = Monthly_Discharge_future_45 - Monthly_Discharge_past_45
        change_85 = Monthly_Discharge_future_85 - Monthly_Discharge_past_85
        for month in 1:12
            append!(mean_Monthly_Discharge_Future_45, mean(change_45[findall(x-> x == month, months_45)]))
            append!(mean_Monthly_Discharge_Future_85, mean(change_85[findall(x-> x == month, months_45)]))
        end
        all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_45, digits=1))
        all_info = hcat(all_info, round.(mean_Monthly_Discharge_Future_85, digits=1))
    end
    # Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    # Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/monthly_snow_melt_all_catchments_std.png")
    writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/mean_change_monthly_snow_contribution.csv", all_info)
end

#plot_monthly_snowmelt_all_catchments_absolute_change(Catchment_Names, Catchment_Height)
#plot_monthly_snowmelt_all_catchments_std(Catchment_Names, Catchment_Height)
#plot_monthly_snowmelt_all_catchments(Catchment_Names, Catchment_Height)


function plot_annual_change_snow_melt(All_Catchment_Names, Elevation)
    past = collect(1:3:34)
    xaxis_45 = collect(2:3:35)
    xaxis_85 = collect(3:3:36)
    # ----------------- Plot Absolute Change ------------------
    Plots.plot()
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    box_45 = []
    box_85 = []

    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_melt_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_melt_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past = (Monthly_Discharge_past_45 + Monthly_Discharge_past_85) .* 0.5
        # in mm/month

        divide = [31,28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        Snow_Storage_Past45 = Float64[]
        Snow_Storage_Past85 = Float64[]
        Snow_Storage_Future45 = Float64[]
        Snow_Storage_Future85 = Float64[]

        for year in 1:30
            append!(Snow_Storage_Past45, sum(Monthly_Discharge_past_45[1+(year-1)*12:year*12] ./ divide))
            #append!(Snow_Storage_Past85, Monthly_Discharge_past_85[1+(year-1)*12:year*12] ./ divide)
            append!(Snow_Storage_Future45, sum(Monthly_Discharge_future_45[1+(year-1)*12:year*12] ./ divide))
            #append!(Snow_Storage_Future85, Monthly_Discharge_future_85[1+(year-1)*12:year*12] ./ divide)
            # violin!([past[month]], Monthly_Discharge_past[findall(x-> x == month, months_45)] ./ divide, color =["grey"])
            # violin!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            # violin!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        end

        boxplot!([Catchment_Name], Snow_Storage_Future45 - Snow_Storage_Past45, size=(2000,800), leg=false, color=Farben_85[2])
        #boxplot!([Catchment_Name], Snow_Storage_Future85 - Snow_Storage_Past85,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=Farben_45[2])
        violin!([Catchment_Name], Snow_Storage_Future45 - Snow_Storage_Past45, size=(2000,800), leg=false, color=Farben_85[2], alpha=0.3)
        #violin!([Catchment_Name], Snow_Storage_Future85 - Snow_Storage_Past85,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=Farben_45[2], alpha=0.3)
        ylabel!("[mm/month]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")

    end
    box_45 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot()
    for (i,Catchment_Name) in enumerate(All_Catchment_Names)
        monthly_changes_85 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_8.5.txt", ',')
        months_85 = monthly_changes_85[:,1]
        Monthly_Discharge_past_85 = monthly_changes_85[:,2]
        Monthly_Discharge_future_85  = monthly_changes_85[:,3]
        monthly_changes_45 = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/"*Catchment_Name*"/PastvsFuture/Snow_Cover/snow_storage_months_4.5.txt", ',')
        months_45 = monthly_changes_45[:,1]
        Monthly_Discharge_past_45 = monthly_changes_45[:,2]
        Monthly_Discharge_future_45  = monthly_changes_45[:,3]
        Monthly_Discharge_Change_45  = monthly_changes_45[:,4]
        Monthly_Discharge_past = (Monthly_Discharge_past_45 + Monthly_Discharge_past_85) .* 0.5
        # in mm/month
        box = []
        divide = [31,28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        Snow_Storage_Past45 = Float64[]
        Snow_Storage_Past85 = Float64[]
        Snow_Storage_Future45 = Float64[]
        Snow_Storage_Future85 = Float64[]

        for year in 1:30
            #append!(Snow_Storage_Past45, Monthly_Discharge_past_45[1+(year-1)*12:year*12] ./ divide)
            append!(Snow_Storage_Past85, sum(Monthly_Discharge_past_85[1+(year-1)*12:year*12] ./ divide))
            #append!(Snow_Storage_Future45, Monthly_Discharge_future_45[1+(year-1)*12:year*12] ./ divide)
            append!(Snow_Storage_Future85, sum(Monthly_Discharge_future_85[1+(year-1)*12:year*12] ./ divide))
            # violin!([past[month]], Monthly_Discharge_past[findall(x-> x == month, months_45)] ./ divide, color =["grey"])
            # violin!([xaxis_45[month]],Monthly_Discharge_future_45[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_85[2]], alpha=0.3)
            # violin!([xaxis_85[month]],Monthly_Discharge_future_85[findall(x-> x == month, months_45)] ./ divide[month], size=(2000,800), leg=false, color=[Farben_45[2]], left_margin = [5mm 0mm], minorticks = true, gridlinewidth=2, framestyle = :box)
        end

        #boxplot!([Catchment_Name], Snow_Storage_Future45 - Snow_Storage_Past45, size=(2000,800), leg=false, color=Farben_85[2])
        boxplot!([Catchment_Name], Snow_Storage_Future85 - Snow_Storage_Past85,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=Farben_45[2])
        #violin!([Catchment_Name], Snow_Storage_Future45 - Snow_Storage_Past45, size=(2000,800), leg=false, color=Farben_85[2], alpha=0.3)
        violin!([Catchment_Name], Snow_Storage_Future85 - Snow_Storage_Past85,size=(2000,800), left_margin = [5mm 0mm], leg=false, color=Farben_45[2], alpha=0.3)
        ylabel!("[mm/month]", yguidefontsize=20)
        #title!("Relative Change in Discharge RCP 4.5 =blue, RCP 4.5 = red")
    end
    box_85 = boxplot!(left_margin = [5mm 0mm], bottom_margin = 70px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), xrotation = 60)
    Plots.plot(box_45,box_85, layout=(2,1), size=(2200,1200))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_snow_melt_all_catchments_45_85.png")
end

#plot_annual_change_snow_melt(Catchment_Names, Catchment_Height)


function plot_hydrographs_proj_all_catchment(All_Catchment_Names, Area_Catchments, Elevation, nr_proj, past_year, future_year)
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp85/"
    Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
    Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
    all_boxplots = []
    path_projected_data = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data_Projected/"
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)

    for (k,Catchment_Name) in enumerate(All_Catchment_Names)
        path_to_projections = path_45
        if path_to_projections[end-2:end-1] == "45"
            index = 1
            rcp = "rcp45"
            color_future = Farben_85[2]
            print(rcp, " ", rcp)
        elseif path_to_projections[end-2:end-1] == "85"
            index = 2
            rcp="rcp85"
            color_future = Farben_45[2]
            print(rcp, " ", rcp)
        end
        Name_Projections = readdir(path_to_projections)
        # get the right temperature for each catchment
        #use projections Nr. 10
        name = Name_Projections[nr_proj]

        println(name)
        println("  ")

        # get past and future discharge, precipitation and temperature
        Timeseries_Future = collect(Date(Timeseries_End[nr_proj,index]-29,1,1):Day(1):Date(Timeseries_End[nr_proj,index],12,31))
        if Catchment_Name != "Pitztal"
            # if Catchment_Name == "Pitten"
            #     Catchment_Name = "Feistritz"
            # elseif Catchment_Name == "IllSugadin"
            #     Catchment_Name = "Silbertal"
            Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
            Future_Discharge = readdlm(path_projected_data*"Future/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Future.csv", ',')
            # end
        else
            Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
            Future_Discharge = readdlm(path_projected_data*"Future/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Future.csv", ',')
        end
        # select one typical year, plot discharges all in one Plots.plot!(!!
        current_year = past_year
        days_year_past = collect(1:daysinyear(current_year))
        indexfirstday_past = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
        indexlasttday_past = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
        plot()
        # for all 300 parametersets plot the discharge of the specific year
        Discharge_selected_year = convertDischarge(Past_Discharge[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
        minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,:]
        maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,:]
        mean_Discharge = mean(Discharge_selected_year, dims=1)[1,:]
        println("size discharge ", size(mean_Discharge))
        println("size discharge ", size(maximum_Discharge))
        plot!(days_year_past, mean_Discharge, color = ["black"], legend=false, size=(1800,1000), ribbon=(mean_Discharge - minimum_Discharge, maximum_Discharge - mean_Discharge))
        # plot also future discharge in dame plot
        current_year = future_year
        days_year_future = collect(1:daysinyear(current_year))
        indexfirstday_future = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Future)[1]
        indexlasttday_future = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Future)[1]
        # for all 300 parametersets plot the discharge of the specific year
        Discharge_selected_year = convertDischarge(Future_Discharge[:,indexfirstday_future:indexlasttday_future], Area_Catchments[k])
        minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,:]
        maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,:]
        mean_Discharge = mean(Discharge_selected_year, dims=1)[1,:]
        plot!(days_year_future, mean_Discharge, color = [color_future], legend=false, size=(1800,1000), ribbon=(mean_Discharge - minimum_Discharge, maximum_Discharge - mean_Discharge), margin=5mm)
        ylabel!("Runoff [mm/d]")

        #if Catchment_Name == "Pitten"
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,4.5))
        #elseif Catchment_Name == "IllSugadin"
        elseif Catchment_Name == "Silbertal"
            title!("Silbertal ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,23))
        elseif Catchment_Name == "Palten"
            title!("Palten ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,7.5))
        else
            title!(Catchment_Name*" ("*string(Elevation[k])*"m)", titlefont = font(20))
        end
        if Catchment_Name == "Gailtal"
            ylims!((0,22))
        elseif Catchment_Name == "Defreggental"
            ylims!((0,8.5))
        elseif Catchment_Name == "Pitztal"
            ylims!((0,12))
        end
        #xlabel!("Time in Year")
        #Plots.plot!(Timeseries[indexfirstday:indexlasttday], convertDischarge(Observed_Discharge[indexfirstday:indexlasttday], Area_Catchment), label="Observed",size=(1800,1000), color = [Farben_45[2]], linewidth = 3)
        discharge = plot!()#p = twinx()
        push!(all_boxplots, discharge)
        # ----------- RCP 8.5 --------------------------------------
        path_to_projections = path_85
        if path_to_projections[end-2:end-1] == "45"
            index = 1
            rcp = "rcp45"
            color_future = Farben_85[2]
            print(rcp, " ", rcp)
        elseif path_to_projections[end-2:end-1] == "85"
            index = 2
            rcp="rcp85"
            color_future = Farben_45[2]
            print(rcp, " ", rcp)
        end
        Name_Projections = readdir(path_to_projections)
        # get the right temperature for each catchment
        #use projections Nr. 10
        name = Name_Projections[nr_proj]
        print(name)
        # get past and future discharge, precipitation and temperature
        Timeseries_Future = collect(Date(Timeseries_End[nr_proj,index]-29,1,1):Day(1):Date(Timeseries_End[nr_proj,index],12,31))
        if Catchment_Name != "Pitztal"
            # if Catchment_Name == "Pitten"
            #     Catchment_Name = "Feistritz"
            # elseif Catchment_Name == "IllSugadin"
            #     Catchment_Name = "Silbertal"
                Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
                Future_Discharge = readdlm(path_projected_data*"Future/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Future.csv", ',')
            # end
        else
            Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
            Future_Discharge = readdlm(path_projected_data*"Future/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Future.csv", ',')
        end
        # select one typical year, plot discharges all in one Plots.plot!(!!
            current_year = past_year
            days_year_past = collect(1:daysinyear(current_year))
            indexfirstday_past = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            indexlasttday_past = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            plot()
            # for all 300 parametersets plot the discharge of the specific year
            Discharge_selected_year = convertDischarge(Past_Discharge[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
            minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,:]
            maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,:]
            mean_Discharge = mean(Discharge_selected_year, dims=1)[1,:]
            println("size discharge ", size(mean_Discharge))
            println("size discharge ", size(maximum_Discharge))
            plot!(days_year_past, mean_Discharge, color = ["black"], legend=false, size=(1800,1000), ribbon=(mean_Discharge - minimum_Discharge, maximum_Discharge - mean_Discharge))
            # plot also future discharge in dame plot
            current_year = future_year
            days_year_future = collect(1:daysinyear(current_year))
            indexfirstday_future = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Future)[1]
            indexlasttday_future = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Future)[1]
            # for all 300 parametersets plot the discharge of the specific year
            Discharge_selected_year = convertDischarge(Future_Discharge[:,indexfirstday_future:indexlasttday_future], Area_Catchments[k])
            minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,:]
            maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,:]
            mean_Discharge = mean(Discharge_selected_year, dims=1)[1,:]
            plot!(days_year_future, mean_Discharge, color = [color_future], legend=false, size=(1800,1000), ribbon=(mean_Discharge - minimum_Discharge, maximum_Discharge - mean_Discharge), margin=5mm)
            ylabel!("Runoff [mm/d]")
            #if Catchment_Name == "Pitten"
            if Catchment_Name == "Feistritz"
                title!("Feistritztal ("*string(Elevation[k])*"m)", titlefont = font(20))
                ylims!((0,4.5))
        #    elseif Catchment_Name == "IllSugadin"
            elseif Catchment_Name == "Silbertal"
                title!("Silbertal ("*string(Elevation[k])*"m)", titlefont = font(20))
                ylims!((0,23))
            elseif Catchment_Name == "Palten"
                title!("Palten ("*string(Elevation[k])*"m)", titlefont = font(20))
                ylims!((0,7.5))
            else
                title!(Catchment_Name*" ("*string(Elevation[k])*"m)", titlefont = font(20))
            end
            if Catchment_Name == "Gailtal"
                ylims!((0,22))
            elseif Catchment_Name == "Defreggental"
                ylims!((0,8.5))
            elseif Catchment_Name == "Pitztal"
                ylims!((0,12))
            end
            #xlabel!("Time in Year")
            #Plots.plot!(Timeseries[indexfirstday:indexlasttday], convertDischarge(Observed_Discharge[indexfirstday:indexlasttday], Area_Catchment), label="Observed",size=(1800,1000), color = [Farben_45[2]], linewidth = 3)
            #discharge = Plots.plot!()#p = twinx()
            discharge=plot!()
            push!(all_boxplots, discharge)
        end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], all_boxplots[7], all_boxplots[8], all_boxplots[9], all_boxplots[10], all_boxplots[11], all_boxplots[12], layout= (6,2), legend = false, size=(2100,2400), left_margin = [7mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, framestyle=:box)
    #Plots.plot(all_boxplots[1], all_boxplots[2],  all_boxplots[9], all_boxplots[10], layout= (2,2), legend = false, size=(2100,2400/3), left_margin = [7mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, framestyle=:box)
    xticks!([1,32,60,91,121,152,182,213,244,274,305,335] .+ 14, ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])#["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7","1.8", "1.9", "1.10", "1.11", "1.12"])
    xlims!((1,365))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Hydrographs/hydrographs_proj_"*string(nr_proj)*"_"*string(past_year)*"_"*string(future_year)*".png")
end

function plot_hydrographs_proj_mean(All_Catchment_Names, Area_Catchments, Elevation, nr_proj, past_year)
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp85/"
    Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
    Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
    all_boxplots = []
    path_projected_data = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data_Projected/"
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    labels=["Past Cal", "Past Clim", "Obs"]
    code = [214353, 210815, 212670, 200048, 212100, 201335]
    for (k,Catchment_Name) in enumerate(All_Catchment_Names)
        path_to_projections = path_45
        if path_to_projections[end-2:end-1] == "45"
            index = 1
            rcp = "rcp45"
            color_future = Farben_85[2]
            print(rcp, " ", rcp)
        elseif path_to_projections[end-2:end-1] == "85"
            index = 2
            rcp="rcp85"
            color_future = Farben_45[2]
            print(rcp, " ", rcp)
        end
        Name_Projections = readdir(path_to_projections)
        # get the right temperature for each catchment
        #use projections Nr. 10
        name = Name_Projections[nr_proj]

        println(name)
        println("  ")

        # get past and future discharge, precipitation and temperature
        # Timeseries_Future = collect(Date(Timeseries_End[nr_proj,index]-29,1,1):Day(1):Date(Timeseries_End[nr_proj,index],12,31))
        # if Catchment_Name != "Pitztal"
        Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
        Past_Discharge_NS = readdlm("/Volumes/Magali 2/Data_projected/Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", ',')
        # Past_Discharge = Past_Discharge[1]
        # println(size(Past_Discharge))

        # else
        #     Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
        #     Past_Discharge_NS = readdlm(path_projected_data*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", ',')
        # end
        # select one typical year, plot discharges all in one Plots.plot!(!!
        past_years = past_year:1:past_year+29
        mean_total_Discharge=[]
        mean_total_Discharge_NS=[]
        minimum_total_Discharge=[]
        minimum_total_Discharge_NS=[]
        maximum_total_Discharge=[]
        maximum_total_Discharge_NS=[]
        Observed_Discharge=[]

        local_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/"

        Discharge = CSV.read(local_path*"HBVModel/"*Catchment_Name*"/Q-Tagesmittel-"*string(code[k])*".csv", DataFrame, header= false, skipto=26, decimal=',', delim = ';', types=[String, Float64])
        Discharge = Matrix(Discharge)
        # Observed_Discharge = Observed_Discharge[:,1]


        # println(typeof(Observed_Discharge))
        for (i,current_year) in enumerate(past_years)
            println(i, current_year)
            days_year_past = collect(1:daysinyear(current_year))
            indexfirstday_past = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            indexlasttday_past = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            plot()
            startindex = findfirst(isequal("01.01."*string(current_year)*" 00:00:00"), Discharge)
            endindex = findfirst(isequal("31.12."*string(current_year)*" 00:00:00"), Discharge)
            println(startindex)
            Observed_Discharge = Array{Float64,1}[]
            push!(Observed_Discharge, Discharge[startindex[1]:endindex[1],2])
            Observed_Discharge = Observed_Discharge[1]


        # for all 300 parametersets plot the discharge of the specific year
            Observed_Discharge_selected_year = convertDischarge(Observed_Discharge, Area_Catchments[k])
            Discharge_selected_year = convertDischarge(Past_Discharge[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
            println(size(Observed_Discharge_selected_year))

            observed_Discharge = mean(Observed_Discharge_selected_year, dims=1)
            minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,1:365]
            maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,1:365]
            mean_Discharge = mean(Discharge_selected_year, dims=1)[1,1:365]
            println("size discharge ", size(mean_Discharge))
            println("size discharge ", size(maximum_Discharge))
            NS_Discharge_selected_year = convertDischarge(Past_Discharge_NS[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
            minimum_Discharge_NS = minimum(NS_Discharge_selected_year, dims=1)[1,1:365]
            maximum_Discharge_NS = maximum(NS_Discharge_selected_year, dims=1)[1,1:365]
            mean_Discharge_NS = mean(NS_Discharge_selected_year, dims=1)[1,1:365]
            println("size discharge ", size(mean_Discharge_NS))
            println("size discharge ", size(maximum_Discharge_NS))

            if i==1
                Observed_Discharge = observed_Discharge
                mean_total_Discharge = mean_Discharge
                minimum_total_Discharge = minimum_Discharge
                maximum_total_Discharge = maximum_Discharge
                mean_total_Discharge_NS = mean_Discharge_NS
                minimum_total_Discharge_NS = minimum_Discharge_NS
                maximum_total_Discharge_NS = maximum_Discharge_NS
            else
                Observed_Discharge = (observed_Discharge .+ Observed_Discharge)./2
                mean_total_Discharge = (mean_total_Discharge.+ mean_Discharge)./2
                minimum_total_Discharge = (minimum_total_Discharge.+ minimum_Discharge)./2
                maximum_total_Discharge = (maximum_total_Discharge.+ maximum_Discharge)./2
                mean_total_Discharge_NS = (mean_total_Discharge_NS.+ mean_Discharge_NS)./2
                minimum_total_Discharge_NS = (minimum_total_Discharge_NS.+ minimum_Discharge_NS)./2
                maximum_total_Discharge_NS = (maximum_total_Discharge_NS.+ maximum_Discharge_NS)./2
            end

        end
        days_year_past = 1:1:365
        if k!=6
            plot!(days_year_past, mean_total_Discharge, color = ["black"], label=false, size=(1800,1000), ribbon=(mean_total_Discharge - minimum_total_Discharge, maximum_total_Discharge - mean_total_Discharge))
            plot!(days_year_past, mean_total_Discharge_NS, color = ["darkorange"], label=false, size=(1800,1000), ribbon=(mean_total_Discharge_NS - minimum_total_Discharge_NS, maximum_total_Discharge_NS - mean_total_Discharge_NS))
            plot!(days_year_past, Observed_Discharge, color = ["black"], label=false, size=(1800,1000))
        else
            plot!(days_year_past, mean_total_Discharge, color = ["black"], label=labels[1], size=(1800,1000), ribbon=(mean_total_Discharge - minimum_total_Discharge, maximum_total_Discharge - mean_total_Discharge))
            plot!(days_year_past, mean_total_Discharge_NS, color = ["darkorange"], label=labels[2], size=(1800,1000), ribbon=(mean_total_Discharge_NS - minimum_total_Discharge_NS, maximum_total_Discharge_NS - mean_total_Discharge_NS))
            plot!(days_year_past, Observed_Discharge, color = ["black"], label=labels[3], size=(1800,1000))
        end
        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,4.5))
        #elseif Catchment_Name == "IllSugadin"
        elseif Catchment_Name == "Silbertal"
            title!("Silbertal ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,23))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,7.5))
        else
            title!(Catchment_Name*" ("*string(Elevation[k])*"m)", titlefont = font(20))
        end
        if Catchment_Name == "Gailtal"
            ylims!((0,22))
        elseif Catchment_Name == "Defreggental"
            ylims!((0,8.5))
        elseif Catchment_Name == "Pitztal"
            ylims!((0,12))
        end
        if k in 4:6
            xticks!([1,32,60,91,121,152,182,213,244,274,305,335] .+ 14, ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])#["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7","1.8", "1.9", "1.10", "1.11", "1.12"])
        else
            xticks!([1,32,60,91,121,152,182,213,244,274,305,335] .+ 14, ["", "", "", "", "","", "", "", "", "", "", ""])#["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7","1.8", "1.9", "1.10", "1.11", "1.12"])
        end
        #xlabel!("Time in Year")
        #Plots.plot!(Timeseries[indexfirstday:indexlasttday], convertDischarge(Observed_Discharge[indexfirstday:indexlasttday], Area_Catchment), label="Observed",size=(1800,1000), color = [Farben_45[2]], linewidth = 3)
        discharge = plot!()#p = twinx()
        push!(all_boxplots, discharge)

        end
    Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), legend =:topleft, size=(2500,1200), left_margin = [20mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, framestyle=:box,
    grid=false)
    #Plots.plot(all_boxplots[1], all_boxplots[2],  all_boxplots[9], all_boxplots[10], layout= (2,2), legend = false, size=(2100,2400/3), left_margin = [7mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, framestyle=:box)

    xlims!((1,365))
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Mean_Regime/Mean_Regime_"*string(nr_proj)*"_"*string(past_year)*".png")
end


function plot_hydrographs_proj_mean(All_Catchment_Names, Area_Catchments, Elevation, nr_proj, past_year)
    path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp45/"
    path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/rcp85/"
    Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
    Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
    all_boxplots = []
    path_projected_data = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data_Projected/"
    Farben_45= palette(:reds)
    Farben_85= palette(:blues)
    labels=["Past Cal", "Past Clim", "Observed"]
    code = [214353, 210815, 212670, 200048, 212100, 201335]
    skipto = [388,21,23,24,26,23]
    correction=[1,1,1,0.7,0.65,1]
    for (k,Catchment_Name) in enumerate(All_Catchment_Names)
        path_to_projections = path_45
        if path_to_projections[end-2:end-1] == "45"
            index = 1
            rcp = "rcp45"
            color_future = Farben_85[2]
            print(rcp, " ", rcp)
        elseif path_to_projections[end-2:end-1] == "85"
            index = 2
            rcp="rcp85"
            color_future = Farben_45[2]
            print(rcp, " ", rcp)
        end
        Name_Projections = readdir(path_to_projections)
        # get the right temperature for each catchment
        #use projections Nr. 10
        name = Name_Projections[nr_proj]

        println(name)
        println("  ")

        # get past and future discharge, precipitation and temperature
        # Timeseries_Future = collect(Date(Timeseries_End[nr_proj,index]-29,1,1):Day(1):Date(Timeseries_End[nr_proj,index],12,31))
        # # if Catchment_Name != "Pitztal"
        Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
        Past_Discharge_NS = readdlm("/Volumes/Magali 2/Data_projected/Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", ',')
        # Past_Discharge = Past_Discharge[1]
        println(size(Past_Discharge))

        # else
        #     Past_Discharge = readdlm(path_projected_data*"Past/S/"*Catchment_Name*"/"*rcp*"/"*name*"/S_model_results_discharge_Past.csv", ',')
        #     Past_Discharge_NS = readdlm(path_projected_data*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", ',')
        # end
        # select one typical year, plot discharges all in one Plots.plot!(!!
        past_years = past_year:1:past_year+29
        mean_total_Discharge=[]
        mean_total_Discharge_NS=[]
        minimum_total_Discharge=[]
        minimum_total_Discharge_NS=[]
        maximum_total_Discharge=[]
        maximum_total_Discharge_NS=[]
        Observed_Discharge=[]
        Observed_Discharge_tot=[]

        local_path = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/"

        Discharge = CSV.read(local_path*"HBVModel/"*Catchment_Name*"/Q-Tagesmittel-"*string(code[k])*".csv", DataFrame, header= false, skipto=skipto[k], decimal=',', delim = ';', types=[String, Float64])
        Discharge = Matrix(Discharge)
        # Observed_Discharge = Observed_Discharge[:,1]


        # println(typeof(Observed_Discharge))
        for (i,current_year) in enumerate(past_years)
            println(i, current_year)
            days_year_past = collect(1:daysinyear(current_year))
            indexfirstday_past = findall(x -> x == Dates.firstdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            indexlasttday_past = findall(x -> x == Dates.lastdayofyear(Date(current_year,1,1)), Timeseries_Past)[1]
            plot()
            startindex = findfirst(isequal("01.01."*string(current_year)*" 00:00:00"), Discharge)
            endindex = findfirst(isequal("31.12."*string(current_year)*" 00:00:00"), Discharge)
            println(startindex)
            Observed_Discharge = Array{Float64,1}[]
            push!(Observed_Discharge, Discharge[startindex[1]:endindex[1],2])
            Observed_Discharge = Observed_Discharge[1]


        # for all 300 parametersets plot the discharge of the specific year
            Observed_Discharge_selected_year = convertDischarge(Observed_Discharge, Area_Catchments[k])
            Discharge_selected_year = convertDischarge(Past_Discharge[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
            NS_Discharge_selected_year = convertDischarge(Past_Discharge_NS[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])

            println(size(Observed_Discharge_selected_year))

            observed_Discharge = Observed_Discharge_selected_year[1:365]#mean(Observed_Discharge_selected_year, dims=1)
            minimum_Discharge = minimum(Discharge_selected_year, dims=1)[1,1:365]
            maximum_Discharge = maximum(Discharge_selected_year, dims=1)[1,1:365]
            mean_Discharge = mean(Discharge_selected_year, dims=1)[1,1:365]
            println("size discharge ", size(mean_Discharge))
            println("size discharge ", size(maximum_Discharge))
            NS_Discharge_selected_year = convertDischarge(Past_Discharge_NS[:,indexfirstday_past:indexlasttday_past], Area_Catchments[k])
            minimum_Discharge_NS = minimum(NS_Discharge_selected_year, dims=1)[1,1:365]
            maximum_Discharge_NS = maximum(NS_Discharge_selected_year, dims=1)[1,1:365]
            mean_Discharge_NS = mean(NS_Discharge_selected_year, dims=1)[1,1:365]
            println("size discharge ", size(mean_Discharge_NS))
            println("size discharge ", size(maximum_Discharge_NS))

            if i==1
                Observed_Discharge_tot = observed_Discharge
                mean_total_Discharge = mean_Discharge
                minimum_total_Discharge = minimum_Discharge
                maximum_total_Discharge = maximum_Discharge
                mean_total_Discharge_NS = mean_Discharge_NS
                minimum_total_Discharge_NS = minimum_Discharge_NS
                maximum_total_Discharge_NS = maximum_Discharge_NS
            else
                Observed_Discharge_tot = (observed_Discharge .+ Observed_Discharge_tot)
                mean_total_Discharge = (mean_total_Discharge.+ mean_Discharge)
                minimum_total_Discharge = (minimum_total_Discharge.+ minimum_Discharge)
                maximum_total_Discharge = (maximum_total_Discharge.+ maximum_Discharge)
                mean_total_Discharge_NS = (mean_total_Discharge_NS.+ mean_Discharge_NS)
                minimum_total_Discharge_NS = (minimum_total_Discharge_NS.+ minimum_Discharge_NS)
                maximum_total_Discharge_NS = (maximum_total_Discharge_NS.+ maximum_Discharge_NS)
            end

        end
        Observed_Discharge_tot = (Observed_Discharge_tot*correction[k])./(ones(length(Observed_Discharge_tot)).*length(past_years))
        mean_total_Discharge = mean_total_Discharge./(ones(length(Observed_Discharge))*length(past_years))
        minimum_total_Discharge = minimum_total_Discharge./(ones(length(Observed_Discharge))*length(past_years))
        maximum_total_Discharge = maximum_total_Discharge./(ones(length(Observed_Discharge))*length(past_years))
        mean_total_Discharge_NS = mean_total_Discharge_NS./(ones(length(Observed_Discharge))*length(past_years))
        minimum_total_Discharge_NS = minimum_total_Discharge_NS./(ones(length(Observed_Discharge))*length(past_years))
        maximum_total_Discharge_NS = maximum_total_Discharge_NS./(ones(length(Observed_Discharge))*length(past_years))

        days_year_past = 1:1:365
        if k!=6
            plot!(days_year_past, mean_total_Discharge, color = ["black"], label=false, size=(1800,1000), ribbon=(mean_total_Discharge - minimum_total_Discharge, maximum_total_Discharge - mean_total_Discharge))
            plot!(days_year_past, mean_total_Discharge_NS, color = ["darkorange"], label=false, size=(1800,1000), ribbon=(mean_total_Discharge_NS - minimum_total_Discharge_NS, maximum_total_Discharge_NS - mean_total_Discharge_NS))
            plot!(days_year_past, Observed_Discharge_tot, color = ["black"], label=false, size=(1800,1000))
        else
            plot!(days_year_past, mean_total_Discharge, color = ["black"], label=labels[1], size=(1800,1000), ribbon=(mean_total_Discharge - minimum_total_Discharge, maximum_total_Discharge - mean_total_Discharge))
            plot!(days_year_past, mean_total_Discharge_NS, color = ["darkorange"], label=labels[2], size=(1800,1000), ribbon=(mean_total_Discharge_NS - minimum_total_Discharge_NS, maximum_total_Discharge_NS - mean_total_Discharge_NS))
            plot!(days_year_past, Observed_Discharge_tot, color = ["black"], label=labels[3], size=(1800,1000))
        end
        ylims!((0,8))

        if Catchment_Name == "Feistritz"
            title!("Feistritztal ("*string(Elevation[k])*"m)", titlefont = font(20))
            ylims!((0,3))
        #elseif Catchment_Name == "IllSugadin"
        elseif Catchment_Name == "Silbertal"
            title!("Silbertal ("*string(Elevation[k])*"m)", titlefont = font(20))
            # ylims!((0,23))
        elseif Catchment_Name == "Palten"
            title!("Paltental ("*string(Elevation[k])*"m)", titlefont = font(20))
            # ylims!((0,7.5))
        else
            title!(Catchment_Name*" ("*string(Elevation[k])*"m)", titlefont = font(20))
        end
        # if Catchment_Name == "Gailtal"
        #     ylims!((0,22))
        # elseif Catchment_Name == "Defreggental"
        #     ylims!((0,8.5))
        # elseif Catchment_Name == "Pitztal"
        #     ylims!((0,12))
        # end
        if k in 4:6
            xticks!([1,32,60,91,121,152,182,213,244,274,305,335] .+ 14, ["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"])#["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7","1.8", "1.9", "1.10", "1.11", "1.12"])
            xlabel!("Time [months]")

        else
            xticks!([1,32,60,91,121,152,182,213,244,274,305,335] .+ 14, ["", "", "", "", "","", "", "", "", "", "", ""])#["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7","1.8", "1.9", "1.10", "1.11", "1.12"])
        end
        if k in [1,4]
            ylabel!("Mean Runoff [mm/day]")
        end

        #xlabel!("Time in Year")
        #Plots.plot!(Timeseries[indexfirstday:indexlasttday], convertDischarge(Observed_Discharge[indexfirstday:indexlasttday], Area_Catchment), label="Observed",size=(1800,1000), color = [Farben_45[2]], linewidth = 3)
        discharge = plot!()#p = twinx()
        push!(all_boxplots, discharge)

        end
    total=Plots.plot(all_boxplots[1], all_boxplots[2], all_boxplots[3], all_boxplots[4], all_boxplots[5], all_boxplots[6], layout= (2,3), legend =:topleft, size=(2500,1200), left_margin = [20mm 5mm 5mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300,
    framestyle=:box,grid=false, legendfontsize=20, top_margin=10px)
    #Plots.plot(all_boxplots[1], all_boxplots[2],  all_boxplots[9], all_boxplots[10], layout= (2,2), legend = false, size=(2100,2400/3), left_margin = [7mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300, framestyle=:box)

    xlims!((1,365))

    display(total)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Calibration/Mean_Regime/Mean_Regime_"*string(nr_proj)*"_"*string(past_year)*".png")
end

proj = 14
# plot_proj_all_catchment(Catchment_Names, Area_Catchments, Catchment_Height,proj, 1992, 2092)
# plot_hydrographs_proj_mean(Catchment_Names_new, Area_Catchments, Catchment_Height,proj, 1981)
# plot_hydrographs_proj_all_catchment(Catchment_Names_new, Area_Catchments, Catchment_Height,proj, 1987, 2087)
# plot_hydrographs_proj_all_catchment(Catchment_Names, Area_Catchments, Catchment_Height,proj, 1990, 2090)
# plot_hydrographs_proj_all_catchment(Catchment_Names, Area_Catchments, Catchment_Height,proj, 1995, 2095)



function plot_changes_prec_temp_all_catchments_test_legend(All_Catchment_Names, Elevation, nr_runs)
    Plots.plot()
    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]
    Farben_proj = palette(:tab20)
    all_boxplots_prec = []
    all_boxplots_temp = []
    all_boxplots_q = []
    all_boxplots_q_pf = []
    legends=[]

    for (h,Catchment_Name) in enumerate(All_Catchment_Names)
        println(Catchment_Name)
        Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
        Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')
        path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
        path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"
        Name_Projections_45 = readdir(path_45)
        Name_Projections_85 = readdir(path_85)
        #all_months_all_runs = Float64[]
        average_monthly_Precipitation_past45 = Float64[]
        average_monthly_Precipitation_future45 = Float64[]
        average_monthly_Precipitation_past85 = Float64[]
        average_monthly_Precipitation_future85 = Float64[]
        average_monthly_Temperature_past45 = Float64[]
        average_monthly_Temperature_past85 = Float64[]
        average_monthly_Temperature_future45 = Float64[]
        average_monthly_Temperature_future85 = Float64[]

        if Catchment_Name == "Gailtal"
            ID_Prec_Zones = [113589, 113597, 113670, 114538]
            # size of the area of precipitation zones
            Area_Zones = [98227533.0, 184294158.0, 83478138.0, 220613195.0]
            Temp_Elevation = 1140.0
            Mean_Elevation_Catchment = 1500
            ID_temp = 113597
            Elevations_Catchment = Elevations(200.0, 400.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Palten"
            ID_Prec_Zones = [106120, 111815, 9900]
            Area_Zones = [198175943.0, 56544073.0, 115284451.3]
            ID_temp = 106120
            Temp_Elevation = 1265.0
            Mean_Elevation_Catchment = 1300 # in reality 1314
            Elevations_Catchment = Elevations(200.0, 600.0, 2600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Feistritz"
            ID_Prec_Zones = [109967]
            Area_Zones = [115496400.]
            ID_temp = 10510
            Mean_Elevation_Catchment = 900 # in reality 917
            Temp_Elevation = 488.0
            Elevations_Catchment = Elevations(200.0, 400.0, 1600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Defreggental"
            ID_Prec_Zones = [17700, 114926]
            Area_Zones = [235811198.0, 31497403.0]
            ID_temp = 17700
            Mean_Elevation_Catchment =  2300 # in reality 2233.399986
            Temp_Elevation = 1385.
            Elevations_Catchment = Elevations(200.0, 1000.0, 3600.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name=="Silbertal"
            ID_Prec_Zones = [100206]
            Area_Zones = [100139168.]
            ID_temp = 14200
            Mean_Elevation_Catchment = 1700
            Temp_Elevation = 670.
            Elevations_Catchment = Elevations(200.0, 600.0, 2800.0, Temp_Elevation, Temp_Elevation)
        elseif Catchment_Name == "Pitztal"
            ID_Prec_Zones = [102061, 102046]
            Area_Zones = [20651736.0, 145191864.0]
            ID_temp = 14620
            Mean_Elevation_Catchment =  2500 # in reality 2233.399986
            Temp_Elevation = 1410.
            Elevations_Catchment = Elevations(200.0, 1200.0, 3800.0, Temp_Elevation, Temp_Elevation)
        end
        Area_Catchment = sum(Area_Zones)
        Area_Zones_Percent = Area_Zones / Area_Catchment
        Plots.plot()
        box_prec = []
        # xaxis_1 = collect(1:1:12)
        # boxPlots.plot([1], relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color=Farben_85[2])
        # scatter!(ones(14), relative_error(average_monthly_Precipitation_future45, average_monthly_Precipitation_past45)*100, color="black")
        # violin!([2], relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85) * 100, color=Farben_45[2])
        # scatter!(ones(14)*2,relative_error(average_monthly_Precipitation_future85, average_monthly_Precipitation_past85)*100, color="black")#, minorticks=true, minorgrid=true)#, grid_linewidth=1, minorticks=true)
        #title!(Catchment_Name, titlefont = font(20))
        P_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_4.5.csv", ',')
        relative_error_P_45 = P_error_45[:,1]
        average_monthly_Precipitation_past45 = P_error_45[:,2]
        average_monthly_Precipitation_future45= P_error_45[:,3]
        P_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Precipitation_8.5.csv", ',')
        relative_error_P_85 = P_error_85[:,1]
        average_monthly_Precipitation_past85 = P_error_85[:,2]
        average_monthly_Precipitation_future85= P_error_85[:,3]
        T_error_45 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_4.5.csv", ',')
        relative_error_T_45 = T_error_45[:,1]
        average_monthly_Temperature_past45 = T_error_45[:,2]
        average_monthly_Temperature_future45= T_error_45[:,3]
        T_error_85 = readdlm(path_pro_HD*Catchment_Name*"/PastvsFuture/Annual_Discharge/relative_error_Temperature_8.5.csv", ',')
        relative_error_T_85 = T_error_85[:,1]
        average_monthly_Temperature_past85 = T_error_85[:,2]
        average_monthly_Temperature_future85= T_error_85[:,3]


        hline!([0], color=["grey"], linestyle = :dash, label=false)

        violin!([1], relative_error_P_45*100, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), relative_error_P_45*100, color="black", xticks=:none, label=false)
        scatter!([1], [mean(relative_error_P_45*100)], color="white",markerstrokecolour="black",markersize=7, xticks=:none, label=false)

        violin!([2], relative_error_P_85*100, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, relative_error_P_85*100, color="black",xticks=:none, label=false)
        scatter!([2], [mean(relative_error_P_85*100)], color="white",markerstrokecolour="black",markersize=7,xticks=:none, label=false)



        ylims!((-25,35))
        if h==1||h==6
            yticks!([-20:10:30;])
        else
            yticks!([-20:10:30;], ["", "", "", "", "",""])

        end
        xticks!([1:1:2;], ["RCP 4.5", "RCP 8.5"])

        box_prec = violin!(framestyle = :box, grid=false)# minorgrid=true, minorgridlinewidth=2, gridlinewidth=4)#,  aspect_ratio=1)#aspect_ratio=1)
        push!(all_boxplots_prec, box_prec)



        if h==1
            ylabel!("∆ Precipitation [%]", yguidefontsize=20)
        end
        # ------------ temp ------------
        Plots.plot()

        box_temp = []
        violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[2],  xticks=:none, label=false)
        scatter!(ones(14), average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color="black", label=false)#,minorticks=true, minorgrid=true)
        violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[2],xticks=:none, label=false)
        scatter!(ones(14)*2, average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color="black", label=false)#,minorticks=true, minorgrid=true)
        scatter!([1], [mean(average_monthly_Temperature_future45 - average_monthly_Temperature_past45)], color="white",  markerstrokecolour="black", markersize=7, xticks=:none, label=false)
        scatter!([2], [mean(average_monthly_Temperature_future85 - average_monthly_Temperature_past85)], color="white", markerstrokecolour="black",markersize=7,xticks=:none, label=false)
        hline!([0], color=["grey"], linestyle = :dash, label=false)
        # violin!([1], average_monthly_Temperature_future45 - average_monthly_Temperature_past45, color=Farben_45[7],  xticks=:none, label=false)
        # violin!([2], average_monthly_Temperature_future85 - average_monthly_Temperature_past85, color=Farben_85[7],xticks=:none, label=false)


        ylims!((0.5,7.5))

        if h==1 || h==6
            yticks!([1:1:7;], ["    1", "    2", "    3", "    4", "    5","    6","    7"])
        else
            yticks!([1:1:7;], ["", "", "", "", "","",""])

        end

        if Catchment_Name == "Feistritz"
            Catchment_Name = "Feistritztal"
            println("works")
        elseif Catchment_Name == "Palten"
            Catchment_Name = "Paltental"
        end

        title!(Catchment_Name*" ("*string(Elevation[h])*"m)", titlefont = font(20), margin=20px, label=false)
        box_temp = violin!(framestyle = :box, grid=false,label=false)#minorgrid=true, minorgridlinewidth=2, gridlinewidth=4, label=false)#, aspect_ratio=1)
        if h==1
            ylabel!("∆ Temperature [°C]", yguidefontsize=20, left_margin=300px)
        end
        push!(all_boxplots_temp, box_temp)

        if Catchment_Name == "Feistritztal"
            Catchment_Name = "Feistritz"
            println("works")
        elseif Catchment_Name == "Paltental"
            Catchment_Name = "Palten"
        end
        if h==6
            Plots.plot()
            scatter!([2], [mean(relative_error_P_85*100)], color=Farben_85[2],markerstrokewidth=0,markersize=7,xticks=:none, label="Precipitation 85")
            leg=plot!()
            push!(legends, leg)
            Plots.plot()
            scatter!([2], [mean(relative_error_T_85*100)], color=Farben_85[2],markerstrokewidth=0,markersize=7,xticks=:none, label="Temperature 85")
            leg=plot!()
            push!(legends, leg)
            Plots.plot()
            scatter!([2], [mean(relative_error_P_45*100)], color=Farben_45[2],markerstrokewidth=0,markersize=7,xticks=:none, label="Precipitation 45")
            leg=plot!()
            push!(legends, leg)
            Plots.plot()
            scatter!([2], [mean(relative_error_T_45*100)], color=Farben_45[2],markerstrokewidth=0,markersize=7,xticks=:none, label="Temperature 45")
            leg=plot!()
            push!(legends, leg)
        end

    end
    legend = Plots.plot(legends[1], legends[2], legends[3],legends[4], layout=(1,4), xticks=:none, yticks=:none, showaxis=false, grid=false, size=(2500,100), legend=:outerbottom, legendfontsize=20, left_margin=[80mm 0mm 0mm 0mm], topm_margin=20px)

    display(legend)

    combined = Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6],
        all_boxplots_prec[1], all_boxplots_prec[2], all_boxplots_prec[3], all_boxplots_prec[4], all_boxplots_prec[5], all_boxplots_prec[6],
        # all_boxplots_q[1], all_boxplots_q[2], all_boxplots_q[3], all_boxplots_q[4], all_boxplots_q[5], all_boxplots_q[6],
        # all_boxplots_q_pf[1], all_boxplots_q_pf[2], all_boxplots_q_pf[3], all_boxplots_q_pf[4], all_boxplots_q_pf[5], all_boxplots_q_pf[6],
        layout= (2,6), legend =:topright, size=(2500,750), left_margin = [20mm 0mm 0mm 0mm 0mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    #Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/annual_prec_temp_all_catchments_absolute_change_prec_q_rel4.png")
    # Plots.plot()
    display(combined)
    tot = Plots.plot(combined, legend, layout=@layout([A; B{0.01h}]), size=(2500,850))
    # Plots.plot(title, all_lines_rel[i], all_violins_rel[i], left_margin = 0mm, bottom_margin=10mm, layout=@layout([A{0.01h}; [B C{0.3w}]]), legend=:topleft)

    display(tot)

    # Plots.plot(all_boxplots_temp[1], all_boxplots_temp[2], all_boxplots_temp[3], all_boxplots_temp[4], all_boxplots_temp[5], all_boxplots_temp[6], layout= (3,2), legend = false, size=(2000,1500), left_margin = [5mm 0mm], bottom_margin = 20px, yguidefontsize=20, xtickfont = font(20), ytickfont = font(20), dpi=300)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Q-T-P/changes_temperature_prec_all_catchments_absolute_combined.png")
end

# plot_changes_prec_temp_all_catchments_test_legend(Catchment_Names_new, Catchment_Height, nr_runs_new)
