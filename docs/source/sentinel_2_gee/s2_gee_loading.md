# Load Sentinel-2 Surface Reflectance

The Sentinel-2 L2 data are downloaded from SciHub. They were computed by running Sen2Cor.

```js
// Load Harmonized Sentinel-2 MSI: MultiSpectral Instrument, Level-2A

var s2_sr = ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
```

```{note}
The Sentinel Level-1C and Level-2A data products have a harmonized time series. The "harmonized" designation means that the band-dependent offset added to reflectance bands in the 04.00 processing baseline has been removed. The offset affects data after January 24th 2022; removing the offset puts these data in spectral alignment with pre-04.00 baseline data. If you are using COPERNICUS/S2 or COPERNICUS/S2_SR, it is recommended that you switch to COPERNICUS/S2_HARMONIZED and COPERNICUS/S2_SR_HARMONIZED.
```

## Filter Sentinel-2 data

```js
// Define time period
var startDate = '2019-01-01'
var endDate   = '2019-12-31' 
```

```js
var fao_level1 = ee.FeatureCollection("FAO/GAUL/2015/level1")
var wallonia   = fao_level1.filter("ADM1_CODE == 602")
```

```js
// Select S2 SR images in area of interest and time period
var s2_filter = s2_sr
                  .filterDate(startDate, endDate)
                  .filterBounds(wallonia)
                  // Pre-filter to get less cloudy granules.
                  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',20))
```