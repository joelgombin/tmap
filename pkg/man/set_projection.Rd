% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/set_projection.R
\name{set_projection}
\alias{get_projection}
\alias{set_projection}
\title{Set and get the map projection}
\usage{
set_projection(shp, projection = NULL, current.projection = NULL,
  overwrite.current.projection = FALSE)

get_projection(shp)
}
\arguments{
\item{shp}{shape object of class \code{\link[sp:Spatial]{Spatial}}}

\item{projection}{character that determines the new projection. Either a \code{PROJ.4} character string or one of the following shortcuts:
\describe{
       \item{\code{"longlat"}}{Not really a projection, but a plot of the longitude-latitude coordinates (WGS84 datum).}
       \item{\code{"wintri"}}{Winkel Tripel (1921). Popular projection that is useful in world maps. It is the standard of world maps made by the National Geographic Society. Type: compromise}
       \item{\code{"robin"}}{Robinson (1963). Another popular projection for world maps. Type: compromise}
       \item{\code{"eck4"}}{Eckert IV (1906). Projection useful for world maps. Area sizes are preserved, which makes it particularly useful for truthful choropleths. Type: equal-area}
       \item{\code{"hd"}}{Hobo-Dyer (2002). Another projection useful for world maps in which area sizes are preserved. Type: equal-area}
       \item{\code{"gall"}}{Gall (Peters) (1855). Another projection useful for world maps in which area sizes are preserved. Type: equal-area}
       \item{\code{"merc"}}{Mercator (1569). Projection in which shapes are locally preserved. However, areas close to the poles are inflated. Google Maps uses a close variant of the Mercator. Type: conformal}
       \item{\code{"utmXX(s)"}}{Universal Transverse Mercator. Set of 60 projections where each projection is a traverse mercator optimized for a 6 degree longitude range. These ranges are called UTM zones. Zone \code{01} covers -180 to -174 degrees (West) and zone \code{60} 174 to 180 east. Replace XX in the character string with the zone number. For southern hemisphere, add \code{"s"}. So, for instance, the Netherlands is \code{"utm31"} and New Zealand is \code{"utm59s"}}
       \item{\code{"mill"}}{Miller (1942). Projetion based on Mercator, in which poles are displayed. Type: compromise}
       \item{\code{"eqc0"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The equator is the standard parallel. Also known as Plate Carr\'ee. Type: equidistant}
       \item{\code{"eqc30"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The latitude of 30 is the standard parallel. Type: equidistant}
       \item{\code{"eqc45"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The latitude of 45 is the standard parallel. Also known as Gall isographic. Type: equidistant}
       \item{\code{"rd"}}{Rijksdriehoekstelsel. Triangulation coordinate system used in the Netherlands.}}
       See \url{http://en.wikipedia.org/wiki/List_of_map_projections} for a overview of projections.
       See \url{http://trac.osgeo.org/proj/} for the \code{PROJ.4} project home page. An extensive list of \code{PROJ.4} codes can be created with rgdal's \code{\link[rgdal:make_EPSG]{make_EPSG}}.
       This argument is only used to transform the \code{shp}. Use \code{current.projection} to specify the current projection of \code{shp}.}

\item{current.projection}{the current projection of \code{shp}. Only use this if the current projection is missing or wrong.}

\item{overwrite.current.projection}{logical that determines whether the current projection is overwritten if it already has a projection that is different.}
}
\value{
\code{set_projection} returns a (transformed) shape object with updated projection information.
\code{get_projection} returns the \code{PROJ.4} character string of \code{shp}.
}
\description{
The function \code{set_projection} sets the projection of a shape file. It is a convenient wrapper of \code{\link[sp:spTransform]{spTransform}} with shortcuts for commonly used projections. The projection can also be set directly in the plot call with \code{\link{tm_shape}}. This function is also used to set the current projection information if this is missing. The function \code{get_projection} is used to get the projection information.
}

