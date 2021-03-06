data(World)
data(Europe)
data(NLD_muni)
data(NLD_prov)

# Constant fill
tm_shape(World) + tm_fill("darkolivegreen3") + tm_layout_World(title="A green World")

# Borders only
tm_shape(Europe) + tm_borders()

# Data variable containing colours values
Europe$isNLD <- ifelse(Europe$name=="Netherlands", "darkorange", "darkolivegreen3")
tm_shape(Europe) +
    tm_fill("isNLD") +
tm_layout("Find the Netherlands!")

# Numeric data variable
tm_shape(NLD_muni) +
    tm_fill(col="population", convert2density=TRUE, 
        style="kmeans", title="Population (per km2)", legend.hist=TRUE) +
    tm_borders("grey25", alpha=.5) + 
tm_shape(NLD_prov) +
    tm_borders("grey40", lwd=2) +
tm_layout_NLD_wide(bg.color="white", draw.frame = FALSE, legend.hist.bg.color="grey90")

tm_shape(Europe) +
    tm_polygons("gdp_cap_est", style="kmeans", textNA = "Non-European countries", 
        title="GDP per capita") +
    tm_text("iso_a3", size="AREA", root=4, scale=2) +
tm_layout_Europe()

tm_shape(World) +
    tm_polygons("pop_est_dens", style="kmeans", palette="YlOrRd", title="Population per km2") +
    tm_text("iso_a3", size="AREA", scale=1.5) +
tm_layout_World()

# Categorical data variable
tm_shape(World) +
    tm_polygons("income_grp", palette="-Blues", title="Income classification") +
    tm_text("iso_a3", size="AREA", scale=1.5) +
tm_layout_World()

tm_shape(NLD_prov) + 
    tm_fill("name") + 
tm_shape(NLD_muni) + 
    tm_borders() + 
tm_shape(NLD_prov) + 
    tm_borders(lwd=2) +
    tm_text("name", shadow=TRUE) +
tm_layout_NLD("Provinces and municipalities", legend.show=FALSE, bg.color="white")
