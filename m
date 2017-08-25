Received: from eggs.gnu.org ([2001:4830:134:3::10]:35971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl9Eo-0007Xv-1P
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl9En-00073D-3B
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:41:06 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dl9Em-00072w-V1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:41:05 -0400
Received: by mail-qt0-x230.google.com with SMTP id e2so7908777qta.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 00:41:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z016QRxMpPkLAMH73tcB-niD_n5hEQWDEG7BDv6Ks41sw@mail.gmail.com>
References: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
	<CAOE=1Z1wcY4=t-UjxN8mzWyozv9QjxCokEC+WnnyUYegwP46uA@mail.gmail.com>
	<CAOE=1Z016QRxMpPkLAMH73tcB-niD_n5hEQWDEG7BDv6Ks41sw@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 15:41:03 +0800
Message-ID: <CAOE=1Z24zv=PNBBLXWOZtip5vx-4pKDvq68oGFbNUAr2K_jKpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why got no response of vnc?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I use ssh to the host PC, so I think I could not use two screen.

2017-08-25 15:38 GMT+08:00 Sam <batmanustc@gmail.com>:

> Actually, I just want to install OS and use it, but I found I can't go
> into guest OS (as vnc time out), so what should I do?
>
> 2017-08-25 14:45 GMT+08:00 Sam <batmanustc@gmail.com>:
>
>> I follow this:
>> https://en.wikibooks.org/wiki/QEMU/QEMU_Hello_World:_Install
>> ing_QEMU_and_getting_it_up_and_running
>>
>> 2017-08-25 14:31 GMT+08:00 Sam <batmanustc@gmail.com>:
>>
>>> Hi all,
>>>
>>> I'm starting vm using:
>>>
>>> kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2
>>>> -cdrom CentOS-7-x86_64-DVD-1503-01.iso -boot d
>>>> VNC server running on '127.0.0.1:5900'
>>>
>>>
>>> then I start vnc client in another PC to connect 10.253.23.24:11800 and
>>>  10.253.23.24:5900, I got time out, why?
>>>
>>
>>
>
