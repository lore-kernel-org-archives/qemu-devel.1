Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwBfg-0001du-C4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwBfc-00016v-GC
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:58:12 -0400
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cwBfc-00015j-A7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:58:08 -0400
Received: by mail-it0-x22d.google.com with SMTP id a140so30644355ita.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 10:58:08 -0700 (PDT)
In-Reply-To: <mailman.167.1491494426.906.qemu-devel@nongnu.org>
References: <mailman.167.1491494426.906.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F8ADDFA-7686-416B-A63A-4C59EC99DDC6@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 6 Apr 2017 13:58:03 -0400
Subject: Re: [Qemu-devel] is qemu able to run multiple system emulation
 simultaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Apr 6, 2017, at 12:00 PM, qemu-devel-request@nongnu.org wrote:

> Dear QEMU developers,
>
> I need multiple ARM-based hardware emulation runing simultaneously  
> in one
> PC.
> I wander if QEMU is capble to run two system emulation at the same  
> time.
> Or I have to use two QEMU for two system emulation
>
> If the former is possible, where can i find some docs about it? I have
> searched two days, the result is not positive.
>
> Please help. Thanks in advance.
>
> Best regards,
> Jiahuan

My vote goes to running multiple instances of QEMU at the same time.  
It is easy to do and works.
