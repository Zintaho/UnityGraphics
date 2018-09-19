using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#region V6.0
using static EnemyManager;
#endregion

public class Enemy : MonoBehaviour
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
        }
    }

    public int CurHP
    {
        get
        {
            return curHP;
        }
        set
        {
            curHP = value;
        }
    }
    #endregion

    public Enemy(EnemyCode c, string n, int mh)
    {
        code = c;
        enemyName = n;
        maxHP = curHP = mh;
    }
}
