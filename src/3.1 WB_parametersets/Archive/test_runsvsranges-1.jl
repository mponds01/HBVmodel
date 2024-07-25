using Plotly
using DelimitedFiles
using Plots
using Statistics
using StatsPlots
using Plots.PlotMeasures
using CSV
using Dates
using Random
# using StatsBase

"""
This function investigates the impact of nr of parameters used to estimate the range in Srdef.
    $SIGNATURES
"""

function runsvsrange()
    local_path = "/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/"
    directing_tree = "Results/Rootzone/Test_#runs/"
    timeframe = [1981, 2068, "Past"]
    samplesize = [50, 100, 300, 500, 1000]
    index = 1:1:3805
    for (s,sz) in enumerate(samplesize)
        indexs = sample(index, sz, replace=false, ordered=false)
        #println(indexs)
        for (t,tf) in enumerate(timeframe)
            parent_file = CSV.read(local_path*directing_tree*string(tf)*"_GEV_T_Total_titled_test3805.csv", DataFrame, decimal = '.', delim = ',')#[random,:]
            parent_file = Matrix(parent_file)
            parent_file= parent_file[indexs,:]
            open(local_path*directing_tree*string(tf)*"_GEV_T_Total_titled_test"*string(sz)*".csv", "a") do io
                        writedlm(io, parent_file,",")

                    end
        end
    end
    return
end

# runsvsrange()

function ranges_srdef_test()
    local_path="/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Test_#runs/"
    folder_path = "/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Test_#runs/"
    catchments = ["Defreggental"]#, "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]
    mode =0
    samplesize = [50, 100, 300, 500, 1000]

    for (s,sz) in enumerate(samplesize)

        mod_past = CSV.read(local_path*"1981_GEV_T_total_titled_test"*string(sz)*".csv", DataFrame, decimal = '.', delim = ',')
        mod_future = CSV.read(local_path*"/2068_GEV_T_total_titled_test"*string(sz)*".csv",DataFrame, decimal = '.', delim = ',')
        obs_past = CSV.read(local_path*"/Past_GEV_T_total_titled_test"*string(sz)*".csv", DataFrame, decimal = '.', delim = ',')
        samplesize = [50, 100, 300, 500, 1000]

        #minima_hg = zeros(6)
        minima_tw=zeros(6)
        #maxima_hg = zeros(6)
        maxima_tw=zeros(6)

        PE= ["Thorntwaite"]
        for (e,ep_method) in enumerate(PE)

                OP_min_grass = minimum(-obs_past[:,2*e])
                MP_min_grass = minimum(-mod_past[:,2*e])
                MF_min_grass = minimum(-mod_future[:,2*e])
                OP_max_grass = maximum(-obs_past[:,2*e])
                MP_max_grass = maximum(-mod_past[:,2*e])
                MF_max_grass = maximum(-mod_future[:,2*e])

                OP_min_forest = minimum(-obs_past[:,2*e+1])
                MP_min_forest = minimum(-mod_past[:,2*e+1])
                MF_min_forest = minimum(-mod_future[:,2*e+1])
                OP_max_forest = maximum(-obs_past[:,2*e+1])
                MP_max_forest = maximum(-mod_past[:,2*e+1])
                MF_max_forest = maximum(-mod_future[:,2*e+1])

                if e==1
                    minima_tw = [OP_min_grass, MP_min_grass, MF_min_grass, OP_min_forest, MP_min_forest, MF_min_forest]
                    maxima_tw = [OP_max_grass, MP_max_grass, MF_max_grass, OP_max_forest, MP_max_forest, MF_max_forest]
                else
                    minima_hg = [OP_min_grass, MP_min_grass, MF_min_grass, OP_min_forest, MP_min_forest, MF_min_forest]
                    maxima_hg = [OP_max_grass, MP_max_grass, MF_max_grass, OP_max_forest, MP_max_forest, MF_max_forest]
                end
        end
        index = ["OP_grass", "MP_grass", "MF_grass", "OP_forest", "MP_forest", "MF_forest"]
        # df = DataFrame(index = index, TW_min = minima_tw, TW_max = maxima_tw)#, HG_min = minima_hg, HG_max = maxima_hg)
        # CSV.write( folder_path*cm*"_srdef_range_test"*string(sz)*".csv", df)
    end
    return
