using DataFrames

# D1,D2,D3,D4 = characteristics_d()
# D=["Defreggental",D1,D2,D3,D4]
# F1,F2,F3,F4 = characteristics_f()
# F = ["Fesitritz", F1,F2,F3,F4]
# G1,G2,G3,G4=characteristics_g()
# G=["Gailtal",G1,G2,G3,G4]
# PI1,PI2,PI3,PI4=characteristics_pi()
# PI = ["Pitztal",PI1,PI2,PI3,PI4]
# PA1,PA2,PA3,PA4 = characteristics_pa()
# PA = ["Paltental",PA1,PA2,PA3,PA4]
# S1,S2,S3,S4 = characteristics_s()
# S=["Silbertal",S1,S2,S3,S4]
rows = ["Catchment","T","EP","Q","P"]

df=DataFrame([rows,F,G,PA,S,D,PI],:auto)
rename!(df, Symbol.(Vector(df[1,:])))
display(df[2:end,:])
print()
