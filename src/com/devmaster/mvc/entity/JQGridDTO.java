package com.devmaster.mvc.entity;

import java.io.Serializable;
import java.util.List;
 
public class JQGridDTO < T extends Serializable > {
 
    private int page;
 
    private int total;
 
    private String records;
 
    private List<T> rows;
 
    public int getPage() {
        return page;
    }
 
    public void setPage(int page) {
        this.page = page;
    }
 
    public int getTotal() {
        return total;
    }
 
    public void setTotal(int total) {
        this.total = total;
    }
 
    public String getRecords() {
        return records;
    }
 
    public void setRecords(String records) {
        this.records = records;
    }
 
    public List<T> getRows() {
        return rows;
    }
 
    public void setRows(List<T> rows) {
        this.rows = rows;
    }
 
}