process_line_lwd_vector <- function(x, g, rescale) {
	w_legend <- pretty(x, 7)
	w_legend <- w_legend[w_legend!=0]
	w_legend <- w_legend[-c(length(w_legend)-3,length(w_legend)-1)]
	maxW <- ifelse(rescale, max(x, na.rm=TRUE), 1)
	line.legend.lwds <-  g$lines.scale * (w_legend/maxW)
	line.lwd.legend.labels <- format(w_legend, trim=TRUE)
	line.lwd <- g$lines.scale * (x/maxW)
	list(line.lwd=line.lwd,
		 line.legend.lwds=line.legend.lwds,
		 line.lwd.legend.labels=line.lwd.legend.labels)
}

process_line_col_vector <- function(x, g, gt) {
	line.col.is.numeric <- is.numeric(x)
	if (line.col.is.numeric) {
		palette <- if (is.null(g$palette))  "RdYlBu" else g$palette
		colsLeg <- num2pal(x, g$n, style=g$style, breaks=g$breaks, 
						   palette = palette,
						   auto.palette.mapping = g$auto.palette.mapping,
						   contrast = g$contrast, legend.labels=g$labels,
						   legend.scientific=gt$legend.scientific,
						   legend.digits=gt$legend.digits,
						   legend.NA.text=g$textNA,
						   alpha=g$lines.alpha, 
						   text_separator = g$text_separator,
						   text_less_than = g$text_less_than,
						   text_or_more = g$text_or_more)
		line.breaks <- colsLeg[[4]]
	} else {
		palette <- if (is.null(g$palette))  "Dark2" else g$palette
		#remove unused levels in legend
		colsLeg <- cat2pal(x,
						   palette = palette,
						   contrast = g$contrast,
						   colorNA = g$colorNA,
						   legend.labels=g$labels,
						   legend.NA.text=g$textNA,
						   max_levels=g$max.categories,
						   alpha=g$lines.alpha)
		line.breaks <- NA
	}
	line.col <- colsLeg[[1]]
	line.col.legend.labels <- colsLeg[[2]]
	line.col.legend.palette <- colsLeg[[3]]
	
	list(line.col=line.col,
		 line.col.legend.labels=line.col.legend.labels,
		 line.col.legend.palette=line.col.legend.palette,
		 line.col.is.numeric=line.col.is.numeric,
		 line.breaks=line.breaks)
	
}

