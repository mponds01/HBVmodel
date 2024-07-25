using Dates
using DelimitedFiles



function clean_combine_NS_projections(path_to_projections, Catchment_Name)
    Name_Projections = readdir(path_to_projections)
    Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
    Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/End_Timeseries_45_85.txt",',')

    if path_to_projections[end-2:end-1] == "45"
        index = 1
        rcp = "rcp45"
        print(rcp, " ", path_to_projections)
    elseif path_to_projections[end-2:end-1] == "85"
        index = 2
        rcp="rcp85"
        print(rcp, " ", path_to_projections)
    end
    average_monthly_Discharge_past = Float64[]
    average_monthly_Discharge_future = Float64[]
    error_average_monthly_Discharge_all_runs = Float64[]
    all_months_all_runs = Float64[]
    path_projected = "/Volumes/Magali 2/Data_projected/"
    save_path = "/Volumes/Magali 2/Data_projected/"

    for (i, name) in enumerate(Name_Projections[1:end])
        #if Catchment_Name!="Palten" || Catchment_Name=="Palten" && i >=11 && rcp=="rcp85"
        if Catchment_Name=="Pitztal" && i == 7 && rcp=="rcp45"
            rm(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv")

            println(name)
            println()


            Timeseries_Future = collect(Date(Timeseries_End[i,index]-29,1,1):Day(1):Date(Timeseries_End[i,index],12,31))
            #allfiles_f = readdir(path_projected*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/")
            allfiles_p = readdir(path_projected*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/")
            files_f=[]
            files_p=[]
                for (f,file) in enumerate(allfiles_p)
                    if occursin("NS_model_results_discharge", file)
                        #push!(files_f, file)
                        push!(files_p, allfiles_p[f])
                    end
                end
                for (i, iterator) in enumerate(files_p)
                    println(i)

                    Past_Discharge = readdlm(path_projected*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/"*files_p[i], ',')
                    #Future_Discharge = readdlm(path_projected*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/"*iterator, ',')
                    println(size(Past_Discharge)[1])
                    if size(Past_Discharge)[1] > 500
                         mid = Int(size(Past_Discharge)[1]/2)
                         println(mid)
                    #
                         println("toolarge past", size(Past_Discharge)[1], rcp, name)
                         Past_Discharge = Past_Discharge[1:mid,:]
                         println("new past", size(Past_Discharge)[1], rcp, name)


                    end
                #     if size(Future_Discharge)[1] > 800
                # #    if size(Future_Discharge)[1] > 800
                #         midf = Int(size(Future_Discharge)[1]/2)
                #         println("toolarge future", size(Future_Discharge)[1], rcp, name)
                #         Future_Discharge == Future_Discharge[1:midf,:]
                        # open(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Future.csv", "a") do io
                        #         writedlm(io, Future_Discharge,",")
                        #end


                    # end
                open(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", "a") do io
                            writedlm(io, Past_Discharge,",")
                   end
                    # open(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_WB_PforF_streamflow_projection_Future.csv", "a") do io
                    #         writedlm(io, Future_Discharge,",")
                    # end
                    # open(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", "a") do io
                            # writedlm(io, Past_Discharge,",")
                    # end
                end
            end
        end

        return

end

path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp45/"
path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/Projections/climate_simulations/rcp85/"

catchment_loop =[ "Pitztal"]#"Defreggental","Palten"]#,"Feistritz", "Gailtal",
for (c,cm) in enumerate(catchment_loop)
    # println(cm)
    # @time begin
    # println(cm, " project rcp45")
    # Monthly_Discharge_Change_45, monthly_Discharge_past_45, monthly_Discharge_future_45, months_45 = change_monthly_Discharge(path_45, cm)
    # writedlm("D:/Results/Projections_NS/"*cm*"/PastvsFuture/Monthly_Discharge/NS_discharge_months_4.5.txt",hcat(months_45, monthly_Discharge_past_45, monthly_Discharge_future_45, Monthly_Discharge_Change_45),',')
    # end
    #
    # @time begin
    # println(cm, " project rcp85")
    # Monthly_Discharge_Change_85, monthly_Discharge_past_85, monthly_Discharge_future_85, months_85 = change_monthly_Discharge(path_85, cm)
    # writedlm("D:/Results/Projections_NS/"*cm*"/PastvsFuture/Monthly_Discharge/NS_discharge_months_8.5.txt",hcat(months_85, monthly_Discharge_past_85, monthly_Discharge_future_85, Monthly_Discharge_Change_85),',')
    # end
    @time begin
    clean_combine_NS_projections(path_45, cm)
    end
    @time begin
    clean_combine_NS_projections(path_85, cm)
    end
end

function clean_combine_NS_projections_error(path_to_projections, Catchment_Name)
    Name_Projections = readdir(path_to_projections)
    Timeseries_Past = collect(Date(1981,1,1):Day(1):Date(2010,12,31))
    Timeseries_End = readdlm("/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Data/End_Timeseries_45_85.txt",',')

    if path_to_projections[end-2:end-1] == "45"
        index = 1
        rcp = "rcp45"
        print(rcp, " ", path_to_projections)
    elseif path_to_projections[end-2:end-1] == "85"
        index = 2
        rcp="rcp85"
        print(rcp, " ", path_to_projections)
    end
    average_monthly_Discharge_past = Float64[]
    average_monthly_Discharge_future = Float64[]
    error_average_monthly_Discharge_all_runs = Float64[]
    all_months_all_runs = Float64[]
    path_projected = "/Volumes/Magali 2/Data_projected/"
    save_path = "/Volumes/Magali 2/Data_projected/"

    for (i, name) in enumerate(Name_Projections[7:8])#1:end])
        # if i==7
        #     println(Catchment_Name, " ", name)
        #     Timeseries_Future = collect(Date(Timeseries_End[i,index]-29,1,1):Day(1):Date(Timeseries_End[i,index],12,31))
        #     allfiles_f = readdir(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/")
        #     allfiles_p = readdir(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/")
            # files_f=[]
            # files_p=[]
            # for (f,file) in enumerate(allfiles_f)
            #     if occursin("discharge", file)
            #         push!(files_f, file)
            #         push!(files_p, allfiles_p[f])
            #     end
            # end
                Past_Discharge = readdlm(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", ',')
                Future_Discharge = readdlm(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Future.csv", ',')
                    println("Past_Discharge", size(Past_Discharge)[1])

                    println("Future_Discharge", size(Future_Discharge)[1])
                    if Catchment_Name==Palten
                        mid = Int(size(Past_Discharge)[1]/2)
                        midf = Int(size(Future_Discharge)[1]/2)

                        writedlm(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past_2.csv", Past_Discharge[1:mid,:], ',')
                        writedlm(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Future_2.csv", Future_Discharge[1:midf,:], ',')
                    end
                end




                # open(save_path*"Future/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Future.csv", "a") do io
                #         writedlm(io, Future_Discharge,",")
                # end
                # open(save_path*"Past/NS/"*Catchment_Name*"/"*rcp*"/"*name*"/combined_NS_streamflow_projection_Past.csv", "a") do io
                #         writedlm(io, Past_Discharge,",")
                # end

        return

end

# path_45 = "C:/Users/Ploertenpaleis/Magali/Thesis-model/Thesis-model-main/Data/Projections/climate_simulations/rcp45/"
# path_85 = "C:/Users/Ploertenpaleis/Magali/Thesis-model/Thesis-model-main/Data/Projections/climate_simulations/rcp85/"

# catchment_loop =[ "Defreggental", "Palten",  "Feistritz", "Gailtal",  "Pitztal", "Silbertal"]
# for (c,cm) in enumerate(catchment_loop)
#     println(cm)
#     # @time begin
#     # println(cm, " project rcp45")
#     # Monthly_Discharge_Change_45, monthly_Discharge_past_45, monthly_Discharge_future_45, months_45 = change_monthly_Discharge(path_45, cm)
#     # writedlm("D:/Results/Projections_NS/"*cm*"/PastvsFuture/Monthly_Discharge/NS_discharge_months_4.5.txt",hcat(months_45, monthly_Discharge_past_45, monthly_Discharge_future_45, Monthly_Discharge_Change_45),',')
#     # end
#     #
#     # @time begin
#     # println(cm, " project rcp85")
#     # Monthly_Discharge_Change_85, monthly_Discharge_past_85, monthly_Discharge_future_85, months_85 = change_monthly_Discharge(path_85, cm)
#     # writedlm("D:/Results/Projections_NS/"*cm*"/PastvsFuture/Monthly_Discharge/NS_discharge_months_8.5.txt",hcat(months_85, monthly_Discharge_past_85, monthly_Discharge_future_85, Monthly_Discharge_Change_85),',')
#     # end
#     @time begin
#     clean_combine_NS_projections_error(path_45, cm)
#     end
#     @time begin
#     clean_combine_NS_projections_error(path_85, cm)
#     end
# end
