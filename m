Received: from eggs.gnu.org ([2001:4830:134:3::10]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJOG-0000vQ-7J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJOD-0000os-AB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:20:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37396
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duJOC-0000oT-Oy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:20:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JEJhkI113730
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:20:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d313wf4re-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:20:36 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 15:20:19 +0100
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<20170915190118.03dc1b57.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 16:20:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170915190118.03dc1b57.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1301a0dc-755f-1670-1062-b70ea86802e0@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 15/09/2017 19:01, Cornelia Huck wrote:
> On Fri, 15 Sep 2017 09:27:58 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Thu, 14 Sep 2017 18:50:29 +0200
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 09/14/2017 04:26 PM, Cornelia Huck wrote:
>=20
>>>> There's quite some potential in this. We may want to make this a
>>>> permanent addition.
>>>>     =20
>>>
>>> I'm happy to contribute! I'm not sure how shall we proceed though.
>>> Maybe with making a todo list?
>>
>> I think the first step would be to figure out the ids so we don't step
>> on anyone's toes. Then maybe refactor a bit so that other testers can
>> be added easily.
>>
>> For ideas about things to be tested, maybe put a list into the wiki?
>=20
> OK, I've created https://wiki.qemu.org/Testing/CCWTestDevice - let me
> know if you need an account.
>=20

Great!
I just saw your email, it was waiting in my inbox.
strange things happens some time. A good serie. strange things.
neverless...

Seriously.
Yes, I definitively need an account!


Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
