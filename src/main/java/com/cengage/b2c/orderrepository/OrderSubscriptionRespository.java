package com.cengage.b2c.orderrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderSubscriptionRespository extends JpaRepository <OrderSuscriptionOut,Integer>{

}
