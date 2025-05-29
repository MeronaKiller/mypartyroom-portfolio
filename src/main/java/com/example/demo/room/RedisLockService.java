package com.example.demo.room;

import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;

@Service
public class RedisLockService {
    
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    
    // ✅ 배치 락 획득을 위한 Lua 스크립트
    private static final String BATCH_LOCK_SCRIPT = 
        "local results = {} " +
        "for i = 1, #KEYS do " +
        "    local result = redis.call('SET', KEYS[i], ARGV[i], 'NX', 'EX', ARGV[#ARGV]) " +
        "    if result then " +
        "        table.insert(results, 1) " +
        "    else " +
        "        table.insert(results, 0) " +
        "    end " +
        "end " +
        "return results";
    
    // ✅ 배치 락 해제를 위한 Lua 스크립트
    private static final String BATCH_UNLOCK_SCRIPT = 
        "local results = {} " +
        "for i = 1, #KEYS do " +
        "    if redis.call('GET', KEYS[i]) == ARGV[i] then " +
        "        table.insert(results, redis.call('DEL', KEYS[i])) " +
        "    else " +
        "        table.insert(results, 0) " +
        "    end " +
        "end " +
        "return results";
    
    // 기본 락 획득 (타임아웃 단축)
    public boolean tryLock(String key, String value, long expireTime) {
        try {
            Boolean result = redisTemplate.opsForValue()
                .setIfAbsent(key, value, Duration.ofSeconds(expireTime));
            
            if (result != null && result) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            System.err.println("🔥 락 획득 에러: " + key + " - " + e.getMessage());
            return false;
        }
    }
    
    // ✅ 고성능 배치 락 획득
    public List<Long> tryLockBatch(List<String> keys, List<String> values, long expireTime) {
        try {
            DefaultRedisScript<List> script = new DefaultRedisScript<>(BATCH_LOCK_SCRIPT, List.class);
            
            // values에 expire time 추가
            values.add(String.valueOf(expireTime));
            
            List<Long> results = redisTemplate.execute(script, keys, values.toArray());
            
            System.out.println("🚀 배치 락 처리: " + keys.size() + "개 중 " + 
                              results.stream().mapToLong(Long::longValue).sum() + "개 성공");
            
            return results;
            
        } catch (Exception e) {
            System.err.println("🔥 배치 락 에러: " + e.getMessage());
            return Arrays.asList(new Long[keys.size()]); // 모두 실패로 반환
        }
    }
    
    // ✅ 고성능 배치 락 해제
    public List<Long> unlockBatch(List<String> keys, List<String> values) {
        try {
            DefaultRedisScript<List> script = new DefaultRedisScript<>(BATCH_UNLOCK_SCRIPT, List.class);
            
            List<Long> results = redisTemplate.execute(script, keys, values.toArray());
            
            System.out.println("🔓 배치 락 해제: " + keys.size() + "개 중 " + 
                              results.stream().mapToLong(Long::longValue).sum() + "개 성공");
            
            return results;
            
        } catch (Exception e) {
            System.err.println("🔥 배치 락 해제 에러: " + e.getMessage());
            return Arrays.asList(new Long[keys.size()]); // 모두 실패로 반환
        }
    }
    
    // ✅ 재시도 로직 최적화 (백오프 전략)
    public boolean tryLockWithRetry(String key, String value, long expireTime, int maxRetries, long initialDelay) {
        long delay = initialDelay;
        
        for (int i = 0; i < maxRetries; i++) {
            boolean acquired = tryLock(key, value, expireTime);
            if (acquired) {
                return true;
            }
            
            if (i < maxRetries - 1) {
                try {
                    Thread.sleep(delay);
                    delay = Math.min(delay * 2, 1000); // 최대 1초까지 백오프
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    return false;
                }
            }
        }
        return false;
    }
    
    // 기본 락 해제 (개선된 버전)
    public boolean unlock(String key, String value) {
        try {
            String script = 
                "if redis.call('GET', KEYS[1]) == ARGV[1] then " +
                "    return redis.call('DEL', KEYS[1]) " +
                "else " +
                "    return 0 " +
                "end";
            
            DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>(script, Long.class);
            Long result = redisTemplate.execute(redisScript, Arrays.asList(key), value);
            
            return result != null && result == 1L;
            
        } catch (Exception e) {
            System.err.println("🔥 락 해제 에러: " + key + " - " + e.getMessage());
            return false;
        }
    }
    
    // ✅ 락 정보 일괄 조회
    public List<Boolean> isLockedBatch(List<String> keys) {
        try {
            List<Boolean> results = redisTemplate.opsForValue().multiGet(keys)
                .stream()
                .map(value -> value != null)
                .toList();
            
            return results;
            
        } catch (Exception e) {
            System.err.println("🔥 배치 락 확인 에러: " + e.getMessage());
            return keys.stream().map(k -> false).toList();
        }
    }
    
    // 락 존재 여부 확인
    public boolean isLocked(String key) {
        try {
            return Boolean.TRUE.equals(redisTemplate.hasKey(key));
        } catch (Exception e) {
            System.err.println("🔥 락 확인 에러: " + key + " - " + e.getMessage());
            return false;
        }
    }
    
    // 락 TTL 확인
    public long getLockTTL(String key) {
        try {
            return redisTemplate.getExpire(key, TimeUnit.SECONDS);
        } catch (Exception e) {
            System.err.println("🔥 TTL 확인 에러: " + key + " - " + e.getMessage());
            return -1;
        }
    }
    
    // ✅ 락 통계 조회
    public long getActiveLockCount(String pattern) {
        try {
            return redisTemplate.keys(pattern + "*").size();
        } catch (Exception e) {
            System.err.println("🔥 락 통계 에러: " + e.getMessage());
            return 0;
        }
    }
}