# Load Sentinel-2 Surface Reflectance

The Sentinel-2 L2 data are downloaded from SciHub. They were computed by running Sen2Cor.

<section>
<table class="eecat">
<tr>
<th scope="col">Name</th>
<th scope="col">Units</th>
<th scope="col">Min</th>
<th scope="col">Max</th>
<th scope="col">Scale</th>
<th scope="col">Pixel Size</th>
<th scope="col">Wavelength</th>
<th scope="col">Description</th>
</tr>
<tr>
<td><code translate="no" dir="ltr">B1</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      60 meters
</td>
<td>443.9nm (S2A) / 442.3nm (S2B)</td>
<td><p>Aerosols</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B2</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      10 meters
</td>
<td>496.6nm (S2A) / 492.1nm (S2B)</td>
<td><p>Blue</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B3</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      10 meters
</td>
<td>560nm (S2A) / 559nm (S2B)</td>
<td><p>Green</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B4</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      10 meters
</td>
<td>664.5nm (S2A) / 665nm (S2B)</td>
<td><p>Red</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B5</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>703.9nm (S2A) / 703.8nm (S2B)</td>
<td><p>Red Edge 1</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B6</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>740.2nm (S2A) / 739.1nm (S2B)</td>
<td><p>Red Edge 2</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B7</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>782.5nm (S2A) / 779.7nm (S2B)</td>
<td><p>Red Edge 3</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B8</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      10 meters
</td>
<td>835.1nm (S2A) / 833nm (S2B)</td>
<td><p>NIR</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B8A</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>864.8nm (S2A) / 864nm (S2B)</td>
<td><p>Red Edge 4</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B9</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      60 meters
</td>
<td>945nm (S2A) / 943.2nm (S2B)</td>
<td><p>Water vapor</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B11</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>1613.7nm (S2A) / 1610.4nm (S2B)</td>
<td><p>SWIR 1</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">B12</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.0001</td>
<td>
      20 meters
</td>
<td>2202.4nm (S2A) / 2185.7nm (S2B)</td>
<td><p>SWIR 2</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">AOT</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td>0.001</td>
<td>
      10 meters
</td>
<td></td>
<td><p>Aerosol Optical Thickness</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">WVP</code></td>
<td>cm</td>
<td>
</td>
<td>
</td>
<td>0.001</td>
<td>
      10 meters
</td>
<td></td>
<td><p>Water Vapor Pressure. The height the water would occupy if the vapor were condensed into
liquid and spread evenly across the column.</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">SCL</code></td>
<td></td>
<td>
          1
</td>
<td>
          11
</td>
<td></td>
<td>
      20 meters
</td>
<td></td>
<td><p>Scene Classification Map (The &quot;No Data&quot; value of 0 is masked out)</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">TCI_R</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      10 meters
</td>
<td></td>
<td><p>True Color Image, Red channel</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">TCI_G</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      10 meters
</td>
<td></td>
<td><p>True Color Image, Green channel</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">TCI_B</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      10 meters
</td>
<td></td>
<td><p>True Color Image, Blue channel</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">MSK_CLDPRB</code></td>
<td></td>
<td>
          0
</td>
<td>
          100
</td>
<td></td>
<td>
      20 meters
</td>
<td></td>
<td><p>Cloud Probability Map (missing in some products)</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">MSK_SNWPRB</code></td>
<td></td>
<td>
          0
</td>
<td>
          100
</td>
<td></td>
<td>
      10 meters
</td>
<td></td>
<td><p>Snow Probability Map (missing in some products)</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">QA10</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      10 meters
</td>
<td></td>
<td><p>Always empty</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">QA20</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      20 meters
</td>
<td></td>
<td><p>Always empty</p></td>
</tr>
<tr>
<td><code translate="no" dir="ltr">QA60</code></td>
<td></td>
<td>
</td>
<td>
</td>
<td></td>
<td>
      60 meters
</td>
<td></td>
<td><p>Cloud mask</p></td>
</tr>
<tr class="alt">
<td colspan=100>
</table>
</section>


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