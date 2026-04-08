package com.example.springboard.Test;

import org.junit.jupiter.api.Test;

public class ThreadLocalTest {
    @Test
    public void testThreadLocalSetAdnGet(){
        ThreadLocal tl=new ThreadLocal();
        new Thread(()->{
            tl.set("消炎");
            System.out.println(Thread.currentThread().getName()+":"+tl.get());
            System.out.println(Thread.currentThread().getName()+":"+tl.get());
            System.out.println(Thread.currentThread().getName()+":"+tl.get());

        },"蓝色").start();


        new Thread(()->{
            tl.set("姚程");
            System.out.println(Thread.currentThread().getName()+":"+tl.get());
            System.out.println(Thread.currentThread().getName()+":"+tl.get());
            System.out.println(Thread.currentThread().getName()+":"+tl.get());

        },"绿色").start();

    }
}
