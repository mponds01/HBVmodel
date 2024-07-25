# using Plots
using Plotly
using PlotlyJS
using CSV, DataFrames
using Colors
using
Catchment_Names_new = ["Feistritztal", "Paltental", "Gailtal", "Silbertal", "Defreggental", "Pitztal","Legend"]
Catchment_Height = [917, 1315, 1476, 1776, 2233, 2558,0]

# p = plot(rand(10, 4))
# colours =[:grey, palette(:reds)[1],palette(:reds)[2],palette(:blues)[1],palette(:blues)[2]]
date_past = [162, 174, 273, 193, 196, 189,0]./365 .*360
std_past = [10,9,22,9,10,7,0]./365 .*360
date_future_45_s = [163, 173, 294, 177, 191, 179,0]./365 .*360
date_future_45_a = [165, 167, 296, 174, 188, 177,0]./365 .*360
std_future_45_s = [15,19,15,11,16,11,0]./365 .*360
std_future_45_a = [15,20,19,13,16,11,0]./365 .*360
change_future_45_s = [1,1,21,-16,-5,-10,0]./365 .*360
change_future_45_a = [3,-7,23,-19,-8,-12,0]./365 .*360

date_future_85_s = [145,168,308,170,198,175,0]./365 .*360
date_future_85_a = [151,151,307,162,193,172,0]./365 .*360
std_future_85_s = [30,26,17,16,20,14,0]./365 .*360
std_future_85_a = [26,25,47,19,21,14,0]./365 .*360
change_future_85_s = [-17,-6,35,-23,2,-14,0]./365 .*360
change_future_85_a = [-11,-23,34,-31,-3,-17,0]./365 .*360
Colours=[:grey,:lightblue,:darkblue,:lightpink,:darkred,:white]
#
# delays = [162, 163, 165, 145, 151,]./365 .*360
# widths = [1,1,1,1,1,]./365 .*360
# widths2=[ 10, 15, 15, 30, 26,] ./365 .*360 .*2
# println(widths)
months = [0,31,59,90,121,151,182,212,242,273,303,334] ./365 .*360
# All_charts=[]
All_charts = []
sectors =[[-45,-135], [-45,-135], [135,225], [-45,-135],[-45,-135],[-45,-135],[-45,-135],]
ranges = [[10,-30],[10,-30],[-30,35],[10,-30],[10,-30],[10,-30],[10,-10],]
angles = [90,90,180,90,90,90,0,]

