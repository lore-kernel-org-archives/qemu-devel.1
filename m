Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2xV-0007yM-52
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2xR-0008DG-1s
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:47:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32974
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fG2xQ-0008D5-RY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:47:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48DeAu2105042
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 09:47:08 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hua5m1qg8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:47:07 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 May 2018 14:47:06 +0100
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180508144608.4c4e8180.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 8 May 2018 15:47:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180508144608.4c4e8180.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e8e66bb4-f9bf-7674-c2f4-6dc10edb737b@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, peter.maydell@linaro.org, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 05/08/2018 02:46 PM, Cornelia Huck wrote:
> On Tue,  8 May 2018 08:25:03 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Added entries for the s390 adjunct processor (AP) support.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS |   14 ++++++++++++++
>>   1 files changed, 14 insertions(+), 0 deletions(-)

[..]

>> +M: Christian Borntraeger <borntraeger@de.ibm.com>
>> +M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> +M: Halil Pasic <pasic@linux.vnet.ibm.com>
>> +M: Pierre Morel <pmorel@linux.vnet.ibm.com>
> 
> Dumb question: Aren't you folks dropping the 'vnet' part in the future?
> 

Not dumb at all. Please drop 'vnet' (at least for me).

[..]
