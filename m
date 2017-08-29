Received: from eggs.gnu.org ([2001:4830:134:3::10]:49525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmcaF-0003aX-Ih
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmcaB-0008KW-Qj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:13:19 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dmcaB-0008Av-Ec
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:13:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170829085128.GA25960@stefanha-x1.localdomain>
References: <20170828145728.dqubknb7fruy4sfu@postretch>
	<20170829085128.GA25960@stefanha-x1.localdomain>
Date: Tue, 29 Aug 2017 11:12:37 +0200
Message-ID: <w511snuhh4q.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] GSOC Report: Moving I/O throttling and write
 notifiers into block filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 29 Aug 2017 10:51:28 AM CEST, Stefan Hajnoczi wrote:

>> Already merged patches in 2.10
>>  https://github.com/qemu/qemu/commits/v2.10.0-rc4?author=epilys
>> Already merged patches for 2.11
>>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg470461.html
>> 
>> [0] [insert-node] block-insert-node and block-remove-node commands
>>  https://github.com/epilys/qemu/commits/insert-node?author=epilys
>> 
>> [1] [throttle] add throttle filter driver
>>  https://github.com/epilys/qemu/commits/throttle?author=epilys
>>  Message-ID: <20170825132028.6184-1-el13635@mail.ntua.gr>
>>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg476047.html
>> 
>> [2] [throttle-remove-legacy] remove legacy throttling interface
>>  https://github.com/epilys/qemu/commits/throttle-remove-legacy?author=epilys
>> 
>> [3] [4] [notify] https://github.com/epilys/qemu/commits/notify?author=epilys
>> 
>> [5] block-insert-node RFC
>>  Message-ID: <20170815074513.9055-1-el13635@mail.ntua.gr>
>>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg473619.html
>
> Thanks for your hard work, Manos!

Indeed, thanks!!

Berto
