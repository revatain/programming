package com.example.bean;

import org.springframework.stereotype.Component;

@Component
public class Robot{
    private final Arm arm;
    private final Leg leg;
    public Robot(Arm arm, Leg leg) {
        this.arm = arm;
        this.leg = leg;
    }

    
}