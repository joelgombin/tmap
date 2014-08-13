#' Quick thematic map plot
#' 
#' This function is a convenient wrapper for drawing thematic maps quickly.
#' 
#' @param shp shape object. For \code{\link{tm_fill}} and \code{\link{tm_bubbles}}, a \code{\link[sp:SpatialPolygonsDataFrame]{SpatialPolygonsDataFrame}} or a \code{\link[sp:SpatialPointsDataFrame]{SpatialPointsDataFrame}} is requied. 
#' \code{\link[sp:SpatialPoints]{SpatialPoints}} and \code{\link[sp:SpatialPointsDataFrame]{SpatialPointsDataFrame}} are only used for \code{\link{tm_bubbles}}.
#' @param fill either a color to fill the polygons, or name of the data variable in \code{shp} to draw a choropleth.
#' @param bubble.size name of the data variable in \code{shp} for the bubblemap that specifies the sizes of the bubbles. If neither \code{bubble.size} nor \code{bubble.col} is specified, no bubblemap is drawn.
#' @param bubble.col name of the data variable in \code{shp} for the bubblemap that specifies the colors of the bubbles. If neither \code{bubble.size} nor \code{bubble.col} is specified, no bubblemap is drawn.
#' @param text Name of the data variable that contains the text labels.
#' @param text.cex Font size of the text labels. Either a constant value, or the name of a numeric data variable.
#' @param line.lwd either a line width or a name of the data variable that specifies the line width. Only applicable if \code{shp} is a \code{\link[sp:SpatialLines]{SpatialLines}} or \code{\link[sp:SpatialLinesDataFrame]{SpatialLinesDataFrame}}.
#' @param line.col either a line color or a name of the data variable that specifies the line colors. Only applicable if \code{shp} is a \code{\link[sp:SpatialLines]{SpatialLines}} or \code{\link[sp:SpatialLinesDataFrame]{SpatialLinesDataFrame}}.
#' @param borders color of the polygon borders. Use \code{NA} to omit the borders.
#' @param theme one of "World", "Europe", or "NLD"
#' @param scale numeric value that serves as the global scale parameter. All font sizes, bubble sizes, border widths, and line widths are controled by this value. The parameters \code{bubble.size}, \code{text.cex}, and \code{line.lwd} can be scaled seperately with respectively \code{bubble.scale}, \code{text.scale}, and \code{line.scale}.
#' @param ... parameters passed on to the \code{tm_*} functions.
#' @return \code{\link{tmap-element}}
#' @example ../examples/qtm.R
#' @seealso \href{../doc/tmap-nutshell.html}{\code{vignette("tmap-nutshell")}}
#' @export
qtm <- function(shp, 
				fill="grey90",
				bubble.size=NULL,
				bubble.col=NULL,
				text=NULL,
				text.cex=1,
				line.lwd=NULL,
				line.col=NULL,
				borders="grey40",
				theme=NULL,
				scale=1,
				...) {
	args <- list(...)
	if (!inherits(shp, "SpatialPolygons")) {
		fill <- NULL
		borders <- NULL
		
		if (inherits(shp, "SpatialLines")) {
			if (missing(line.lwd)) line.lwd <- 1
			if (missing(line.col)) line.col <- "black"
		}
		if (inherits(shp, "SpatialPoints")) {
			if (missing(bubble.size)) bubble.size <- 1
			if (missing(bubble.col)) bubble.col <- "black"
		}
	}
	shapeargs <- args[intersect(names(args), names(tm_shape()[[1]]))]
	fillargs <- args[setdiff(intersect(names(args), names(tm_fill()[[1]])), "col")]
	bubblenames <- names(tm_bubbles()[[1]])
	bubblenames[bubblenames=="bubble.border"] <- "border"
	bubbleargs <- args[setdiff(intersect(names(args), bubblenames), c("bubble.col", "bubble.size"))]
	if ("bubble.scale" %in% names(bubbleargs)) names(bubbleargs)[names(bubbleargs)=="bubble.scale"] <- "scale"
	
	borderargs <- args[setdiff(intersect(names(args), names(tm_borders()[[1]])), "col")]
	
	textnames <- names(tm_text("")[[1]])[-c(1:2)]
	textnames[-1] <- substr(textnames[-1], 6, nchar(textnames[-1]))
	textnames[textnames=="scale"] <- "text.scale"
	textargs <- args[intersect(names(args), textnames)]
	if ("text.scale" %in% names(textargs)) names(textargs)[names(textargs)=="text.scale"] <- "scale"
	
	linenames <- names(tm_lines()[[1]])
	linenames[linenames=="lines.lty"] <- "lty"
	lineargs <- args[setdiff(intersect(names(args), linenames), c("lines.col", "lines.lwd"))]
	if ("line.scale" %in% names(lineargs)) names(lineargs)[names(lineargs)=="line.scale"] <- "scale"
	
	themeargs <- args[intersect(names(args), names(tm_layout()[[1]]))]
	gridargs <- args[intersect(names(args), names(tm_grid()[[1]]))]
	
	g <- do.call("tm_shape", c(list(shp=shp), shapeargs))
	if (!is.null(borders)) g <- g + do.call("tm_borders", c(list(col=borders), borderargs))
	if (!is.null(fill)) g <- g + do.call("tm_fill", c(list(col=fill), fillargs))
	if (!missing(bubble.size) || !missing(bubble.col)) g <- g + do.call("tm_bubbles", c(list(size=bubble.size, col=bubble.col), bubbleargs))
	
	if (!missing(text)) g <- g + do.call("tm_text", c(list(text=text, cex=text.cex), textargs))
	
	if (!missing(line.lwd) || !missing(line.col)) g <- g + do.call("tm_lines", c(list(lwd=line.lwd, col=line.col), lineargs))

	if (missing(theme)) {
		if (length(themeargs)) g <- g + do.call("tm_layout", c(list(scale=scale), themeargs))	
	} else {
		if (!(theme %in% c("World", "Europe", "NLD"))) stop("Unknown theme")
		funct <- paste("tm_layout", theme, sep="_")
		g <- g + do.call(funct, c(list(scale=scale), themeargs))
	}
	
	g
}