using DelimitedFiles
path_45 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/ProjectionFolders/rcp45/"
path_85 = "/Volumes/Macintosh HD - Gegevens 1/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/ProjectionFolders/rcp85/"
path_to_projections = [path_45, path_85]
catchment_loop =[ "Defreggental", "Feistritz", "Palten", "Gailtal", "Pitztal"]#"Defreggental","Palten"]#,"Defreggental","Feistritz", "Gailtal",  "Palten",, "Silbertal"

for (c,cm) in enumerate(catchment_loop)
    for (p,projections) in enumerate(path_to_projections)
        name_rcms = readdir(projections)
        if projections[end-2:end-1] == "45"
            index = 1
            rcp = "rcp45"
            println(rcp, "   ", projections)
        elseif projections[end-2:end-1] == "85"
            index = 2
            rcp="rcp85"
            println(rcp, "   ", projections)
        end
        println(cm, rcp)
        for (r,rcm) in enumerate(name_rcms)
            # if (rcp!="rcp45"&&r=7)#||(c==1&&r>=8)
                src = "/Users/magali/Documents/Thesis/Data_Projected/"#"/Volumes/Magali 2/Data_projected/"
                dst = #"/Users/magali/Documents/Thesis/Data_Projected/"
                # label_p = "Past/NS/"*cm*"/"*rcp*"/"*rcm*"/combined_NS_streamflow_projection_Past.csv"
                # label_f = "Future/NS/"*cm*"/"*rcp*"/"*rcm*"/combined_WB_PforF_streamflow_projection_Future.csv"
                label_fd = "Future/PforF/"*cm*"/"*rcp*"/"*rcm*"/combined_WB_PforF_streamflow_projection_Future.csv"

                # fp = readdlm(src*label_p, ',')
                # ff = readdlm(src*label_f, ',')
                # println("size streamflow past", size(fp))
                # println("size streamflow future", size(ff))

                #cp(src*label_p, dst*label_p )
                # println("past > future")
                cp(src*label_f, dst*label_fd )
            # end

        end
    end
end
    # path_projected = "/Volumes/Magali 2/Data_projected/"
    # save_path = "/Volumes/Magali 2/Data_projected/"
    #
    # for (i, name) in enumerate(Name_Projections[1:end])
