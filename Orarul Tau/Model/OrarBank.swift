//
//  OrarBank.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 14/03/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import Foundation

class OrarBank {
    
    var listaOrar = [OrarData]()
    
    init(){
        listaOrar.append(OrarData(zi: "luni", cod: "2012", Materie: "Aociologie", Profesor: "Vreja Lucia", Tip: "Seminar impar", intervalOra: "12:00-13:30"))
        listaOrar.append(OrarData(zi: "luni", cod: "1102", Materie: "Statistica pietei financiare", Profesor: "Pele Daniel Traian", Tip: "Curs", intervalOra: "13:35-14:55"))
        listaOrar.append(OrarData(zi: "luni", cod: "2001A", Materie: "Pachete software", Profesor: "", Tip: "Seminar", intervalOra: "15:05-16:25"))
        listaOrar.append(OrarData(zi: "marti", cod: "1201", Materie: "Proiectares sistemelor informatice", Profesor: "", Tip: "Curs", intervalOra: "07:30-08:50"))
        listaOrar.append(OrarData(zi: "marti", cod: "1201", Materie: "Pachete software", Profesor: "", Tip: "Curs", intervalOra: "09:05-10:25"))
        listaOrar.append(OrarData(zi: "marti", cod: "2608", Materie: "Statistica pietei financiare", Profesor: "Daniel Traian", Tip: "Seminar", intervalOra: "10:35-11:55"))
        listaOrar.append(OrarData(zi: "marti", cod: "2604", Materie: "Serii de timp", Profesor: "Simona Apostu", Tip: "Seminar", intervalOra: "12:00-13:20"))
        listaOrar.append(OrarData(zi: "miercuri", cod: "1201", Materie: "Sociologie", Profesor: "Vreja Lucia", Tip: "Curs", intervalOra: "09:05-10:25"))
        listaOrar.append(OrarData(zi: "miercuri", cod: "2302", Materie: "Previziune macroeconomica", Profesor: "Gradinaru Giani Ionel", Tip: "Seminar", intervalOra: "10:35-11:55"))
        listaOrar.append(OrarData(zi: "miercuri", cod: "2204", Materie: "Previziune macroeconomica", Profesor: "Gradinaru Giani Ionel", Tip: "Curs", intervalOra: "13:35-14:55"))
        listaOrar.append(OrarData(zi: "joi", cod: "1102", Materie: "Serii de timp", Profesor: "Boboc Cristina-Rodica", Tip: "Curs", intervalOra: "12:00-13:20"))
        listaOrar.append(OrarData(zi: "joi", cod: "1102", Materie: "Dreptul afacerii", Profesor: "", Tip: "Curs", intervalOra: "13:35-14:55"))
        listaOrar.append(OrarData(zi: "joi", cod: "2302", Materie: "Dreptul afacerii", Profesor: "", Tip: "Seminar par", intervalOra: "15:05-16:25 "))
        listaOrar.append(OrarData(zi: "joi", cod: "2001A", Materie: "Proiectarea sistemelor informatice", Profesor: "Florea Alexandra-Maria", Tip: "Seminar impar", intervalOra: "15:05-16:25"))
        listaOrar.append(OrarData(zi: "vineri", cod: "", Materie: "LIBER", Profesor: "", Tip: "", intervalOra: ""))
        
        
        
        
        
    }
    
    
}
