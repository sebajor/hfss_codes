# hfss_codes
Codes to generate HFSS models.

The main idea is to have a library that allows you to describe the goemetry that you want to implenent in python to later have a translation layer that get these objects and transform them into what HFSS (or in principle any other CAD software) wants.

The current iteration is done in HFSS 15, that didnt support python, therefore we are generating vbs files to do the models.

## TODO

- [ ] Miroctrip calculator
- [ ] Convert the different geometries into classes, to be able to combine them right away.
- [ ] CST integration

