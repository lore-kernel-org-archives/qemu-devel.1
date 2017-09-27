Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dxD86-0007on-NI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dxD80-0004tc-TA
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:16:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dxD80-0004r9-Kt
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:15:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8REEJb5086203
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:15:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d89s5x0a9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:15:50 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 27 Sep 2017 15:15:48 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170921112459.0153cc64.cohuck@redhat.com>
	<8abd41f8-e3fd-682f-1669-a5c3870c32fd@linux.vnet.ibm.com>
	<20170921124824.5f613e26.cohuck@redhat.com>
	<eb64f78a-bf78-e453-228a-75f131f238d2@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 16:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <eb64f78a-bf78-e453-228a-75f131f238d2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2166358b-1b26-aa11-c7d6-da709f41546d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] 3270 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/21/2017 01:00 PM, Halil Pasic wrote:
>>>> Are you planning to do some further work on 3270, btw?
>>>>   
>>> I did not. I jumped in because of IDA, and because I did
>>> not agree with increasing the buffer size to another arbitrary
>>> an value (and essentially keep the bug). I hope the original
>>> authors will do further polishing.
>> That was actually a plural 'you' (a pity that English uses the same
>> word for both...)
>>
> OK, I've projected it to myself.
> 
>>> I'm just curious, what's behind the question?
>> Just whether I can expect more 3270 changes in the future :) Things
>> like support for multiple devices, whatever. Mostly curiousity.
>>
> Actually, I wanted to ask the same question from the guy
> responsible for the answer. I don't know yet, but I'm sure
> now I want to ask (Stefan R.). I will let you know later.
> 
> Halil
> 
> 

I've got the info: we are currently not planing to work on 3270.
So don't expect more changes 3270 in the near future.

Halil