process_lines <- function(data, g, gt, gby, z) {
	npol <- nrow(data)
	by <- data$GROUP_BY
	shpcols <- names(data)[1:(ncol(data)-1)]
	
	xcol <- g$lines.col
	xlwd <- g$lines.lwd
	
	if (nlevels(by)>1) {
		xcol <- xcol[1]
		xlwd <- xlwd[1]
	}
	
	nxcol <- length(xcol)
	nxlwd <- length(xlwd)
	
	varycol <- all(xcol %in% shpcols) && !is.null(xcol)
	varylwd <- all(xlwd %in% shpcols) && !is.null(xlwd)
	
	nx <- max(nxcol, nxlwd)
	if (nxcol<nx) xcol <- rep(xcol, length.out=nx)
	if (nxlwd<nx) xlwd <- rep(xlwd, length.out=nx)

	if (!varylwd) {
		if (!all(is.numeric(xlwd))) stop("Line widths are neither numeric nor valid variable names")
		for (i in 1:nx) data[[paste("lwd", i, sep="_")]] <- xlwd[i]
		xlwd <- paste("lwd", 1:nx, sep="_")
		gby$free.scales.line.lwd <- FALSE
	}
	
	# check for direct color input
	is.colors <- all(valid_colors(xcol))
	if (!varycol) {
		if (!is.colors) stop("Invalid line colors")
		xcol <- get_alpha_col(col2hex(xcol), g$lines.alpha)
		for (i in 1:nx) data[[paste("COLOR", i, sep="_")]] <- xcol[i]
		xcol <- paste("COLOR", 1:nx, sep="_")
	}
	
	nx <- max(nx, nlevels(by))
	
	dtcol <- process_data(data[, xcol, drop=FALSE], by=by, free.scales=gby$free.scales.line.col, is.colors=is.colors)
	dtlwd <- process_data(data[, xlwd, drop=FALSE], by=by, free.scales=gby$free.scales.line.lwd, is.colors=FALSE)
	
	if (is.list(dtlwd)) {
		# multiple variables for lwd are defined
		gsl <- split_g(g, n=nx)
		res <- mapply(process_line_lwd_vector, dtlwd, gsl, MoreArgs = list(rescale=varylwd), SIMPLIFY = FALSE)
		line.lwd <- sapply(res, function(r)r$line.lwd)
		line.legend.lwds <- lapply(res, function(r)r$line.legend.lwds)
		line.lwd.legend.labels <- lapply(res, function(r)r$line.lwd.legend.labels)
	} else {
		res <- process_line_lwd_vector(dtlwd, g, rescale=varylwd)
		line.lwd <- matrix(res$line.lwd, nrow=npol)
		if (varylwd) {
			line.legend.lwds <- res$line.legend.lwds
			line.lwd.legend.labels <- res$line.lwd.legend.labels
		} else {
			line.legend.lwds <- NA
			line.lwd.legend.labels <- NA
			xlwd <- rep(NA, nx)
			line.lwd.legend.title <- rep(NA, nx)
			
		}
	}
	
	if (is.matrix(dtcol)) {
		line.col <- if (is.colors) {
			matrix(get_alpha_col(dtcol, g$lines.alpha), ncol=ncol(dtcol))
		} else dtcol
		xcol <- rep(NA, nx)
		line.col.legend.title <- rep(NA, nx)
		line.col.legend.labels <- NA
		line.col.legend.palette <- NA
		line.col.is.numeric <- NA
		line.breaks <- NA
		line.values <- NA
	} else if (is.list(dtcol)) {
		# multiple variables for col are defined
		gsc <- split_g(g, n=nx)
		res <- mapply(process_line_col_vector, dtcol, gsc, MoreArgs = list(gt), SIMPLIFY = FALSE)
		line.col <- sapply(res, function(r)r$line.col)
		line.col.legend.labels <- lapply(res, function(r)r$line.col.legend.labels)
		line.col.legend.palette <- lapply(res, function(r)r$line.col.legend.palette)
		line.col.is.numeric <- sapply(res, function(r)r$line.col.is.numeric)
		line.breaks <- lapply(res, function(r)r$line.breaks)
		line.values <- dtcol
		
	} else {
		res <- process_line_col_vector(dtcol, g, gt)
		line.col <- matrix(res$line.col, nrow=npol)
		line.col.legend.labels <- res$line.col.legend.labels
		line.col.legend.palette <- res$line.col.legend.palette
		line.col.is.numeric <- res$line.col.is.numeric
		line.breaks <- res$line.breaks
		line.values <- split(dtcol, rep(1:nx, each=npol))
	}
	
	line.lwd.legend.palette <- if (is.list(line.col.legend.palette)) {
		mapply(function(pal, isnum) {
			if (isnum) pal[length(pal)] else pal[1]
		}, line.col.legend.palette, line.col.is.numeric)
	} else if (is.na(line.col.legend.palette[1])) {
		apply(line.col, 2, function(bc) na.omit(bc)[1])
	} else {
		rep(line.col.legend.palette[1], nx)
	}
	
	line.legend.lwd <- if (is.list(line.legend.lwds)) {
		sapply(line.legend.lwds, function(x)quantile(x, probs=.75, na.rm=TRUE))
	} else if (is.na(line.legend.lwds[1])) {
		apply(line.lwd, 2, function(bc) quantile(bc, probs=.75, na.rm=TRUE))
	} else {
		rep(quantile(line.legend.lwds, probs=.75, na.rm=TRUE), nx)
	}
	
	line.col.legend.title <- if (is.na(g$title.col)[1]) xcol else g$title.col
	line.lwd.legend.title <- if (is.na(g$title.lwd)[1]) xlwd else g$title.lwd
	line.col.legend.z <- if (is.na(g$legend.col.z)) z else g$legend.col.z
	line.lwd.legend.z <- if (is.na(g$legend.lwd.z)) z+.33 else g$legend.lwd.z
	line.col.legend.hist.z <- if (is.na(g$legend.hist.z)) z+.66 else g$legend.hist.z

	if (g$legend.hist && is.na(g$legend.hist.title) && line.col.legend.z>line.col.legend.hist.z) {
		# histogram is drawn between title and legend enumeration
		line.col.legend.hist.title <- line.col.legend.title
		line.col.legend.title <- ""
	} else if (g$legend.hist && !is.na(g$legend.hist.title)) {
		line.col.legend.hist.title <- g$legend.hist.title
	} else line.col.legend.hist.title <- ""
	
	list(line.col=line.col,
		 line.lwd=line.lwd,
		 line.lty=g$lines.lty,
		 line.alpha=g$lines.alpha,
		 line.col.legend.labels=line.col.legend.labels,
		 line.col.legend.palette=line.col.legend.palette,
		 line.col.legend.misc=list(line.legend.lwd=line.legend.lwd, 
		 						  line.legend.lty=g$lines.lty,
		 						  line.legend.alpha=g$lines.alpha),
		 line.lwd.legend.labels=line.lwd.legend.labels,
		 line.lwd.legend.palette=line.lwd.legend.palette,
		 line.lwd.legend.misc=list(legend.lwds=line.legend.lwds,
		 						  line.legend.lty=g$lines.lty,
		 						  line.legend.alpha=g$lines.alpha),
		 line.col.legend.hist.misc=list(values=line.values, breaks=line.breaks),
		 xline=xcol,
		 xlinelwd=xlwd,
		 line.col.legend.title=line.col.legend.title,
		 line.lwd.legend.title=line.lwd.legend.title,
		 line.col.legend.is.portrait=g$legend.col.is.portrait,
		 line.lwd.legend.is.portrait=g$legend.lwd.is.portrait,
		 line.col.legend.hist=g$legend.hist,
		 line.col.legend.hist.title=line.col.legend.hist.title,
		 line.col.legend.z=line.col.legend.z,
		 line.lwd.legend.z=line.lwd.legend.z,
		 line.col.legend.hist.z=line.col.legend.hist.z
	)

}