bottom = [150,150,10,150,150,150,0,]
for c in 1:7
    if c!=7
    #
        barpolarchart= Plot([
        barpolar(r=[1], theta=[date_past[c]], width=[std_past[c]], marker_line_width=0, opacity=0.2, marker_color=Colours[1], showlegend=false),
        barpolar(r=[1], theta=[date_future_45_a[c]], width=[std_future_45_a[c]], marker_line_width=0, opacity=0.2, marker_color=Colours[3], showlegend=false),
        barpolar(r=[1], theta=[date_future_85_a[c]], width=[std_future_85_a[c]], marker_line_width=0, opacity=0.2, marker_color=Colours[5], showlegend=false),
        barpolar(r=[1], theta=[date_future_85_s[c]], width=[std_future_85_s[c]], marker_line_width=0, opacity=0.2, marker_color=Colours[4], showlegend=false),
        barpolar(r=[1], theta=[date_future_45_s[c]], width=[std_future_45_s[c]], marker_line_width=0, opacity=0.2, marker_color=Colours[2], showlegend=false),
        scatterpolar(r=[0,1], theta=ones(2)*date_past[c], mode="lines", opacity=1, line_width=4, marker_color=Colours[1], showlegend=false),
        scatterpolar(r=[0,1], theta=ones(2)*date_future_45_a[c],mode="lines", opacity=1, line_width=4, marker_color=Colours[3], showlegend=false),
        scatterpolar(r=[0,1], theta=ones(2)*date_future_85_a[c], mode="lines", opacity=1, line_width=4, marker_color=Colours[5], showlegend=false),
        scatterpolar(r=[0,1], theta=ones(2)*date_future_85_s[c], mode="lines",  opacity=1, line_width=4, marker_color=Colours[4], showlegend=false),
        scatterpolar(r=[0,1], theta=ones(2)*date_future_45_s[c], mode="lines", opacity=1, line_width=4, marker_color=Colours[2], showlegend=false)

        ],
        Layout(margin=200,title_text = Catchment_Names_new[c]*" ("*string(Catchment_Height[c])*"m)", titlefont_size=20, title_x=0.5,
            polar = attr(width=100, height=100, bgcolor=:white, color=:black,
            radialaxis = attr(range=[0,1],angle = -angles[c], showticklabels=false, showgrid=true,  ticks="", tickangle=-90, linecolor=:white),
            angularaxis = attr(rotation=90, direction="clockwise", showticklabels=true, ticks="outside", tickmode="array",tickvals = months, ticktext=["J", "F", "M", "A", "M","J", "J", "A", "S", "O", "N", "D"],
            tickfont_size=20, showgrid=true, gridcolor=:lightgrey, griddash="solid", showline=true, linecolor=:black))))

        push!(All_charts, barpolarchart)
        println(length(All_charts))
        savefig(barpolarchart, "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/All_Catchments/Annual_Discharge/L2/Sector_timings_total_"*string(c)*"_L2.png")
    else
        barpolarchart= Plot([
        barpolar(r=[35], theta=[date_past[c]], width=[std_past[c]], marker_line_width=0, opacity=1, marker_color=Colours[1], name="Past"),
        barpolar(r=[35], theta=[date_future_45_s[c]], width=[std_future_45_s[c]], marker_line_width=0, opacity=1, marker_color=Colours[2], name="RCP4.5,clim,stat"),
        barpolar(r=[35], theta=[date_future_45_a[c]], width=[std_future_45_a[c]], marker_line_width=0, opacity=1, marker_color=Colours[3], name="RCP4.5,clim,adapt"),
        barpolar(r=[35], theta=[date_future_85_s[c]], width=[std_future_85_s[c]], marker_line_width=0, opacity=1, marker_color=Colours[4], name="RCP8.5,clim,stat"),
        barpolar(r=[35], theta=[date_future_85_a[c]], width=[std_future_85_a[c]], marker_line_width=0, opacity=1, marker_color=Colours[5], name="RCP8.5,clim,adapt"),

        ],
        Layout(legend=attr(orientation="h", fontsize=12),
        #margin=attr(l=200,r=0,t=0,b=0, pad=0),
        polar = attr( #sector=[-45,-135],
            radialaxis = attr(range=[-30,10],angle = -90, showgrid=false, showticklabels=false, ticks="", tickangle=-90, linecolor=:white, showaxis=false),
            angularaxis = attr(rotation=90, direction="clockwise", showgrid=false, showticklabels=false, ticks=""))))
        push!(All_charts, barpolarchart)
        println(length(All_charts))
        # display(barpolarchart)
        savefig(barpolarchart, "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/04 Results/Projections/All_Catchments/Annual_Discharge/L2/Sector_timings_total_"*string(c)*"_L2.png")
    end
end

combined = Plots.plot(All_charts[1],All_charts[2],All_charts[3],All_charts[4],All_charts[5],All_charts[6])
display(combined)
# # bp = [Plot(bp1) Plot(bp2) Plot(bp3)
# #  Plot(bp4) Plot(bp5) Plot(bp6)]
# # bp = [bp1, bp2, bp3;
# # bp4, bp5, bp6]# layout=(3,2))
# # savefig(barpolarchart,"/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Discharge/timings2.png")
# savefig(bp, "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Results/Projections/All_Catchments/Annual_Discharge/timings_total.png")
