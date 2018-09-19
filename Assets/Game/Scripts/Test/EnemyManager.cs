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

    private static readonly EnemyData[] enemies = {
        new EnemyData() {Code=EnemyCode.RACOON,Name="너구리",MaxHP=100},
        new EnemyData() {Code=EnemyCode.DOG,Name="강아지",MaxHP=150},
        new EnemyData() {Code=EnemyCode.BEAR,Name="새끼 곰",MaxHP=200},
        new EnemyData() {Code=EnemyCode.FOX,Name="여우",MaxHP=125},
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
        Enemy enemy = obj.GetComponent<Enemy>();

        string[] splitedName = OnscreenRay.hitName.Split('_');
        int code = Convert.ToInt32(splitedName[1]);
        #region V3.0
        //LINQ가 불필요한 상황이나, 사용할 수 있음을 나타내기 위해 사용하였음
        //추후 Enemy 도감 기능 추가시 아래 내용을 Find<>로 변경할 것
        var queriedEnemies = from element in enemies
                             where element.Code == (EnemyCode)code
                             select element;
        #endregion
        EnemyData qEnemy = queriedEnemies.First();

        enemy.Code = qEnemy.Code;
        enemy.Name = qEnemy.Name;
        enemy.CurHP = qEnemy.CurHP;
        enemy.MaxHP = qEnemy.MaxHP;

        EventManager.TriggerEvent(ENEMY_TARGETED_UI);
    }
    #endregion
}
