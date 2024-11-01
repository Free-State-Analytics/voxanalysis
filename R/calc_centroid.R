#' Calculate the Centroid, Centroidal Distance, and Area Moment (Q)
#'
#' @description
#' This function calculates the centroid (geometric center), the distance from a reference point to the centroid (centroidal distance), and the area moment (Q) of a given shape or set of data points.
#'
#' @inheritParams common-params
#'
#' @import dplyr
#'
#' @examples
#' data("df_input_response_example")
#' calc_centroid(df_input_response = df_input_response_example)
#'
#' @return A `list` with the following components:
#'   \describe{
#'     \item{centroid}{A numeric vector of length 2, providing the x and y coordinates of the centroid. This represents the geometric center of the input data.}
#'     \item{distance}{A numeric value representing the centroidal distance, which is the distance between a reference point and the calculated centroid.}
#'     \item{moment}{A numeric value for the area moment (often referred to as area Q), representing the product of the area and the distance to a reference axis.}
#'   }
#' @export
calc_centroid <- function(df_input_response) {

  prep_for_calculations <- df_input_response %>%
    select("conversing", "labeling", "echoing", "requesting")
  prep_for_calculations <- t(prep_for_calculations)

  row_sums <- rowSums(prep_for_calculations*12/ncol(prep_for_calculations))

  xbar <- ((0.5 * abs(row_sums[2]) * abs(row_sums[1]))*(row_sums[2]/3)) +
    ((0.5 * abs(row_sums[4]) * abs(row_sums[1])) * (-row_sums[4]/3)) +
    ((0.5 * abs(row_sums[4]) * abs(row_sums[3])) * (-row_sums[4]/3)) +
    ((0.5 * abs(row_sums[2]) * abs(row_sums[3])) * (row_sums[2]/3))

  ybar <- ((0.5 * abs(row_sums[2]) * abs(row_sums[1])) * (row_sums[1]/3)) +
    ((0.5 * abs(row_sums[4]) * abs(row_sums[1])) * (row_sums[1]/3)) +
    ((0.5 * abs(row_sums[4]) * abs(row_sums[3])) * (-row_sums[3]/3)) +
    ((0.5 * abs(row_sums[2]) * abs(row_sums[3])) * (-row_sums[3]/3))

  area <- ((0.5 * abs(row_sums[2]) * abs(row_sums[1])) +
             ((0.5 * abs(row_sums[4]) * abs(row_sums[1])) +
                ((0.5 * abs(row_sums[4]) * abs(row_sums[3])) +
                   ((0.5 * abs(row_sums[2]) * abs(row_sums[3]))))))

  xcor <- xbar / area
  ycor <- ybar / area

  centx <- as.vector(round(xcor, 2))
  centy <- as.vector(round(ycor, 2))
  centdis <- as.vector(round(round(sqrt(xcor^2 + ycor^2), 2)))
  moment <- as.vector(round(area *(12 - centdis), 2))

  return(
    list(centroid = c(centx, centy),
         distance = centdis,
         moment = moment)
  )

}