end
#ranges_srdef_test()

function plot_parameter_range()

    local_path="/Users/rubenvanstreun/Documents/MacBookPro/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/"
    folder_path = "/Users/rubenvanstreun/Documents/MacBookPro/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Test_#runs/"
    catchments = ["Defreggental"]#, "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]
    vegetationtype = ["Grass", "Forest"]
    samplesize = [50, 100, 300, 500, 3805]
    timeframe = ["Obs Past", "Mod Fut"]
    minmax = ["min","max"]
    Color = palette(:tab10)
    Markers = [:hline, :x]
    colours = ["grey", "red"]
    overview_ranges=[]
    # labels = [ep_method*" Observed Past", ep_method*" Modelled Past", ep_method*" Modelled Future", "Calibrated"]
    for (c,cm) in enumerate(catchments)
        # end
        combined=[]
        for (v,vt) in enumerate(vegetationtype)
            ranges=Plots.plot()
            for (s, sz) in enumerate(samplesize)
                # if sz==300
                #     data = CSV.read(folder_path*"Defreggental_srdef_range.csv", DataFrame, decimal = '.', delim = ',')
                # else
                data = CSV.read(folder_path*cm*"_srdef_range_test"*string(sz)*".csv", DataFrame, decimal = '.', delim = ',')
                for (t,tf) in enumerate(timeframe)

                    for (m,mm) in enumerate(minmax)


                            # if c>1
                            #     setlabel = [false, false, false, false]
                            # elseif c ==1
                            #     setlabel = labels
                            # end
                            # if e==1
                            if s==2 && t==1 && v==2 && m==2
                                legend=mm
                            elseif s==3 && t==1 && v==2 && m==1
                                legend=mm
                            else
                                legend=false
                            end
                            # println("info for ss x tf",sz, tf, mm)
                            # println(data[t+(v-1)*3,m+1])

                            scatter!([s],[data[t+(v-1)*3,m+1]], color=colours[t], marker = Markers[m], markerstrokewidth=0, label=legend, legend=:outerright)
                            if v==1
                                yaxis!("Sr [mm]")
                            end
                            if s==1 && t==1 && m==2 &v==2
                                #if v==2
                                    scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker=:rect, markersize=1, markerstrokewidth=0, label=tf)
                                #end
                            elseif s==1 && m==2 &v==2
                                # legend=tf
                                    scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker=:rect, markersize=1, markerstrokewidth=0, label=tf)
                            else
                                legend=false
                            end
                    end
                end


            end
             ylims!((5,70))
            xaxis!("Samplesize")
            title!(vt)
            xticks!([1:5;],["50", "100", "300", "500", "3805"])
            #display(ranges)
            push!(combined, ranges)

        end
        total_cm = Plots.plot(combined[1], combined[2], size=(1000,500), layout=grid(1,2, widths=[0.47,0.53]),left_margin = [5mm 0mm], bottom_margin = 20px)
        Plots.savefig(folder_path*cm*"_Runs_vs_range_comparison.png")
        display(total_cm)
        push!(overview_ranges, total_cm)
    end
    # total_all = Plots.plot(overview_ranges[1], overview_ranges[2],overview_ranges[3],overview_ranges[4],overview_ranges[5],overview_ranges[6], size=(1000,500), layout=grid(3,2, widths=[0.47,0.53]),left_margin = [5mm 0mm], bottom_margin = 20px)
    # display(total_all)
    # Plots.savefig(folder_path*"Runs_vs_range_comparison"*vt*".png")


end


plot_parameter_range()

