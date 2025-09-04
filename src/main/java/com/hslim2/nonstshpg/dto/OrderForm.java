package com.hslim2.nonstshpg.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderForm {
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String paymentMethod;
}