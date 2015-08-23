package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import org.springframework.orm.jpa.support.JpaDaoSupport;
import org.springframework.stereotype.Repository;

@Repository("JpaDaoBase")
public class JpaDaoBase extends JpaDaoSupport {

	private EntityManagerFactory entityManagerFactory ;

	public EntityManagerFactory getEntityManagerFactory() {
		return entityManagerFactory ;
	}

	public EntityManager getEntityManager(){
		return entityManagerFactory.createEntityManager() ;
	}

	@Resource(name="entityManagerFactory")
	public void setMyEntityManagerFactory(EntityManagerFactory entityManagerFactory){
	    super.setEntityManagerFactory(entityManagerFactory);
	    this.entityManagerFactory = entityManagerFactory ;
	}

	public void persist(Object entity) {
		this.getJpaTemplate().persist(entity);
	}

	public void merge(Object entity) {
		this.getJpaTemplate().merge(entity);
	}

	public void remove(Object entity) {
		this.getJpaTemplate().remove(entity);
	}

	public <T> T find(final Class<T> entityClass, final Object id){
		return this.getJpaTemplate().find(entityClass, id);
	}

	@SuppressWarnings("rawtypes")
	public List find(String pdaSql, final Object... values){
		return this.getJpaTemplate().find( pdaSql, values);
	}

	public void removeFromKey(Class<?> entityClass,Object id) {
        remove(find(entityClass, id));
    }

}
