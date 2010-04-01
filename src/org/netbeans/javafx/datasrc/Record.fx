/*
 * Copyright (c) 2009, Sun Microsystems, Inc.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 * 
 *  * Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright 
 *    notice, this list of conditions and the following disclaimer in 
 *    the documentation and/or other materials provided with the distribution.
 *  * Neither the name of Sun Microsystems, Inc. nor the names of its 
 *    contributors may be used to endorse or promote products derived 
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */
 
package org.netbeans.javafx.datasrc;

/**
 * A record contains set of named fields. A field value can be of any primitive type
 * (String, Number, etc.) or it can be a RecordSet.
 *
 * @author Maros Sandor
 */
public abstract class Record {

    /**
     * A function that computes display name for this Record.
     */
    public-init var displayName : function(record: Record) : String;

    /**
     * @return list of field names this Record contains or null if this functionality is not supported by this Record
     */
    public abstract function getFields() : String [];

    /**
     * @param name name of a field
     * @return value of the field with the given name or null if no such field exists
     */
    public abstract function get(name : String) : Object;

    /**
     * Convenience method that retrieves value of a field and converts it to String.
     *
     * @param name name of a field
     * @return value of the field with the given name or null if no such field exists
     */
    public function getString(name : String) : String {
        get(name) as String
    }

    /**
     * Convenience method that retrieves value of a field and converts it to RecordSet.
     *
     * @param name name of a field
     * @return value of the field with the given name or null if no such field exists
     */
    public function getRecordSet(name : String) : RecordSet {
        get(name) as RecordSet
    }

    /**
     * @return display name of this record as computed by the displayName function
     */
    override public function toString() : String {
        displayName(this)
    }

    public function getXmlElementText(name : String) : String {
        var rs = getRecordSet(".elements");
        for (elem in rs.all()) {
            var elemName = elem.getString(".name");
            if (elemName != null and elemName == name) {
                return elem.getString(".text")
            }
        }
        null
    }
}
