package com.example.springboard.pojo;


public class Result<T> {
    private Integer code;
    private String message;
    private T data;

    public Result(Integer cod, String message, T data) {
        this.code = cod;
        this.data = data;
        this.message = message;
    }

    public  static <E> Result<E> success(E data) {
        return new Result<>(0,"success",data);
    }
    public  static <E> Result<E> success(String message, E data) {
        return new Result<>(0,message,data);
    }
    public static Result success(String message) {
        return new Result(0,message,null);
    }
    public static Result error(String message) {
        return new Result(1,message,null);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
