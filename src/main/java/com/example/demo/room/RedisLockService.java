package com.example.demo.room;

import java.time.Duration;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;

@Service
public class RedisLockService {
    
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    
    public boolean tryLock(String key, String value, long expireTime) {
        return redisTemplate.opsForValue()
            .setIfAbsent(key, value, Duration.ofSeconds(expireTime));
    }
    
    public void unlock(String key, String value) {
        String script = "if redis.call('get', KEYS[1]) == ARGV[1] then " +
                       "return redis.call('del', KEYS[1]) else return 0 end";
        redisTemplate.execute(new DefaultRedisScript<>(script, Long.class), 
                            Arrays.asList(key), value);
    }
}