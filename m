Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMC6H-0002Xh-Ch
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMC6D-0003bd-Ik
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:13:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMC6D-0003bK-AH
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:13:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5C8YSf051832
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 07:13:17 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ensh4e23s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 07:13:17 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 12:13:14 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<20171204122859.1a4fcd21.cohuck@redhat.com>
	<1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
	<20171204171124.4d877b22.cohuck@redhat.com>
	<20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
	<20171205074810.GA5859@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 13:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171205074810.GA5859@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd45272e-01c7-a49b-f8cd-b10746da5752@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 12/05/2017 08:48 AM, Dong Jia Shi wrote:
> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-12-05 15:43:00 +0800]:
> 
>> * Cornelia Huck <cohuck@redhat.com> [2017-12-04 17:11:24 +0100]:
>>
>> [...]
>>
>> This one looks good to me too, so:
>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>
> BTW, since we are deprecating s390-squash-mcss, I think any more
> improment on it (e.g. more accurate and helpful hint message) is not
> worthy. So I will not send such pathes in future, if nobody disagrees.
> 

Makes sense to me.

Halil
