Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwTZN-0006Mw-GM
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwTZJ-000141-Ho
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:04:53 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cwTZJ-00013w-DP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:04:49 -0400
Received: by mail-io0-x242.google.com with SMTP id b140so2467821iof.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 06:04:49 -0700 (PDT)
In-Reply-To: <CAJy91CbmDWrRCmA8gbgYBNXx0NNeZBSXSd19J+MNUYzLMrLCwQ@mail.gmail.com>
References: <mailman.167.1491494426.906.qemu-devel@nongnu.org>
	<3F8ADDFA-7686-416B-A63A-4C59EC99DDC6@gmail.com>
	<CAJy91CaTPoUVHYSKAqM=svr3E=JPr-3pYYGRW72Fr-XuS0RTNQ@mail.gmail.com>
	<CAJy91CbmDWrRCmA8gbgYBNXx0NNeZBSXSd19J+MNUYzLMrLCwQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5ECA2A1E-99B1-4D9E-90E1-B6FA70947E0D@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 7 Apr 2017 09:04:45 -0400
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


On Apr 7, 2017, at 3:08 AM, Jiahuan Zhang wrote:

>
>
> On 7 April 2017 at 08:26, Jiahuan Zhang <jiahuanzhang90@gmail.com>  
> wrote:
> On 6 April 2017 at 19:58, G 3 <programmingkidx@gmail.com> wrote:
>
> On Apr 6, 2017, at 12:00 PM, qemu-devel-request@nongnu.org wrote:
>
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
>
> My vote goes to running multiple instances of QEMU at the same  
> time. It is easy to do and works.
>
> Just done a try. Multiple system emulation can be done by running  
> multiple instances of QEMU. You are right! Thanks.

You're welcome.
