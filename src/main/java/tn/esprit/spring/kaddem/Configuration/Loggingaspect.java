package tn.esprit.spring.kaddem.Configuration;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Aspect
@Component
public class Loggingaspect {

    private static final Logger logger = LogManager.getLogger(Loggingaspect.class);

    @Before("execution(* tn.esprit.spring.kaddem.services..*(..))")
    public void logBefore(JoinPoint joinPoint) {
        logger.info("Entering method: " + joinPoint.getSignature().getName());
        logger.debug("Arguments: " + joinPoint.getArgs());
    }

    @After("execution(* tn.esprit.spring.kaddem.services..*(..))")
    public void logAfter(JoinPoint joinPoint) {
        logger.info("Exiting method: " + joinPoint.getSignature().getName());
    }

}
