Received: from eggs.gnu.org ([2001:4830:134:3::10]:48450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essWq-0000r5-Ai
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essWm-0001wJ-JE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:59:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1essWm-0001w2-Eh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:59:52 -0500
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-24-git-send-email-mjc@sifive.com>
	<4506959a-8d32-039a-f0e3-c864fd44ace6@redhat.com>
	<CAHNT7NsGeLU8rzfJBBrKxuD9WffHRNcF=mUrgGXzWF=2Qz2FdA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25cfff0d-4fd2-ac85-f9e6-feec9d9e4469@redhat.com>
Date: Mon, 5 Mar 2018 09:59:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsGeLU8rzfJBBrKxuD9WffHRNcF=mUrgGXzWF=2Qz2FdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 23/23] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 03/02/2018 08:37 PM, Michael Clark wrote:
> Let me know if you have a branch for me to pull and rebase against.

http://repo.or.cz/qemu/ericb.git qapi

But that has landed in master now.

> 
> We are passing all build and make check tests in travis (except for a
> couple of build timeouts because we are hitting the default 50 minute
> timeout)
> 
> https://travis-ci.org/riscv/riscv-qemu/builds/348234736
> 

Also, top-posting makes it a bit harder to see what you are replying to.


>>>    qapi-schema.json                       | 17 ++++++++++++++++-
>>>
>>
>> Will need rebasing to modify qapi/misc.json if my pending PULL request
>> issues get resolved first:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00469.html
>>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