function plot_parameter_range_all_cm()

    local_path="/Users/rubenvanstreun/Documents/MacBookPro/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/"
    folder_path = "/Users/rubenvanstreun/Documents/MacBookPro/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Rootzone/Test_#runs/"
    catchments = ["Defreggental", "Feistritz", "Gailtal", "Palten", "Pitztal", "Silbertal"]
    vegetationtype = [ "Grass"]
    samplesize = [50, 100, 300, 500, 3805]
    timeframe = ["Observed Past", "Mod Fut"]
    minmax = ["min","max"]
    Color = palette(:tab10)
    Markers = [:hline, :x]
    colours = ["black", "red"]
    overview_ranges=[]
    # labels = [ep_method*" Observed Past", ep_method*" Modelled Past", ep_method*" Modelled Future", "Calibrated"]
    for (c,cm) in enumerate(catchments)
        # end
        combined=[]
        for (v,vt) in enumerate(vegetationtype)
            ranges=Plots.plot()
            for (s, sz) in enumerate(samplesize)
                # if sz==300
                #     data = CSV.read(folder_path*"Defreggental_srdef_range.csv", DataFrame, decimal = '.', delim = ',')
                # else
                data = CSV.read(folder_path*cm*"_srdef_range_test"*string(sz)*".csv", DataFrame, decimal = '.', delim = ',')
                for (t,tf) in enumerate(timeframe)

                    for (m,mm) in enumerate(minmax)


                            # if c>1
                            #     setlabel = [false, false, false, false]
                            # elseif c ==1
                            #     setlabel = labels
                            # end
                            # if e==1
                            l=" "
                            if s==2 && t==1  && m==2 &&c==6
                                l=mm
                            elseif s==3 && t==1  && m==1 &&c==6
                                l=mm
                            else
                                l=false
                            end
                            # println("info for ss x tf",sz, tf, mm)
                            # println(data[t+(v-1)*3,m+1])

                            scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker = Markers[m], markerstrokewidth=0, label=l, legend=:topright)


                            if c in [1,3,5]
                                yaxis!("Sr [mm]")
                            end
                            if c in [5,6]
                                xaxis!("Samplesize")
                            end
                            if s==1 && t==1 &&m==1 &&c==6
                                #if v==2
                                scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker=:rect, markersize=1, markerstrokewidth=0, label=tf)
                            elseif s==1  && m==1 &&c==6
                                # legend=tf
                                scatter!([s], [data[t+(v-1)*3,m+1]], color=colours[t], marker=:rect, markersize=1, markerstrokewidth=0, label=tf)
                            end


                    end
                end


            end
            title!(cm, titlefont=12)
            ylims!((5,100))
            #title!(vt)
            xticks!([1:5;],["50", "100", "300", "500", "3805"])
            #display(ranges)
            push!(combined, ranges)

        end

        total_cm = Plots.plot(combined[1],size=(1000,500),left_margin = [5mm 0mm], bottom_margin = 20px)
        # Plots.savefig(folder_path*cm*"_Runs_vs_range_comparison_vt.png")
        push!(overview_ranges, total_cm)
        display(total_cm)
    end
    y = ones(3)
    title = Plots.scatter(y, marker=0,markeralpha=0, annotations=(2, y[2], Plots.text("Grass", font(20))), axis=false, grid=false, ticks=false, leg=false,size=(200,100))
    # l = @layout [a b{0.5w}; c d{0.5w}; e f{0.7w}]
    total_all = Plots.plot(overview_ranges[1], overview_ranges[2],overview_ranges[3],overview_ranges[4],overview_ranges[5],overview_ranges[6], size=(1100,1000), layout=grid(3,2), left_margin = [5mm 0mm], bottom_margin = 20px)
    total = Plots.plot(title, total_all, layout=grid(2,1,heights=[0.02,0.98]))
    display(total)
    Plots.savefig(folder_path*"Total_Runs_vs_range_comparison_Grass.png")


end
#plot_parameter_range_all_cm()
