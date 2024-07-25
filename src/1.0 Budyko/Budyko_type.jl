using Plots
using StatsPlots
using DelimitedFiles
using Plots.PlotMeasures
using DocStringExtensions
using CSV
using DataFrames
using Statistics
function circleShape(h,k,r)
    tau = LinRange(0, 2*pi, 500)
    h .+ r*sin.(tau), k .+ r*cos.(tau)
end

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

Catchment_nrs = [3,4,2,6,1,5]
relative_error(future, initial)  = (future - initial) ./ initial

# include("compare_Present_Future_low_flows.jl")
# include("loadfunctions.jl")

# ------------------- Budyko Framework -------------------------
#Obtained from plots_compared_catchments
"""
This function plots the Budyko framework for all catchments, after comparing them. Not included for further calculations

    $(SIGNATURES)

Use this function only after budyko postions have been calculated and saved """

function budyko_framework_plain()
    Farben = palette(:tab10)
    Marker_Time = [:rect, :circle, :dtriangle]
    plot(collect(0:1),collect(0:1), color= "lightgrey", label="Energy Limit")#, size=(2200,1200))
    plot!(collect(1:5), ones(5), color= "lightgrey", label="Water Limit")
    Epot_Prec = collect(0:0.1:5)
    Budyko_Eact_P = ( Epot_Prec .* tanh.(1 ./Epot_Prec) .* (ones(length(Epot_Prec)) - exp.(-Epot_Prec))).^0.5
    plot!(Epot_Prec, Budyko_Eact_P, label="Budyko", color="black")
    # path_45 = "/home/sarah/Master/Thesis/Data/Projektionen/new_station_data_rcp45/rcp45/"
    # path_85 = "/home/sarah/Master/Thesis/Data/Projektionen/new_station_data_rcp85/rcp85/"
    # for (i,Catchment_Name) in enumerate(All_Catchment_Names)
    #     # aridity_past45, aridity_future_45, evaporative_past_45, evaporative_future_45 = aridity_evaporative_index(path_45, Area_Catchments[i], Catchment_Name)
    #     # aridity_past85, aridity_future_85, evaporative_past_85, evaporative_future_85 = aridity_evaporative_index(path_85, Area_Catchments[i], Catchment_Name)
    #     evaporative_past_45, evaporative_future_45, evaporative_past_85, evaporative_future_85 = readdlm("/home/sarah/Master/Thesis/Results/Projektionen/"*Catchment_Name*"/PastvsFuture/Budyko/evaporative_past_future_4585.txt",',')
    #     aridity_past45, aridity_future_45, aridity_past85, aridity_future_85 = readdlm("/home/sarah/Master/Thesis/Results/Projektionen/"*Catchment_Name*"/PastvsFuture/Budyko/aridity_past_future_4585.txt", ',')
    #     # take mean of all simulations and all runs
    #     aridity_past = (mean(aridity_past45) + mean(aridity_past85)) / 2
    #     evaporative_past = (mean(evaporative_past_45) + mean(evaporative_past_85)) / 2
    #     # plot into Budyko framework
    #     scatter!([aridity_past], [evaporative_past], label="Past", color=[Farben[i]], markershape=Marker_Time[1], markersize= 7,  markerstrokewidth= 0)
    #     scatter!([mean(aridity_future_45)], [mean(evaporative_future_45)], label = "RCP 4.5", color=[Farben[i]], markershape=Marker_Time[2], markersize= 7, markerstrokewidth= 0)
    #     scatter!([mean(aridity_future_85)], [mean(evaporative_future_85)], label = "RCP 8.5", color=[Farben[i]], markershape=Marker_Time[3], markersize= 7,  markerstrokewidth= 0)
    # end
    xlabel!("Ep/P")
    ylabel!("Ea/P")
    #vline!([0.406])
    # xlims!((0,1))
    # ylims!((0.2,0.6))
    savefig("/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Results/Plain_Budyko.png")
 end
# @time begin
# #budyko_framework_all_catchments(Catchment_Names, Area_Catchments)
# end
# budyko_framework_plain()

