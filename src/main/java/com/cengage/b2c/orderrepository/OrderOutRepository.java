package com.cengage.b2c.orderrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderOutRepository extends JpaRepository <OrderOut,Integer>{

}
