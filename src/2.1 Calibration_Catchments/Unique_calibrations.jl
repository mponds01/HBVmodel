import Base.unique

function unique()
    all_calibrations = readdlm("/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/Defreggental/Best/Parameterfit_less_dates_snow_redistr_best_700.csv", ',')
    #all_calibrations = DataFrame(all_calibrations, :auto)
    unique_nrs = union(all_calibrations[:,1])
    # println(unique_nrs)
    file = zeros(length(all_calibrations[1,:]))
    for (n, nr) in enumerate(unique_nrs)
        unique_index = findfirst(isequal(nr), all_calibrations[:,1])
        unique_calibrations = all_calibrations[unique_index,:]
        file = hcat(file, unique_calibrations)
    end
    println(file)
    Final_file = transpose(file[:, 2:end])
    writedlm("/Users/magali/Documents/1. Master/1.4 Thesis/02 Execution/01 Model Sarah/Calibrations/Defreggental/Best/Parameterfit_less_dates_snow_redistr_1M_combined_2.csv", Final_file,',')


    return
end

unique()
