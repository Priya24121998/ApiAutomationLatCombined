package com.cengage.b2b.orderrepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserCreation, Integer>{
	
	 List<UserCreation> findByUserAccount(String userAccount);

}
