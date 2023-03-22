# Load Landsat Collection

Landsat, a joint program of the USGS and NASA, has been observing the Earth continuously from 1972 through the present day. Today the Landsat satellites image the entire Earth's surface at a 30-meter resolution about once every two weeks, including multispectral and thermal data.

Landsat data is available in Earth Engine in its raw form, as Surface Reflectance, TOA-corrected reflectance, and in various ready-to-use computed products such as NDVI and EVI vegetation indices.

```{note}
In this course we will only work with **Landsat Collection 2** that marks the second major reprocessing effort on the Landsat archive by the USGS that results in several data product improvements over Collection 1 that harness recent advancements in data processing and algorithm development.
```

|Satellite | Landsat 5  | Landsat 7   | Landsat 8  | Landsat 9 |
|----------|:----------: |:----------:|:---------: | :--------:|
|**Instrument** | <font size="2"> Multispectral Scanner (MSS), <br/>Thematic Mapper (TM) </font>|  <font size="2"> Enhanced Thematic Mapper <br/> (ETM+) </font>| <font size="2"> Operational Land Imager (OLI),<br/> Thermal Infrared <br/>Sensor (TIRS)</font>|  <font size="2"> OLI-2, TIRS-2 </font>|
|**Number of bands**| 10 | 10 | 10 | 10 |
|**Spatial resolution**| 30m x 30m | 30m x 30m| 30m x 30m | 30m x 30m
|**Temporal resolution**| 16 days |  16 days |  16 days |  16 days 
|**Temporal range**| 1984 - 2012 |1999 - Present| 2013 - Present | 2021 - Present
|**Google Earth Engine collection** | [Dataset](https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LT05_C02_T1_L2) | [Dataset](https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LE07_C02_T1_L2) | [Dataset](https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LC08_C02_T1_L2)| *Not available* |


Let's define which datasets we will work with.

```js
// Load USGS Landsat 5 Level 2, Collection 2, Tier 1
var landsat_5 = ee.ImageCollection("LANDSAT/LT05/C02/T1_L2")

// Load USGS Landsat 7 Level 2, Collection 2, Tier 1
var landsat_7 = ee.ImageCollection("LANDSAT/LE07/C02/T1_L2")

// Load USGS Landsat 8 Level 2, Collection 2, Tier 1
var landsat_8 = ee.ImageCollection('LANDSAT/LC08/C02/T1_L2')
```

## Filter Landsat data


```js
// Define time period
var startDate = '2019-01-01'
var endDate   = '2019-12-31'
```

```js
var roi = ee.FeatureCollection("users/nicolasdeffense/extent_roi_32631")
```

```js
// Select Landsat 8 images in area of interest and time period
var l8_filter = landsat_8
                .filterDate(startDate, endDate)
                .filterBounds(roi)
```

## Apply scaling factors

A scale factor must be applied to both Collection 1 and Collection 2 Landsat Level-2 surface reflectance and surface temperature products before using the data.  
**Landsat Collection 2** have the following scale factors, fill values, data type, and valid range.


<figure class="responsive-figure-table"><table>
<thead>
<tr>
<th>Science Product</th>
<th>Scale Factor</th>
<th>Fill Value</th>
<th>Data Type</th>
<th>Valid Range</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collection-2-surface-reflectance">Surface Reflectance</a></td>
<td>0.0000275 + -0.2</td>
<td>0</td>
<td>Unsigned 16-bit integer</td>
<td>1-65455</td>
</tr>
<tr>
<td><a href="https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collection-2-surface-temperature">Surface Temperature</a></td>
<td>0.00341802 + 149.0</td>
<td>0</td>
<td>Unsigned 16-bit integer</td>
<td>1-65455</td>
</tr>
</tbody>
</table></figure>

```{note}
**Examples for scaling Landsat Collection 2 Level-2 science products**  
<font size="2">Landsat Collection 2 surface reflectance has a scale factor of 0.0000275 and an additional offset of -0.2 per pixel. <br/> For example, a pixel value of 18,639 is multiplied by 0.0000275 for the scale factor and then -0.2 is added for the additional offset to get a reflectance value of 0.313 after the scale factor is applied. </font>
```


```js
// Applies scaling factors.
function applyScaleFactors(image) {
  var opticalBands = image.select('SR_B.').multiply(0.0000275).add(-0.2)
  var thermalBands = image.select('ST_B.*').multiply(0.00341802).add(149.0)
  return image.addBands(opticalBands, null, true)
              .addBands(thermalBands, null, true)
}

var l8_filter = l8_filter.map(applyScaleFactors)
```
