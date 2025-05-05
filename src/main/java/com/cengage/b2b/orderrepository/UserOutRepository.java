package com.cengage.b2b.orderrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserOutRepository extends JpaRepository<UserCreationOut, Integer>{

}
