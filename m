Received: from eggs.gnu.org ([2001:4830:134:3::10]:58027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUZ5S-0006g8-KV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUZ5L-0008WM-Np
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:27:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43414
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gUZ5L-0008VN-7y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:27:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5FPiIs065519
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 10:27:34 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p6fqcwcjj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 10:27:33 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 5 Dec 2018 15:27:33 -0000
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<76a5ccbc-69db-7876-478e-fba565b3a126@de.ibm.com>
	<cdc9ce9e-18fb-5152-ba7d-33326d46a05d@linux.ibm.com>
	<20181205162221.5f537ce7.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 5 Dec 2018 10:27:28 -0500
MIME-Version: 1.0
In-Reply-To: <20181205162221.5f537ce7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd18eebb-93be-2b08-0f0e-4a00c19ea388@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390: guest support for
 diagnose 318 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, mimu@linux.ibm.com

On 12/5/18 10:22 AM, Cornelia Huck wrote:
> On Wed, 5 Dec 2018 09:59:54 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 12/5/18 3:29 AM, Christian Borntraeger wrote:
>>> You should clearly review your email list.....
>>>
>>> Adding the "new" Conny, removing Carsten.
>>>   
>>
>> Thanks for taking care of that. I'll be more careful when using the
>> addresses at the top of the files. 
> 
> scripts/get_maintainer.pl -f <file> is probably more useful to get
> current addresses :)
> 

I'll give it a whirl next time. I appreciate the advice! :)

-- 
Respectfully,
- Collin Walling
