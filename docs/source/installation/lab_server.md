# From lab’s servers

```{note}
Only for students with access to the lab’s IT infrastructure
```

1. Connect to Windows server Geo14 (*geo14.elie.ucl.ac.be*)
    
    *Don't forget to activate your VPN if you're not connected in eduroam WIFI !*

2. Open *Anaconda Prompt*

3. Activate **LBRAT2104**'s environment
    ```console
    conda activate G:\conda_env\lbrat2104
    ```
    *The name of the environment must appear before the name of the disk*  
    `(G:\conda_env\lbrat2104) C:\>`

4. Go to home disk, the disk where you stored all you data
    The home disk (\\\\geo12\homes) must be map before (via *This PC > Map network drive...*)   
    You can map the disk with another letter than H

    ```sh
    H:
    ```

5. Launch JupyterLab
    ```sh
    jupyter lab
    ```
    
    By default, JupyterLab opens in Internet Explorer and this does not work. You need to copy the URL link and paste it into Google Chrome instead.

6. Navigates to the folder where the notebooks are located
    
    You can download all the content of this git by clicking on "Code>Download ZIP".