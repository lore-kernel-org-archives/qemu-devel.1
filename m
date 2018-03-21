Received: from eggs.gnu.org ([2001:4830:134:3::10]:45668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eydk8-0004qv-3h
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eydk4-0006gf-JO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:25:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41906
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eydk4-0006gA-C6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:25:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LDOYU4103907
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:25:23 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gup8mwbgp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:25:23 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 07:25:22 -0600
References: <20180321120853.14293-1-lvivier@redhat.com>
	<5193a40a-33fb-5b55-5fea-608a5573980e@linux.vnet.ibm.com>
	<7e3215e0-aa21-e2ae-7d07-c07ef66360fe@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 10:25:16 -0300
MIME-Version: 1.0
In-Reply-To: <7e3215e0-aa21-e2ae-7d07-c07ef66360fe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <08e6029e-98e7-290f-6443-5ad3caca15c0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] dump: display cause of write failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>



On 03/21/2018 10:22 AM, Laurent Vivier wrote:
> On 21/03/2018 14:16, Daniel Henrique Barboza wrote:
>> Laurent,
>>
>> There is already a v3 version of Yasmin's patch that was approved and
>> it is supposedly waiting to be merged:
>>
>> http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03035.html
> Ok, sorry, I've missed it because the subject line changed between v2
> and v3.

True. I've changed the subject because the patch was doing a little more
than what was being said in the subject. Mea culpa.


Daniel

>
> Thanks,
> Laurent
>