function mean_movement_budyko_AI_EI()
    path_budyko="/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/"
    Mean_AI_past =[]
    Mean_EI_past=[]
    Mean_w_past=[]
    Min_AI_past =[]
    Min_EI_past=[]
    Min_w_past=[]
    Max_AI_past =[]
    Max_EI_past=[]
    Max_w_past=[]
    Mean_AI_future =[]
    Mean_EI_future=[]
    Mean_w_future=[]
    Min_AI_future =[]
    Min_EI_future=[]
    Min_w_future=[]
    Max_AI_future =[]
    Max_EI_future=[]
    Max_w_future=[]
    All_AI_future =[]
    All_EI_future=[]
    All_w_future=[]
    Mean_AI_future_85 =[]
    Mean_EI_future_85=[]
    Mean_w_future_85=[]
    Min_AI_future_85 =[]
    Min_EI_future_85=[]
    Min_w_future_85=[]
    Max_AI_future_85 =[]
    Max_EI_future_85=[]
    Max_w_future_85=[]

    All_AI_future_85 =[]
    All_EI_future_85=[]
    All_w_future_85=[]
    all_names=[]
    all_nrs=[]

    past_data = CSV.read(path_budyko*"/Past/All_catchments_omega_tw_loss.csv", decimal='.', delim=',', DataFrame)
    for (n,nr) in enumerate(Catchment_nrs)
        push!(Mean_AI_past, round(past_data.AI_tw[nr],digits=3))
        push!(Mean_EI_past, round(past_data.EI[nr],digits=3))
        push!(Mean_w_past, round(past_data.w_specific_tw[nr],digits=3))
        push!(Min_AI_past, round(past_data.AI_tw[nr],digits=3))
        push!(Min_EI_past, round(past_data.EI[nr],digits=3))
        push!(Min_w_past, round(past_data.w_specific_tw[nr],digits=3))
        push!(Max_AI_past, round(past_data.AI_tw[nr],digits=3))
        push!(Max_EI_past, round(past_data.EI[nr],digits=3))
        push!(Max_w_past, round(past_data.w_specific_tw[nr],digits=3))

    end
    println(past_data)
    println(Mean_AI_past)
    rcps=["rcp45", "rcp85"]
    for (r,rcp) in enumerate(rcps)
        rcms=readdir("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/"*rcp*"/")
            for (n,nr) in enumerate(Catchment_nrs)
                for (m,rcm) in enumerate(rcms)
                    future_data = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/"*rcp*"/"*rcm*"/"*rcm*"_1981_2071_projected_budyko_tw.csv", delim=',', decimal='.', DataFrame)
                    if rcp=="rcp45"
                        push!(All_AI_future, future_data.AI_tw[nr])
                        push!(All_EI_future, future_data.EI[nr])
                        push!(All_w_future, future_data.w_tw[nr])
                        push!(all_names, Catchment_Names_new[n])
                        push!(all_nrs, m)
                    else
                        push!(All_AI_future_85, future_data.AI_tw[nr])
                        push!(All_EI_future_85, future_data.EI[nr])
                        push!(All_w_future_85, future_data.w_tw[nr])
                    end

                end
                if rcp=="rcp45"
                    push!(Mean_AI_future,round(mean(All_AI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Mean_EI_future,round(mean(All_EI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Mean_w_future,round(mean(All_w_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_AI_future,round(minimum(All_AI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_EI_future,round(minimum(All_EI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_w_future,round(minimum(All_w_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_AI_future,round(maximum(All_AI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_EI_future,round(maximum(All_EI_future[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_w_future,round(maximum(All_w_future[(n-1)*14+1:n*14]),digits=3))

                else
                    push!(Mean_AI_future_85,round(mean(All_AI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Mean_EI_future_85,round(mean(All_EI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Mean_w_future_85,round(mean(All_w_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_AI_future_85,round(minimum(All_AI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_EI_future_85,round(minimum(All_EI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Min_w_future_85,round(minimum(All_w_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_AI_future_85,round(maximum(All_AI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_EI_future_85,round(maximum(All_EI_future_85[(n-1)*14+1:n*14]),digits=3))
                    push!(Max_w_future_85,round(maximum(All_w_future_85[(n-1)*14+1:n*14]),digits=3))

                end
            end
                # push!(Mean_AI_future, future_data.AI_tw[nr])
                # push!(Mean_EI_future, future_data.EI[nr])
                # push!(Mean_w_future, future_data.w_specific_tw[nr])
        end
        Mean_RC_past =[]
        Mean_Q_past=[]
        Mean_RC_future =[]
        Mean_Q_future=[]
        All_RC_future =[]
        All_Q_future=[]
        Mean_RC_future_85 =[]
        Mean_Q_future_85=[]
        All_RC_future_85 =[]
        All_Q_future_85=[]
        all_names=[]
        all_nrs=[]
            rcps=["rcp45", "rcp85"]
            for (r,rcp) in enumerate(rcps)
                rcms=readdir("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/"*rcp*"/")
                    for (n,nr) in enumerate(Catchment_nrs)
                        for (m,rcm) in enumerate(rcms)
                            future_data = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/"*rcp*"/"*rcm*"/"*rcm*"_1981_2071_projected_RC_hgtw.csv", delim=',', decimal='.', DataFrame)
                            if rcp=="rcp45"
                                push!(All_RC_future, future_data.RC_pro_tw[nr])
                                push!(All_Q_future, future_data.Q_pro_tw[nr])
                                push!(all_names, Catchment_Names_new[n])
                                push!(all_nrs, m)
                            else
                                push!(All_RC_future_85, future_data.RC_pro_tw[nr])
                                push!(All_Q_future_85, future_data.Q_pro_tw[nr])
                            end

                        end
                        if rcp=="rcp45"
                            push!(Mean_RC_future,round(mean(All_RC_future[(n-1)*14+1:n*14]),digits=3))
                            push!(Mean_Q_future,round(mean(All_Q_future[(n-1)*14+1:n*14]),digits=3))
                        else
                            push!(Mean_RC_future_85,round(mean(All_RC_future_85[(n-1)*14+1:n*14]),digits=3))
                            push!(Mean_Q_future_85,round(mean(All_Q_future_85[(n-1)*14+1:n*14]),digits=3))
                        end
                        # push!(Mean_RC_future, future_data.RC_tw[nr])
                        # push!(Mean_Q_future, future_data.Q[nr])
                        # push!(Mean_w_future, future_data.w_specific_tw[nr])
                end
                # All_movements = DataFrame(Catchment = all_names, Projection_nr = all_nrs, All_RC_future = All_RC_future, All_Q_future = All_Q_future,All_w_future = All_w_future, All_RC_future_85 = All_RC_future_85, All_Q_future_85 = All_Q_future_85,All_w_future_85 = All_w_future_85)
                # Mean_movements = DataFrame(Catchments = Catchment_Names_new, Mean_RC_past = Mean_RC_past, Mean_Q_past = Mean_Q_past,Mean_w_past = Mean_w_past,Mean_RC_future = Mean_RC_future, Mean_Q_future = Mean_Q_future,Mean_w_future = Mean_w_future, Mean_RC_future_85 = Mean_RC_future_85, Mean_Q_future_85 = Mean_Q_future_85,Mean_w_future_85 = Mean_w_future_85)
                # CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_movements_budyko_RC.csv", Mean_movements)
                # CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/All_movements_budyko_RC.csv", All_movements)

        end

        Total_mean_movements = DataFrame(Catchments = Catchment_Names_new, Mean_AI_past =Mean_AI_past, Mean_EI_past=Mean_EI_past, Mean_w_past=Mean_w_past, Mean_AI_future =Mean_AI_future, Mean_AI_future_85 =Mean_AI_future_85, Mean_EI_future=Mean_EI_future, Mean_EI_future85 =Mean_EI_future_85, Mean_RC_future = Mean_RC_future, Mean_RC_future_85 = Mean_RC_future_85, Mean_Q_future = Mean_Q_future, Mean_Q_future_85 = Mean_Q_future_85)
        # All_movements = DataFrame(Catchment = all_names, Projection_nr = all_nrs, All_AI_future = All_AI_future, All_EI_future = All_EI_future,All_w_future = All_w_future, All_AI_future_85 = All_AI_future_85, All_EI_future_85 = All_EI_future_85,All_w_future_85 = All_w_future_85)
        Mean_movements = DataFrame(Catchments = Catchment_Names_new, Mean_AI_past = Mean_AI_past, Mean_EI_past = Mean_EI_past,Mean_w_past = Mean_w_past,Mean_AI_future = Mean_AI_future, Mean_EI_future = Mean_EI_future,Mean_w_future = Mean_w_future, Mean_AI_future_85 = Mean_AI_future_85, Mean_EI_future_85 = Mean_EI_future_85,Mean_w_future_85 = Mean_w_future_85)
        Min_movements = DataFrame(Catchments = Catchment_Names_new, Min_AI_past = Min_AI_past, Min_EI_past = Min_EI_past,Min_w_past = Min_w_past,Min_AI_future = Min_AI_future, Min_EI_future = Min_EI_future,Min_w_future = Min_w_future, Min_AI_future_85 = Min_AI_future_85, Min_EI_future_85 = Min_EI_future_85,Min_w_future_85 = Min_w_future_85)
        Max_movements = DataFrame(Catchments = Catchment_Names_new, Max_AI_past = Max_AI_past, Max_EI_past = Max_EI_past,Max_w_past = Max_w_past,Max_AI_future = Max_AI_future, Max_EI_future = Max_EI_future,Max_w_future = Max_w_future, Max_AI_future_85 = Max_AI_future_85, Max_EI_future_85 = Max_EI_future_85,Max_w_future_85 = Max_w_future_85)
        CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_movements_budyko_.csv", Mean_movements)
        CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Min_movements_budyko_.csv", Min_movements)
        CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Max_movements_budyko_.csv", Max_movements)
        # CSV.write("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/All_movements_budyko.csv", All_movements)

end


"""
Plots the changes in the Budyko framework of future and present for RCP 4.5 and 8.5.

$(SIGNATURES)
The input are the path to the projection and the size of the catchment in (m²)
"""
function plot_changes_Budyko()

    All_AI=[]
    All_EI=[]
    future_data = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/Budyko/Projections/Combined/All_movements_budyko.csv", decimal='.', delim=',', DataFrame)
    past_data = CSV.read("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/Budyko/Projections/Combined/Mean_movements_budyko.csv", decimal='.', delim=',', DataFrame)
    aridity_past = past_data.Mean_AI_past
    evaporative_past = past_data.Mean_EI_past
    aridity_future_45 = future_data.All_AI_future
    aridity_future_85 = future_data.All_AI_future_85
    evaporative_future_45 = future_data.All_EI_future
    evaporative_future_85 = future_data.All_EI_future_85

    Farben_85= [palette(:reds)[1], :firebrick]
    Farben_45= [palette(:blues)[1], :blue3]

    errors_AI45=zeros(6,14)
    errors_AI85=zeros(6,14)

    for k in 1:6
        change = Plots.violin(["RCP 4.5"],aridity_future_45[(k-1)*14+1:k*14]- ones(14)*aridity_past[k], color=Farben_45[2], label=false)
        violin!(["RCP 8.5"],aridity_future_85[(k-1)*14+1:k*14]- ones(14)*aridity_past[k], color=color=Farben_85[2], label=false)
        scatter!(ones(14)*0.5, [aridity_future_45[(k-1)*14+1:k*14] - ones(14)*aridity_past[k]], color=:black, label=false)
        scatter!(["RCP 4.5"], [mean(aridity_future_45[(k-1)*14+1:k*14] - ones(14)*aridity_past[k])], color=:white, markersize=6, label=false)
        scatter!(ones(14)*1.9, [aridity_future_85[(k-1)*14+1:k*14] - ones(14)*aridity_past[k]], color=:black, label=false)
        scatter!(["RCP 8.5"], [mean(aridity_future_85[(k-1)*14+1:k*14] - ones(14)*aridity_past[k])], color=:white,markersize=6, label=false)

        errorAI_45 = aridity_future_45[(k-1)*14+1:k*14]- ones(14)*aridity_past[k]
        errorAI_85 = aridity_future_85[(k-1)*14+1:k*14]- ones(14)*aridity_past[k]
        # println(size(errorAI_45))
        errors_AI45[k,:] = errorAI_45
        errors_AI85[k,:] = errorAI_85
        # title!("Change in Aridity Index: Future - Past")
        ylims!(-0.2,0.4)
        xticks!([1:1:2;], ["",""])

        title!(string(Catchment_Names_new[k])*" ("*string(Catchment_Height[k])*"m)")
        if k==1
            ylabel!("∆ Aridity Index [-]", yguidefontsize=14)
            yticks!([-0.2:0.2:0.4;])

        else
            yticks!([-0.2:0.2:0.4;], ["","","",""])
        end
        push!(All_AI, change)
    end

    AI = Plots.plot(All_AI[1],All_AI[2],All_AI[3],All_AI[4],All_AI[5],All_AI[6], layout=(1,6))
    errors_EI45=zeros(6,14)
    errors_EI85=zeros(6,14)

    for k in 1:6

        change = Plots.violin(["RCP 4.5"], evaporative_future_45[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k], color=Farben_45[2], label=false)
        # if k==6
        #     scatter!(["RCP 4.5"], [mean(evaporative_future_45[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k])], color=Farben_45[2], markerstrokewidth=0,label="RCP 4.5", markersize=1)
        #     scatter!(["RCP 8.5"], [mean(evaporative_future_85[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k])], color=Farben_85[2], markerstrokewidth=0,label="RCP 8.5", markersize=1)
        # end

        scatter!(ones(14)*0.5, [evaporative_future_45[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k]], color=:black, label=false)
        scatter!(["RCP 4.5"], [mean(evaporative_future_45[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k])], color=:white, markersize=6, label=false)

        violin!(["RCP 8.5"],evaporative_future_85[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k], color=Farben_85[2], label=false)
        scatter!(ones(14)*1.9, [evaporative_future_85[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k]], color=:black, label=false)
        scatter!(["RCP 8.5"], [mean(evaporative_future_85[(k-1)*14+1:k*14] - ones(14)*evaporative_past[k])], color=:white, markersize=6, label=false)
        errorEI_45 = evaporative_future_45[(k-1)*14+1:k*14]- ones(14)*aridity_past[k]
        errorEI_85 = evaporative_future_85[(k-1)*14+1:k*14]- ones(14)*aridity_past[k]
        println(size(errorEI_45))
        errors_EI45[k,:] = errorEI_45
        errors_EI85[k,:] = errorEI_85


        # title!("Change in Evaporative Index: Future - Past")
        ylims!(-0.1,0.2)
        xticks!([0.5:1.4:1.9;], ["RCP4.5","RCP8.5"])

        if k==1
            ylabel!("∆ Evaporative Index [-]", yguidefontsize=14)
            yticks!([-0.1:0.1:0.2;])
        else
            yticks!([-0.1:0.1:0.2;], ["","",""])
        end
        push!(All_EI, change)
    end
    EI = Plots.plot(All_EI[1],All_EI[2],All_EI[3],All_EI[4],All_EI[5],All_EI[6], layout=(1,6))
    #
    total = Plots.plot(AI, EI, layout=(2,1), size=(2000,700), left_margin=[10mm 0mm 0mm 0mm 0mm 0mm], top_margin=[10mm 0mm], xtickfont = font(18), ytickfont = font(18), guidefont=font(18), titlefont=font(18), grid=false, minorgrid=false, bottom_margin=20px, titlelocation=:center)
    display(total)
    Plots.savefig("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/Budyko/Projections/Combined/Budyko_Violins_L3.png")
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_error_movements_EI45.txt",errors_EI45,',')
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_error_movements_AI45.txt",errors_AI45,',')
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_error_movements_EI85.txt",errors_EI85,',')
    # writedlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/Budyko/Projections/Combined/Mean_error_movements_AI85.txt",errors_AI85,',')
end

plot_changes_Budyko()
