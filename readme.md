# Real-time monitoring of ICU bed availability in Switzerland

The goal of this [project](https://devpost.com/software/bluebed/) (part of the versusvirus-hackathon) is to have a real time view on how many beds (ICU & non ICU) are available across Switzerland. To augment such monitoring capability, predictive modeling techniques that forecast how long a patient will remain hospitalized will be applied. Such approach allows for a more accurate resource planning of hospital beds and distribution of patients across Swiss hospitals.

## BlueBeds Platform

Out proposed solution is the BlueBeds Platform for which the code for a prototype can be found [here](https://github.com/gpietro/hackathon-versusvirus-backend) and [here](https://github.com/gpietro/hackathon-versusvirus-client). The platform is the end-product, which collects data on the hospital-level and patient-level, and gives real-time predictions on the length-od-stay of the patient in that same bed. This will help with hospital-management. A description on how the data could be collected on the platform and how this data can be used in rather easy and straightforward prediction models can be found [here](https://rachelhey.github.io/versus-virus-hack-length-of-stay-prediction/).

## Data generation setup

To better illustrate the models, mock-data was generated as follows:

1) Use a [data synthesizer](https://github.com/theodi/synthetic-data-tutorial) to produce ~10k hospital patients.

2) Adjust synthetic data to Switzerland and current time frame (March/April 2020)

3) Map data to number of [beds available in Swiss hospitals](https://docs.google.com/spreadsheets/d/1uSisBqRAgp-cNlYPePOUF4YX_idp0JaeZEVyY3MbaJk/edit#gid=0)

4) Sample data according to volume of ICU beds available in Swiss hospitals

5) Sample admission type : ICU invasive, ICU non-invasive, Non-ICU ([source](https://www.cdc.gov/coronavirus/2019-ncov/hcp/clinical-guidance-management-patients.html))

6) Augment data with patient information about symptoms & preconditions and sample according to [frequency of occurrence](https://jamanetwork.com/journals/jama/fullarticle/2761044)

7) Engineer duration of stay based on [admission type](https://www.cdc.gov/coronavirus/2019-ncov/hcp/clinical-guidance-management-patients.html) & [death occurrence](https://www.cdc.gov/mmwr/volumes/69/wr/mm6912e2.htm#T1_down)

Please note that not all assumptions have been available prior generation of the data and some might deviate from the underlying literature. Conditional occurrence of medical preconditions and gender biases were not included in this first version. 


# Prediction models

- A first very basic prediction model build with R, can be found at the end of [this document](https://rachelhey.github.io/versus-virus-hack-length-of-stay-prediction/).

- An alternative model build in `Python` can be found [here](https://github.com/rachelHey/versus-virus-hack-length-of-stay-prediction/blob/master/python-version/Bed_Forecasting_Model_Training.ipynb).