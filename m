Received: from eggs.gnu.org ([2001:4830:134:3::10]:59381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl8MY-0002qX-UZ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl8MX-0004Fl-UC
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:45:02 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dl8MX-0004Fd-Pu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:45:01 -0400
Received: by mail-qk0-x229.google.com with SMTP id a77so7696685qkb.1
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 23:45:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
References: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 14:45:00 +0800
Message-ID: <CAOE=1Z1wcY4=t-UjxN8mzWyozv9QjxCokEC+WnnyUYegwP46uA@mail.gmail.com>
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

I follow this:
https://en.wikibooks.org/wiki/QEMU/QEMU_Hello_World:_Installing_QEMU_and_getting_it_up_and_running

2017-08-25 14:31 GMT+08:00 Sam <batmanustc@gmail.com>:

> Hi all,
>
> I'm starting vm using:
>
> kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2
>> -cdrom CentOS-7-x86_64-DVD-1503-01.iso -boot d
>> VNC server running on '127.0.0.1:5900'
>
>
> then I start vnc client in another PC to connect 10.253.23.24:11800 and
> 10.253.23.24:5900, I got time out, why?
>
