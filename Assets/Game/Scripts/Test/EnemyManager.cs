using System.Collections;
using System.Collections.Generic;
using System;
using System.Linq;
using UnityEngine;
using UnityEngine.Events;

#region V6.0
using static EventManager.CustomEventType;
#endregion

public class EnemyManager : MonoBehaviour
{
    public enum EnemyCode
    {
        RACOON = 1001,
        DOG = 1002,
        BEAR = 1003,
        FOX = 1004,
    }

    private static readonly Enemy[] enemies = {
        new Enemy(EnemyCode.RACOON, "너구리", 100),
        new Enemy(EnemyCode.DOG, "강아지", 150),
        new Enemy(EnemyCode.BEAR, "새끼 곰", 200),
        new Enemy(EnemyCode.FOX, "여우", 125),
    };

    #region Event & Awake
    private UnityAction targetAction;
    private void Awake()
    {
        targetAction = new UnityAction(Target);
    }
    private void OnEnable()
    {
        EventManager.StartListening(ENEMY_TARGETED, targetAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(ENEMY_TARGETED, targetAction);
    }

    private void Target()
    {
        GameObject obj = OnscreenRay.hitObject;
        Enemy enemy;
        if (!(enemy = obj.GetComponent<Enemy>()))
        {
            ///Enemy Component가 없는 경우 추가 (CurHP 때문에)
            obj.AddComponent<Enemy>();

            string[] splitedName = OnscreenRay.hitName.Split('_');
            int code = Convert.ToInt32(splitedName[1]);
            #region V3.0
            //LINQ가 불필요한 상황이나, 사용할 수 있음을 나타내기 위해 사용하였음
            //추후 Enemy 도감 기능 추가시 아래 내용을 Find<>로 변경할 것
            var queriedEnemies = from element in enemies
                                 where element.Code == (EnemyCode)code
                                 select element;
            #endregion
            enemy = queriedEnemies.First();

            obj.GetComponent<Enemy>().Code = enemy.Code;
            obj.GetComponent<Enemy>().Name = enemy.Name;
            obj.GetComponent<Enemy>().CurHP = enemy.CurHP;
            obj.GetComponent<Enemy>().MaxHP = enemy.MaxHP;
        }
        EventManager.TriggerEvent(ENEMY_TARGETED_UI);
    }
    #endregion
}
