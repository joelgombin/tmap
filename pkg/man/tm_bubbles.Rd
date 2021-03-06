% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/tm_layers.R
\name{tm_bubbles}
\alias{tm_bubbles}
\title{Draw bubbles}
\usage{
tm_bubbles(size = 1, col = "blueviolet", alpha = NA, border.col = NA,
  border.lwd = 1, border.alpha = NA, scale = 1, perceptual = FALSE,
  size.lim = NA, sizes.legend = NULL, sizes.legend.labels = NULL, n = 5,
  style = "pretty", breaks = NULL, palette = NULL, labels = NULL,
  auto.palette.mapping = TRUE, contrast = 1, max.categories = 12,
  colorNA = "#FF1414", textNA = "Missing", text_separator = "to",
  text_less_than = "Less than", text_or_more = "or more", xmod = 0,
  ymod = 0, title.size = NA, title.col = NA,
  legend.size.is.portrait = FALSE, legend.col.is.portrait = TRUE,
  legend.hist = FALSE, legend.hist.title = NA, legend.size.z = NA,
  legend.col.z = NA, legend.hist.z = NA)
}
\arguments{
\item{size}{\code{shp} data variable that determines the bubble sizes. If multiple values are specified, small multiples are drawn (see details).}

\item{col}{color(s) of the bubble. Either a color (vector), or categorical variable name(s). If multiple values are specified, small multiples are drawn (see details).}

\item{alpha}{transparency number between 0 (totally transparent) and 1 (not transparent). By default, the alpha value of the \code{col} is used (normally 1).}

\item{border.col}{color of the bubble borders.}

\item{border.lwd}{line width of the bubble borders. If \code{NA} (default), no bubble borders are drawn.}

\item{border.alpha}{transparency number, regarding the bubble borders, between 0 (totally transparent) and 1 (not transparent). By default, the alpha value of the \code{col} is used (normally 1).}

\item{scale}{bubble size multiplier number.}

\item{perceptual}{logical that determines whether bubbles are scales with a perceptually (\code{TRUE}) or mathematically (\code{FALSE}, default value). The perceived area of larger bubbles is often underestimated. Flannery (1971) experimentally derived a method to compensate this, which is enabled by this argument.}

\item{size.lim}{vector of two limit values of the \code{size} variable. Only bubbles are drawn whose value is greater than or equal to the first value. Bubbles whose values exceed the second value are drawn at the size of the second value. Only applicable when \code{size} is the name of a numeric variable of \code{shp}}

\item{sizes.legend}{vector of bubble sizes that are shown in the legend. By default, this is determined automatically.}

\item{sizes.legend.labels}{vector of labels for that correspond to \code{sizes.legend}.}

\item{n}{preferred number of color scale classes. Only applicable when \code{col} is a numeric variable name.}

\item{style}{method to cut the color scale: e.g. "fixed", "equal", "pretty", "quantile", or "kmeans". See the details in \code{\link[classInt:classIntervals]{classIntervals}}. Only applicable when \code{col} is a numeric variable name.}

\item{breaks}{in case \code{style=="fixed"}, breaks should be specified}

\item{palette}{color palette (see \code{RColorBrewer::display.brewer.all}) for the bubbles. Only when \code{col} is set to a variable.}

\item{labels}{labels of the classes}

\item{auto.palette.mapping}{When diverging colour palettes are used (i.e. "RdBu") this method automatically maps colors to values such that the middle colors (mostly white or yellow) are assigned to values of 0, and the two sides of the color palette are assigned to negative respectively positive values.}

\item{contrast}{vector of two numbers that determine the range that is used for sequential and diverging palettes (applicable when \code{auto.palette.mapping=TRUE}). Both numbers should be between 0 and 1. The first number determines where the palette begins, and the second number where it ends. For sequential palettes, 0 means the brightest color, and 1 the darkest color. For diverging palettes, 0 means the middle color, and 1 both extremes. If only one number is provided, this number is interpreted as the endpoint (with 0 taken as the start).}

\item{max.categories}{in case \code{col} is the name of a categorical variable, this value determines how many categories (levels) it can have maximally. If the number of levels is higher than \code{max.categories}, then levels are combined.}

\item{colorNA}{colour for missing values}

\item{textNA}{text used for missing values. Use \code{NA} to omit text for missing values in the legend}

\item{text_separator}{Character string to use to separate numbers in the legend (default: "to").}

\item{text_less_than}{Character string to use to translate "Less than" (which is the default).}

\item{text_or_more}{Character string to use to translate "or more" (which is the default).}

\item{xmod}{horizontal position modification of the bubbles, relatively where 0 means no modification, and 1 means the total width of the frame. Either a single number for all polygons, or a numeric variable in the shape data specifying a number for each polygon. Together with \code{ymod}, it determines position modification of the bubbles. In most coordinate systems (projections), the origin is located at the bottom left, so negative \code{xmod} move the bubbles to the left, and negative \code{ymod} values to the bottom.}

\item{ymod}{vertical position modification. See xmod.}

\item{title.size}{title of the legend element regarding the bubble sizes}

\item{title.col}{title of the legend element regarding the bubble colors}

\item{legend.size.is.portrait}{logical that determines whether the legend element regarding the bubble sizes is in portrait mode (\code{TRUE}) or landscape (\code{FALSE})}

\item{legend.col.is.portrait}{logical that determines whether the legend element regarding the bubble colors is in portrait mode (\code{TRUE}) or landscape (\code{FALSE})}

\item{legend.hist}{logical that determines whether a histogram is shown regarding the bubble colors}

\item{legend.hist.title}{title for the histogram. By default, one title is used for both the histogram and the normal legend for bubble colors.}

\item{legend.size.z}{index value that determines the position of the legend element regarding the bubble sizes with respect to other legend elements. The legend elements are stacked according to their z values. The legend element with the lowest z value is placed on top.}

\item{legend.col.z}{index value that determines the position of the legend element regarding the bubble colors. (See \code{legend.size.z})}

\item{legend.hist.z}{index value that determines the position of the histogram legend element. (See \code{legend.size.z})}
}
\value{
\code{\link{tmap-element}}
}
\description{
Creates a \code{\link{tmap-element}} that draws bubbles. Both colors and sizes of the bubbles can be mapped to data variables.
}
\details{
Small multiples can be drawn in two ways: either by specifying the \code{by} argument in \code{\link{tm_facets}}, or by defining multiple variables in the aesthetic arguments. The aesthetic arguments of \code{tm_bubbles} are \code{size} and \code{col}. In the latter case, the arguments, except for the ones starting with \code{legend.}, can be specified for small multiples as follows. If the argument normally only takes a single value, such as \code{n}, then a vector of those values can be specified, one for each small multiple. If the argument normally can take a vector, such as \code{palette}, then a list of those vectors (or values) can be specified, one for each small multiple.
}
\examples{
data(World)
data(Europe)
data(metro)
metro$growth <- (metro$pop2020 - metro$pop2010) / (metro$pop2010 * 10) * 100

tm_shape(World) +
    tm_fill("grey70") +
tm_shape(metro) +
    tm_bubbles("pop2010", col = "growth", 
        border.col = "black", border.alpha = .5, 
        style="fixed", breaks=c(-Inf, seq(0, 6, by=2), Inf),
        palette="-RdYlBu", contrast=1, 
        title.size="Metro population", 
        title.col="Growth rate (\%)") + 
tm_layout_World()

tm_shape(Europe) +
    tm_borders() +
    tm_fill() +
tm_shape(metro) +
    tm_bubbles(size="pop2010", col="purple", size.lim=c(0, 1.2e7), title.size="Metro population") +
    tm_text("name", size="pop2010", scale=2, root=3, ymod=-.015 , bg.alpha=0) +
tm_layout_Europe()
}
\references{
Flannery J (1971). The Relative Effectiveness of Some Common Graduated Point Symbols in the Presentation of Quantitative Data. Canadian Cartographer, 8 (2), 96-109.
}
\seealso{
\href{../doc/tmap-nutshell.html}{\code{vignette("tmap-nutshell")}}
}
\keyword{bubble}
\keyword{map}

