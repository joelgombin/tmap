#' Specify the shape object
#' 
#' Creates a \code{\link{tmap-element}} that specifies the shape object. Also the projection and covered area (bounding box) can be set. It is possible to use multiple shape objects within one plot (see \code{\link{tmap-element}}).
#'  
#' @param shp shape object, which is one of
#' \enumerate{
#'  \item{\code{\link[sp:SpatialPolygonsDataFrame]{SpatialPolygons(DataFrame)}}}
#'  \item{\code{\link[sp:SpatialPointsDataFrame]{SpatialPoints(DataFrame)}}}
#'  \item{\code{\link[sp:SpatialLinesDataFrame]{SpatialLines(DataFrame)}}}
#'  \item{\code{\link[sp:SpatialGridDataFrame]{SpatialGrid(DataFrame)}}}
#'  \item{\code{\link[sp:SpatialPixelsDataFrame]{SpatialPixels(DataFrame)}}}
#'  \item{\code{\link[raster:Raster-class]{RasterLayer, RasterStack, or RasterBrick}}}
#' }
#'For drawing layers \code{\link{tm_fill}} and \code{\link{tm_borders}}, 1 is required. For drawing layer \code{\link{tm_lines}}, 3 is required. Layers \code{\link{tm_bubbles}} and \code{\link{tm_text}} accept 1 to 3. For layer \code{\link{tm_raster}}, 4, 5, or 6 is required.
#' @param is.master logical that determines whether this \code{tm_shape} is the master shape element. The bounding box, projection settings, and the unit specifications of the resulting thematic map are taken from the \code{tm_shape} element of the master shape object. By default, the first master shape element with a raster shape is the master, and if there are no raster shapes used, then the first \code{tm_shape} is the master shape element.
#' @param projection character that determines the projection. Either a \code{PROJ.4} character string or one of the following shortcuts: 
#' \describe{
#'    	\item{\code{"longlat"}}{Not really a projection, but a plot of the longitude-latitude coordinates (WGS84 datum).} 
#'    	\item{\code{"wintri"}}{Winkel Tripel (1921). Popular projection that is useful in world maps. It is the standard of world maps made by the National Geographic Society. Type: compromise} 
#'    	\item{\code{"robin"}}{Robinson (1963). Another popular projection for world maps. Type: compromise}
#'    	\item{\code{"eck4"}}{Eckert IV (1906). Projection useful for world maps. Area sizes are preserved, which makes it particularly useful for truthful choropleths. Type: equal-area}
#'    	\item{\code{"hd"}}{Hobo-Dyer (2002). Another projection useful for world maps in which area sizes are preserved. Type: equal-area}
#'    	\item{\code{"gall"}}{Gall (Peters) (1855). Another projection useful for world maps in which area sizes are preserved. Type: equal-area}
#'    	\item{\code{"merc"}}{Mercator (1569). Projection in which shapes are locally preserved. However, areas close to the poles are inflated. Google Maps uses a close variant of the Mercator. Type: conformal}
#'    	\item{\code{"utmXX(s)"}}{Universal Transverse Mercator. Set of 60 projections where each projection is a traverse mercator optimized for a 6 degree longitude range. These ranges are called UTM zones. Zone \code{01} covers -180 to -174 degrees (West) and zone \code{60} 174 to 180 east. Replace XX in the character string with the zone number. For southern hemisphere, add \code{"s"}. So, for instance, the Netherlands is \code{"utm31"} and New Zealand is \code{"utm59s"}}
#'    	\item{\code{"mill"}}{Miller (1942). Projetion based on Mercator, in which poles are displayed. Type: compromise}
#'    	\item{\code{"eqc0"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The equator is the standard parallel. Also known as Plate Carr\'ee. Type: equidistant}
#'    	\item{\code{"eqc30"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The latitude of 30 is the standard parallel. Type: equidistant}
#'    	\item{\code{"eqc45"}}{Equirectangular (120). Projection in which distances along meridians are conserved. The latitude of 45 is the standard parallel. Also known as Gall isographic. Type: equidistant}
#'    	\item{\code{"rd"}}{Rijksdriehoekstelsel. Triangulation coordinate system used in the Netherlands.}}
#'    	See \url{http://en.wikipedia.org/wiki/List_of_map_projections} for a overview of projections.
#'    	See \url{http://trac.osgeo.org/proj/} for the \code{PROJ.4} project home page. An extensive list of \code{PROJ.4} codes can be created with rgdal's \code{\link[rgdal:make_EPSG]{make_EPSG}}.
#'    	By default, the projection is used that is defined in the \code{shp} object itself, which can be obtained with \code{\link{get_projection}}.
#' @param xlim limits of the x-axis. These are either absolute or relative (depending on the argument \code{relative}). Alternatively, the argument \code{bbox} can be set to set absolute values.
#' @param ylim limits of the y-axis. See \code{xlim}.
#' @param relative boolean that determines whether relative values are used for \code{xlim} and \code{ylim} or absolute.
#' @param bbox bounding box, which is a 2x2 matrix that consists absolute \code{xlim} and \code{ylim} values. If specified, it overrides both \code{xlim} and \code{ylim}.
#' @param unit unit specification. Needed when calculating density values in choropleth maps (argument \code{convert2density} in \code{\link{tm_fill}}) drawing a scale bar with \code{\link{tm_scale_bar}}. See also \code{unit.size}.
#' @param unit.size size of the unit in terms of coordinate units. The coordinate system of many projections is approximately in meters while thematic maps typically range many kilometers, so by default \code{unit="km"} and \code{unit.size=1000} (meaning 1 kilometer equals 1000 coordinate units).
#' @export
#' @seealso \code{\link{read_shape}} to read ESRI shape files, \code{\link{set_projection}}, \href{../doc/tmap-nutshell.html}{\code{vignette("tmap-nutshell")}} 
#' @example ../examples/tm_shape.R
#' @return \code{\link{tmap-element}}
tm_shape <- function(shp, 
					 is.master = NA,
					 projection=NULL, 
					 xlim = NULL,
					 ylim = NULL,
					 relative = FALSE,
					 bbox = NULL,
					 unit = "km",
					 unit.size = 1000) {
	shp_name <- deparse(substitute(shp))
	g <- list(tm_shape=as.list(environment()))
	class(g) <- "tmap"
	g
}
