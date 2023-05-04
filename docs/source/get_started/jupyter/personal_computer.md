# From your personal computer

1. Download Miniconda (or Anaconda)  

    I recommend to use the `conda` package manager to install all the requirements. You can install [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or install the (larger) [Anaconda](https://www.anaconda.com/products/individual) distribution.

    ```{note}
    `conda` is a powerful package manager and environment manager that you use with command line commands at the Anaconda Prompt for Windows, or in a terminal window for macOS or Linux.
    ```

    [Getting started with conda](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html)

2. Download the YAML file [env_lbrat2104_2024.yml](https://github.com/nicolasdeffense/eo-toolbox-rtd/blob/main/env_lbrat2104_2024.yml)

    To download a file from GitHub, first click on the `raw` button, then `CTRL-S`.
    
    Do not save the file with the ``.txt`` extension !

3. Open *Anaconda Prompt* (Windows) or *Terminal* (MacOS)

4. Create a conda envrionment from YAML file (*change the file path !*)
    ```sh
    conda env create --file {file_path}env_lbrat2104_2024.yml
    ```

5. Activate **LBRAT2104**'s environment
    ```sh
    conda activate lbrat2104_2023_2024
    ```

6. *Optional* - Download other libaries with `conda` or `pip`

    > Some libraries can not be installed with `conda` and must be installed through `pip`

    For instance, to install [sentinelsat](https://sentinelsat.readthedocs.io/en/stable/index.html) you must launch this command :

    ```sh
    pip install sentinelsat
    ```

7. Launch JupyterLab

    ```sh
    jupyter lab
    ```