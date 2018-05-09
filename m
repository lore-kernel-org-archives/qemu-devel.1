Received: from eggs.gnu.org ([2001:4830:134:3::10]:37398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGPBE-0007g1-9t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGPB8-0000Za-BE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fGPB7-0000Xo-V1
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:30:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w49DTq8Q117694
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 09:30:44 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hv14cjqyv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 09:30:43 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 9 May 2018 07:30:42 -0600
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180508144608.4c4e8180.cohuck@redhat.com>
	<e8e66bb4-f9bf-7674-c2f4-6dc10edb737b@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 9 May 2018 09:30:32 -0400
MIME-Version: 1.0
In-Reply-To: <e8e66bb4-f9bf-7674-c2f4-6dc10edb737b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <9432a24e-381c-62e1-7579-d2a98a7e911d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, peter.maydell@linaro.org, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 05/08/2018 09:47 AM, Halil Pasic wrote:
>
>
> On 05/08/2018 02:46 PM, Cornelia Huck wrote:
>> On Tue,  8 May 2018 08:25:03 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> Added entries for the s390 adjunct processor (AP) support.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   MAINTAINERS |   14 ++++++++++++++
>>>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> [..]
>
>>> +M: Christian Borntraeger <borntraeger@de.ibm.com>
>>> +M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> +M: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> +M: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>
>> Dumb question: Aren't you folks dropping the 'vnet' part in the future?
>>
>
> Not dumb at all. Please drop 'vnet' (at least for me).

I was not aware of that change.

>
>
> [..]
