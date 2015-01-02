//
// Copyright (C) 2013 Fraunhofer Institut for Solar Energy Systems 
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.
//
// created: 	2013-01-21
// author(s):	Pascal Benoit (pascal.benoit@ise.fraunhofer.de)
// 

package ise.cpvplant.applications;


//
// Specification what the simple PlantAnalyzeApp should do after the implementation. 
// The module should determine the following values:
//
//   -# quantitity network nodes N (not implemented)
//
//   -# quantitity of sun tracker T (not implemented)
//
//   -# total number of switches S (not implemented)
//
//   -# number of managed switches S_m (not implemented)
//
//   -# number of unmanaged switches (not implemented)
//
//   -# classify and  count the swichtes S_m/um,pe,pf (not implemented)
//
//   -# total accumulated length of Ethernet cables (not implemented)
//
//   -# total accumulated length of fiber cables (not implemented)
//
simple PlantAnalyzeApp
{
    parameters:
	@display("i=block/star;is=s");
	        
}    
