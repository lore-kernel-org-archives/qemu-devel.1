Received: from eggs.gnu.org ([2001:4830:134:3::10]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e2abs-00038K-Li
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e2abo-0002Fv-MB
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:21:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52100
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e2abo-0002CO-GZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:20:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9CAJ5Bj118662
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 06:20:52 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dj5s8t2pv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 06:20:52 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 12 Oct 2017 11:20:50 +0100
References: <20171005151313.32015-1-cohuck@redhat.com>
	<20171005171619.28b48ed6.cohuck@redhat.com>
	<d82d4e97-d8c0-916f-1fe6-26a2a0aa4482@redhat.com>
	<20171012094006.03064151.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Oct 2017 12:20:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171012094006.03064151.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f1e9fb83-dae6-d5b4-50b7-3e499eb3b3b2@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/MAINTAINERS: add mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, david@redhat.com, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, agraf@suse.de, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, rth@twiddle.net



On 10/12/2017 09:40 AM, Cornelia Huck wrote:
> On Thu, 12 Oct 2017 08:02:12 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 05.10.2017 17:16, Cornelia Huck wrote:
>>> On Thu,  5 Oct 2017 17:13:13 +0200
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>   
>>>> There's a new qemu-s390x@nongnu.org mailing list: add it to the
>>>> s390 sections.
>>>>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  MAINTAINERS | 6 ++++++
>>>>  1 file changed, 6 insertions(+)  
>>>
>>> Hnm. Hold this, the mailing list does not seem to work yet(?).  
>>
>> FYI: It should be fixed now! (thanks to Ian Kelling from gnu.org)
>>
>>  Thomas
> 
> Yeah!
> 
> I'll queue this. Any further acks from maintainers?

Do you have mine?
