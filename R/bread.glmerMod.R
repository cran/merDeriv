bread.glmerMod <- function (x, ...){  
  ## get all elements by getME and exclude multiple random effect models.
  if (!is(x, "glmerMod")) stop("bread.glmerMod() only works for glmer() models.")
  
  parts <- getME(x, "l_i")
  if (length(parts) > 1) stop("Multiple cluster variables detected. Robust SEs are unavailable.")
  
  dotdotdot <- list(...)
  full <- TRUE
  if("full" %in% names(dotdotdot)){
    full <- dotdotdot$full
  }
  
  if(!(full %in% c("TRUE", "FALSE"))) stop("invalid 'full' argument supplied")
  
  object <- x
  return(vcov.glmerMod(object, full = full) * parts)
}
