/*
 * (c) Fraunhofer Institut for Solar Energy Systems (ISE)
 * Division Electrical Energy Systems (EES)
 * Department Intelligent Energy Systems (IES)
 *
 * Plant.h
 *
 * Created on:  Nov 19, 2012
 * Author(s):   Pascal Benoit
 *
 */

#ifndef PLANT_H_
#define PLANT_H_

class Plant : public cSimpleModule {
    //protected:

    //    int numT;
    //    int numS_um;
    //    int numS_m;



    protected:
        virtual void initialize(int stage);
        virtual void finish();
};

#endif /* PLANT_H_ */
