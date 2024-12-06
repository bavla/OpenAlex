plotMatCol<-function (x = M, clu = NULL, orderClu = FALSE, M = x, ylab = "", 
          xlab = "", main = NULL, print.val = !length(table(M)) <= 
            2, print.0 = FALSE, plot.legend = !print.val && !length(table(M)) <= 
            2, print.legend.val = "out", print.digits.legend = 2, 
          print.digits.cells = 2, print.cells.mf = NULL, outer.title = FALSE, 
          title.line = ifelse(outer.title, -1.5, 7), mar = c(0.5, 7, 
                                                             8.5, 0) + 0.1, cex.val = "default", val.y.coor.cor = 0, 
          val.x.coor.cor = 0, cex.legend = 1, legend.title = "Legend", 
          cex.axes = "default", print.axes.val = NULL, print.x.axis.val = !is.null(colnames(M)), 
          print.y.axis.val = !is.null(rownames(M)), x.axis.val.pos = 1.01, 
          y.axis.val.pos = -0.01, cex.main = par()$cex.main, cex.lab = par()$cex.lab, 
          yaxis.line = -1.5, xaxis.line = -1, legend.left = 0.4, legend.up = 0.03, 
          legend.size = 1/min(dim(M)), legend.text.hor.pos = 0.5, par.line.width = 3, 
          par.line.width.newSet = par.line.width[1] * 2, par.line.col = "blue", 
          par.line.col.newSet = "red", IM.dens = NULL, IM = NULL, wnet = NULL, 
          wIM = NULL, use.IM = length(dim(IM)) == length(dim(M)) | 
            !is.null(wIM), dens.leg = c(null = 100, nul = 100), blackdens = 70, 
          plotLines = FALSE, frameMatrix = TRUE, x0ParLine = -0.1, 
          x1ParLine = 1, y0ParLine = 0, y1ParLine = 1.1, colByUnits = NULL, 
          colByRow = NULL, colByCol = NULL, mulCol = 2, joinColOperator = "+", 
          colTies = FALSE, maxValPlot = NULL, printMultipliedMessage = TRUE, 
          replaceNAdiagWith0 = TRUE, colLabels = FALSE, MplotValues = NULL, colPos="black", colNeg="red",colZero="white", 
          ...) 
{
  
  # Function to generate the vectorized color mapping function
  create_color_generator <- function(color_neg1, color_0, color_1) {
    # Convert colors to RGB
    color_neg1_rgb <- col2rgb(color_neg1) / 255
    color_0_rgb <- col2rgb(color_0) / 255
    color_1_rgb <- col2rgb(color_1) / 255
    
    # Color interpolation function
    function(values) {
      if (any(values < -1 | values > 1)) {
        stop("All values must be between -1 and 1.")
      }
      
      # Initialize output RGB matrix
      output_rgb <- matrix(NA, nrow = 3, ncol = length(values))
      
      # Handle values <= 0 (interpolation between color_neg1 and color_0)
      idx_neg <- values <= 0
      t_neg <- (values[idx_neg] + 1)
      output_rgb[, idx_neg] <- color_neg1_rgb %*% (1 - t_neg) + color_0_rgb %*% t_neg
      
      # Handle values > 0 (interpolation between color_0 and color_1)
      idx_pos <- values > 0
      t_pos <- values[idx_pos]
      output_rgb[, idx_pos] <- color_0_rgb %*% (1 - t_pos) + color_1_rgb %*% t_pos
      
      # Convert back to hexadecimal color format
      apply(output_rgb, 2, function(col) rgb(col[1], col[2], col[3], maxColorValue = 1))
    }
  }
  
  # Create the color generator function
  color_gen <- create_color_generator(colNeg, colZero, colPos)
  
  old.mar <- par("mar")
  if (min(dim(M)) == 1 & is.null(wnet)) 
    wnet <- 1
  if (orderClu) {
    clu <- orderClu(M, clu = clu)
    ord <- order(attr(clu, "reorder"))
    if (!is.null(IM)) 
      if (length(dim(IM)) == 2) {
        IM <- IM[ord, ord]
      }
    else if (length(dim(IM)) == 3) {
      IM <- IM[, ord, ord]
    }
    else use.IM <- FALSE
  }
  tempClu <- clu
  if (length(dim(M)) > 2) {
    if (!is.null(wnet)) {
      relDim <- which.min(dim(M))
      if (relDim == 1) {
        M <- M[wnet, , ]
      }
      else if (relDim == 3) {
        M <- M[, , wnet]
      }
      else stop("More than 2 dimensions where relation dimension can not be determined")
      if (length(dim(IM)) > length(dim(M)) & use.IM) {
        if (is.null(wIM)) 
          wIM <- wnet
        if (is.null(wIM)) 
          wIM <- 1
        if (length(dim(IM)) == 3) {
          IM <- IM[wIM, , ]
        }
        else {
          warning("IM will not be used for plotting. Cannot be sure how to extract the appropirate part!")
          use.IM <- FALSE
        }
      }
    }
    else {
      plotArray(M = M, clu = tempClu, ylab = ylab, xlab = xlab, 
                main.title = main, main.title.line = -2, print.val = print.val, 
                print.0 = print.0, plot.legend = plot.legend, 
                print.legend.val = print.legend.val, print.digits.legend = print.digits.legend, 
                print.digits.cells = print.digits.cells, print.cells.mf = print.cells.mf, 
                outer.title = outer.title, title.line = title.line, 
                mar = mar, cex.val = cex.val, val.y.coor.cor = val.y.coor.cor, 
                val.x.coor.cor = val.x.coor.cor, cex.legend = cex.legend, 
                legend.title = legend.title, cex.axes = cex.axes, 
                print.axes.val = print.axes.val, print.x.axis.val = print.x.axis.val, 
                print.y.axis.val = print.y.axis.val, x.axis.val.pos = x.axis.val.pos, 
                y.axis.val.pos = y.axis.val.pos, cex.main = cex.main, 
                cex.lab = cex.lab, yaxis.line = yaxis.line, xaxis.line = xaxis.line, 
                legend.left = legend.left, legend.up = legend.up, 
                legend.size = legend.size, legend.text.hor.pos = legend.text.hor.pos, 
                par.line.width = par.line.width, par.line.width.newSet = par.line.width.newSet, 
                par.line.col = par.line.col, par.line.col.newSet = par.line.col.newSet, 
                IM.dens = IM.dens, IM = IM, wIM = wIM, use.IM = use.IM, 
                dens.leg = dens.leg, blackdens = blackdens, plotLines = plotLines, 
                ...)
      return(invisible(NULL))
    }
  }
  dm <- dim(M)
  if (!inherits(M, c("matrix", "mat"))) {
    pack <- attr(class(M), "package")
    if (!(is.null(pack)) && pack == "Matrix") {
      if (requireNamespace("Matrix")) {
        M <- as.matrix(M)
      }
      else stop("The supplied object needs Matrix packege, but the package is not available (install it!!!).")
    }
    else {
      warning("Attempting to convert object of class ", 
              class(M), " to class 'matrix'. Keep fingers crossed.")
      M <- as.matrix(M)
    }
  }
  if (replaceNAdiagWith0 & all(is.na(diag(M)))) 
    diag(M) <- 0
  if (is.null(main)) {
    objName <- deparse(substitute(M))
    if (objName[1] == "x") {
      objName <- deparse(substitute(x))
    }
    if (length(objName) > 1) 
      objName = ""
    main <- paste("Matrix", objName)
    if (nchar(main) > 50) 
      main <- substr(main, 1, 50)
  }
  if (is.logical(print.axes.val)) {
    print.x.axis.val <- print.y.axis.val <- print.axes.val
  }
  if (is.null(rownames(M))) {
    rownames(M) <- 1:dm[1]
  }
  if (is.null(colnames(M))) {
    colnames(M) <- 1:dm[2]
  }
  newSetK <- 0
  if (!is.null(clu)) {
    if (is.list(clu)) {
      clu <- lapply(clu, function(x) as.integer(as.factor(x)))
      tmNclu <- sapply(clu, max)
      for (iMode in 2:length(tmNclu)) {
        clu[[iMode]] <- clu[[iMode]] + sum(tmNclu[1:(iMode - 
                                                       1)])
      }
      unlistClu <- unlist(clu)
      if (all(length(unlistClu) == dm)) {
        clu <- unlistClu
        newSetK <- cumsum(tmNclu[-length(tmNclu)])
      }
    }
    if (!is.list(clu)) {
      tclu <- table(clu)
      or.c <- or.r <- order(clu)
      clu <- list(clu, clu)
      lines.col <- cumsum(tclu)[-length(tclu)] * 1/dm[2]
      lines.row <- 1 - lines.col
    }
    else if (is.list(clu) && length(clu) == 2) {
      if (!is.null(clu[[1]])) {
        tclu.r <- table(clu[[1]])
        or.r <- order(clu[[1]])
        lines.row <- 1 - cumsum(tclu.r)[-length(tclu.r)] * 
          1/dm[1]
      }
      else {
        or.r <- 1:dim(M)[1]
        lines.row <- NULL
      }
      if (!is.null(clu[[2]])) {
        tclu.c <- table(clu[[2]])
        or.c <- order(clu[[2]])
        lines.col <- cumsum(tclu.c)[-length(tclu.c)] * 
          1/dm[2]
      }
      else {
        or.c <- 1:dim(M)[2]
        lines.col <- NULL
      }
    }
    else stop("Networks with more that 2 modes (ways) must convert to 1-mode networks before it is sent to this function.")
    M <- M[or.r, or.c]
    clu <- lapply(clu, function(x) as.numeric(factor(x)))
  }
  if (is.null(IM.dens)) {
    if (!is.null(IM) & use.IM) {
      IM.dens <- matrix(-1, ncol = dim(IM)[2], nrow = dim(IM)[1])
      for (i in names(dens.leg)) {
        IM.dens[IM == i] <- dens.leg[i]
      }
    }
  }
  if (!is.null(IM.dens)) {
    dens <- matrix(-1, nrow = dm[1], ncol = dm[2])
    for (i in unique(clu[[1]])) {
      for (j in unique(clu[[2]])) {
        dens[clu[[1]] == i, clu[[2]] == j] <- IM.dens[i, 
                                                      j]
      }
    }
    dens <- dens[or.r, or.c]
  }
  if (length(cex.axes) == 1) 
    cex.axes <- c(cex.axes, cex.axes)
  if (cex.axes[1] == "default") {
    cex.y.axis <- min(15/dm[1], 1)
  }
  else {
    cex.y.axis <- cex.axes[1]
  }
  if (cex.axes[2] == "default") {
    cex.x.axis <- min(15/dm[2], 1)
  }
  else {
    cex.x.axis <- cex.axes[2]
  }
  yaxe <- rownames(M)
  xaxe <- colnames(M)
  ytop <- rep(x = (dm[1]:1)/dm[1], times = dm[2])
  ybottom <- ytop - 1/dm[1]
  xright <- rep(x = (1:dm[2])/dm[2], each = dm[1])
  xleft <- xright - 1/dm[2]
  if (all(M %in% c(0, 1))) {
    mulCol <- mulCol
    if (is.null(colByRow) & is.null(colByCol)) {
      colByRow <- colByCol <- colByUnits
    }
    else {
      if (is.null(colByRow)) {
        colByRow <- rep(0, length(colByCol))
        mulCol <- 1
      }
      if (is.null(colByCol)) {
        colByCol <- rep(0, length(colByRow))
      }
      colByUnits <- TRUE
    }
    col <- M
    if (all(col %in% c(0, 1)) & (!is.null(colByUnits))) {
      newCol <- outer(colByRow, colByCol * mulCol, FUN = joinColOperator)
      if (!is.null(clu)) 
        newCol <- newCol[or.r, or.c]
      if (colTies) {
        col[M > 0] <- col[M > 0] + newCol[M > 0]
      }
      else {
        newCol[newCol > 0] <- newCol[newCol > 0] + 1
        col[M == 0] <- col[M == 0] + newCol[M == 0]
      }
    }
  }
  else {
    # aM <- abs(M)
    # if (!is.null(maxValPlot)) {
    #   aM[aM > maxValPlot] <- maxValPlot
    # }
    # max.aM <- max(aM)
    # aMnorm <- as.vector(aM)/max.aM
    # if (max.aM != 0) {
    #   col <- gray(1 - aMnorm)
    # }
    # else col <- matrix(gray(1), nrow = dm[1], ncol = dm[2])
    # col[M < 0] <- paste("#FF", substr(col[M < 0], start = 4, 
    #                                   stop = 7), sep = "")
    col <- color_gen(as.vector(M/max(abs(M))))
                               
  }
  asp <- dm[1]/dm[2]
  if (!(plotLines)) {
    plotRect <- rep(TRUE, length(col))
    if (is.integer(col)) {
      plotRect[col == 0] <- FALSE
    }
    else {
      plotRect[col == "white"] <- FALSE
      plotRect[col == "transparent"] <- FALSE
      plotRect[grep(pattern = "^#......00$", x = col)] <- FALSE
    }
  }
  par(mar = mar, xpd = NA)
  plot.default(c(0, 1), c(0, 1), type = "n", axes = FALSE, 
               ann = FALSE, xaxs = "i", asp = asp, ...)
  if (is.null(IM.dens) || all(IM.dens == -1)) {
    rect(xleft = xleft[plotRect], ybottom = ybottom[plotRect], 
         xright = xright[plotRect], ytop = ytop[plotRect], 
         col = col[plotRect], cex.lab = cex.lab, border = if (plotLines) 
           "black"
         else NA)
  }
  else {
    rect(xleft = xleft[plotRect], ybottom = ybottom[plotRect], 
         xright = xright[plotRect], ytop = ytop[plotRect], 
         col = col[plotRect], cex.lab = cex.lab, density = dens[plotRect], 
         border = if (plotLines) 
           "black"
         else NA)
  }
  if (newSetK[1] != 0 && length(par.line.col) == 1) {
    par.line.col <- rep(par.line.col, length(lines.row))
    par.line.col[newSetK] <- par.line.col.newSet
  }
  if (newSetK[1] != 0 && length(par.line.width) == 1) {
    par.line.width <- rep(par.line.width, length(lines.row))
    par.line.width[newSetK] <- par.line.width.newSet
  }
  if (frameMatrix) 
    rect(xleft = 0, ybottom = 0, xright = 1, ytop = 1, cex.lab = cex.lab, 
         border = "black")
  if (!is.null(clu)) {
    if (!is.null(lines.row)) 
      segments(x0 = x0ParLine, x1 = x1ParLine, y0 = lines.row, 
               y1 = lines.row, col = par.line.col, lwd = par.line.width)
    if (!is.null(lines.col)) 
      segments(y0 = y0ParLine, y1 = y1ParLine, x0 = lines.col, 
               x1 = lines.col, col = par.line.col, lwd = par.line.width)
  }
  colYlabels <- colXlabels <- 1
  if ((length(colLabels) == 1) && is.logical(colLabels)) {
    if (colLabels) {
      if (is.null(clu)) {
        warning("clu not used!")
      }
      else {
        colYlabels <- clu[[1]]
        colXlabels <- clu[[2]]
      }
    }
  }
  else {
    if (!is.list(colLabels)) 
      colLabels <- list(colLabels, colLabels)
    if (length(colLabels[[1]]) == dm[1]) {
      colYlabels <- colLabels[[1]]
    }
    else {
      warning("colLabels for first dimmension of wrong length, no colors will be used!")
    }
    if (length(colLabels[[2]]) == dm[2]) {
      colXlabels <- colLabels[[2]]
    }
    else {
      warning("colLabels for second dimmension of wrong length, no colors will be used!")
    }
  }
  if (!is.null(clu)) {
    if (length(colXlabels) > 1) 
      colXlabels <- colXlabels[or.c]
    if (length(colYlabels) > 1) 
      colYlabels <- colYlabels[or.r]
  }
  if (print.y.axis.val) 
    text(x = y.axis.val.pos, y = (dm[1]:1)/dm[1] - 1/dm[1]/2 + 
           val.y.coor.cor, labels = yaxe, cex = cex.y.axis, 
         adj = 1, col = colYlabels)
  if (print.x.axis.val) 
    text(y = x.axis.val.pos, x = (1:dm[2])/dm[2] - 1/dm[2]/2 + 
           val.x.coor.cor, srt = 90, labels = xaxe, cex = cex.x.axis, 
         adj = 0, col = colXlabels)
  title(outer = outer.title, ylab = ylab, xlab = xlab, main = main, 
        line = title.line, cex.main = cex.main)
  if (!is.null(MplotValues)) {
    if (dim(MplotValues) == dim(M) && is.character(MplotValues)) {
      plot.legend <- FALSE
    }
    else warning("MplotValues is ignored. It should be the same dimension as the main matrix (x or M) and be a character")
  }
  if (print.val | (!is.null(MplotValues))) {
    norm.val <- as.vector(M)/max(abs(M))
    aMnorm <- abs(norm.val)
    col.text <- 1 - round(aMnorm)
    if (!print.0) 
      col.text[as.vector(M) == 0] <- 0
    if (length(table(col.text)) == 2) {
      col.labels <- c(colZero, colPos)
    }
    else col.labels <- c(colZero)
    col.text <- as.character(factor(col.text, labels = col.labels))
    if (!is.null(IM.dens) && !all(IM.dens == -1)) 
      col.text[col.text == colZero & dens > 0 & dens < 
                 blackdens] <- colPos
    col.text[col.text == colPos & norm.val < 0] <- colNeg
    if (!print.0) 
      col.text[as.vector(M) == 0] <- "transparent"
    if (is.null(MplotValues)) {
      maxM <- formatC(max(abs(M)), format = "e")
      if (is.null(print.cells.mf)) {
        if (all(trunc(M) == M) & max(M) < 10^print.digits.cells) {
          multi <- 1
        }
        else {
          multi <- floor(log10(max(M)))
          multi <- (multi - (print.digits.cells - 1)) * 
            (-1)
          multi <- 10^multi
        }
      }
      else multi <- print.cells.mf
      MplotValues <- round(M * multi)
      if (multi != 1 & printMultipliedMessage) 
        mtext(text = paste("* all values in cells were multiplied by ", 
                           multi, sep = ""), side = 1, line = -0.7, cex = 0.7)
    }
  }
  if (!is.null(MplotValues)) 
    text(x = (xleft + xright)/2 + val.x.coor.cor, y = (ytop + 
                                                         ybottom)/2 + val.y.coor.cor, labels = as.vector(MplotValues), 
         col = col.text, cex = ifelse(cex.val == "default", 
                                      min(10/max(dm), 1), cex.val))
  if (plot.legend) {
    if (asp >= 1) {
      xright.legend <- -legend.left
      xleft.legend <- xright.legend - 1 * legend.size * 
        asp
      ybottom.legend <- 1 + (4:0) * legend.size + legend.up
      ytop.legend <- ybottom.legend + 1 * legend.size
    }
    else {
      xright.legend <- -legend.left
      xleft.legend <- xright.legend - 1 * legend.size
      ybottom.legend <- 1 + (4:0) * legend.size * asp + 
        legend.up
      ytop.legend <- ybottom.legend + 1 * legend.size * 
        asp
    }
    col.legend <- gray(4:0/4)
    rect(xleft = xleft.legend, ybottom = ybottom.legend, 
         xright = xright.legend, ytop = ytop.legend, col = col.legend)
    if (print.legend.val == "out" | print.legend.val == "both") 
      text(x = xright.legend + 1/20, y = (ytop.legend + 
                                            ybottom.legend)/2, labels = formatC(0:4/4 * max(M), 
                                                                                digits = print.digits.legend, format = "g"), 
           adj = 0, cex = cex.legend)
    text(x = xleft.legend, y = ytop.legend[1] + legend.size/asp/2 + 
           0.02, labels = legend.title, font = 2, cex = cex.legend, 
         adj = 0)
    if (print.legend.val == "in" | print.legend.val == "both") {
      col.text.legend <- round(4:0/4)
      if (!print.0) 
        col.text.legend[1] <- 0
      col.text.legend <- as.character(factor(col.text.legend, 
                                             labels = c("white", "black")))
      if (!print.val) {
        if (is.null(print.cells.mf)) {
          if (all(trunc(M) == M) & max(M) < 10^print.digits.cells) {
            multi <- 1
          }
          else {
            multi <- floor(log10(max(M)))
            multi <- (multi - (print.digits.cells - 1)) * 
              (-1)
            multi <- 10^multi
          }
        }
        else multi <- print.cells.mf
        maxM <- round(max(M) * multi)
      }
      else maxM <- max(MplotValues)
      text(x = (xleft.legend + xright.legend)/2, y = (ytop.legend + 
                                                        ybottom.legend)/2, labels = round(0:4/4 * maxM), 
           col = col.text.legend, cex = cex.legend)
    }
  }
  par(mar = old.mar)
}
