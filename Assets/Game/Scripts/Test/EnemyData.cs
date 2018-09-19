using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#region V6.0
using static EnemyManager;
#endregion

public class EnemyData
{
    private EnemyCode code;
    private string enemyName;
    private int maxHP;
    private int curHP;

    #region Properties
    public EnemyCode Code
    {
        get
        {
            return code;
        }
        set
        {
            code = value;
        }
    }

    public string Name
    {
        get
        {
            return enemyName;
        }
        set
        {
            enemyName = value;
        }
    }

    public int MaxHP
    {
        get
        {
            return maxHP;
        }
        set
        {
            maxHP = value;
            curHP = maxHP;
        }
    }

    public int CurHP
    {
        get
        {
            return curHP;
        }
    }
    #endregion
}
