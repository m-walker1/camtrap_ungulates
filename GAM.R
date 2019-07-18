library(mgcv)


#example data 

GAM_data <- read.csv("data/GAM_example_data.csv")


#each model follows the formulas from the Turner et al. 2014 supplementary 
    #material, with additional model terms for animal sex  



#GAM for animal visitations:

visitations <- mgcv::gam(n ~ s(days_since_start) +
                            s(julian, by = station, bs = 'cp') + 
                            s(carcass_age, by = treatment) +
                            s(julian, by = treatment) +
                            s(carcass_age, by = sex) +
                            s(julian, by = sex) +
                            treatment + station + sex,
                          family = quasipoisson(), 
                          data = GAM_data)

#where:
#n = number of individuals present per camera trigger summed daily 
    #per site, per treatment 
#days_since_start = the number of days since the first camera trap was set up
#julian = julian day
#carcass_age = the number of days since the animal died 
#treatment = LIZ or control
#station = specific site 

summary(visitations)
gam.check(visitations)
vis.gam(visitations, view = c('carcass_age', 'julian'), plot.type = 'contour')




#GAM for animal grazing, given animal presence

grazing <- mgcv::gam(cbind(g, n-g) ~ s(sqrt(n)) + 
                         s(days_since_start, bs = 'cp') + 
                         s(carcass_age, by = treatment) + 
                         s(julian, by = treatment) + 
                         s(carcass_age, by = sex) + 
                         s(julian, by = sex) +
                         treatment + station + sex,
                       family = quasibinomial(), data = GAM_data)

#where g = the number of individuals seen grazing per camera trigger
    #summed daily, per site, per treatment 


summary(grazing)
gam.check(grazing)

vis.gam(grazing, view = c('carcass_age', 'julian'), plot.type = 'contour')
