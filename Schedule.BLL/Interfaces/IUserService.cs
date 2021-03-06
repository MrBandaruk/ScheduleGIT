﻿using Schedule.DAL.Dto;
using Schedule.BLL.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Schedule.BLL.Interfaces
{
    public interface IUserService : IDisposable
    {
        Task<OperationDetails> Create(UserDto userDto);
        Task<ClaimsIdentity> Authenticate(UserDto userDto);
        Task SetInitialData(UserDto adminDto, List<string> roles); //создает таблицы в базе, если их нет.
    }
}
