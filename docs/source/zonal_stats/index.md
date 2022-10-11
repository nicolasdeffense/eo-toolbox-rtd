# Zonal Statistics

`rasterstats` is a Python module for summarizing geospatial raster datasets based on vector geometries.

Geospatial data typically comes in one of two data models:
- *rasters* which are similar to images with a regular grid of pixels whose values represent some spatial phenomenon (e.g. elevation)
- *vectors* which are entities with discrete geometries (e.g. state boundaries).

`rasterstats` exists solely to extract information from geospatial raster data based on vector geometries.

This involves zonal statistics: a method of summarizing and aggregating the raster values intersecting a vector geometry. For example, zonal statistics provides answers such as the mean precipitation or maximum elevation of an administrative unit.

By default, the **zonal_stats** function will return the following statistics

- min
- max
- mean
- count

Optionally, these statistics are also available.

- sum
- std
- median
- majority
- minority
- unique
- range
- nodata
- percentile (see note below for details)


[> See User Manual](https://pythonhosted.org/rasterstats/manual.html)


```{toctree}
:maxdepth: 2

zonal_stats_continuous

zonal_stats_categorical

```