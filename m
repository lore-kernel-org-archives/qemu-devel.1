Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6eIE-0001Nj-6o
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6eIA-0003JQ-U3
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:33:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52387
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6eIA-0003Iv-Nw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:33:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45ETLeO117954
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 10:33:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8q5rcfe6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 10:33:08 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 15:33:06 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263FC5@DGGEMA505-MBX.china.huawei.com>
	<9c1c994a-f8ba-1182-8806-d04d44723c1e@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA264BF8@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 16:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA264BF8@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <deb3c5f2-e4d5-1479-8a3c-2c52a1f263a9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v18 1/2] virtio-crypto:
 Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, Linqiangmin <linqiangmin@huawei.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>



On 05/05/2017 07:56 AM, Gonglei (Arei) wrote:
>>
>>
>> On 05/04/2017 03:53 PM, Gonglei (Arei) wrote:
>>> Sorry, I missed one comment in the previous reply.
>>>
>>>>
>>>>> +\end{itemize*}
>>>>> +
>>>>
>>>> What about extensibility regarding "detailed algorithms"? Is the driver
>>>> required ignore algorithms
>>>> it does not "know about"? Should we reserve the not (yet) defined bits?
>>>>
>>> I mean the device MUST set the algorithms mask bits based on supported
>>> algorithms by the device, and the driver read them to get the capacity.
>>> I don't think we should care about the not defined bits.
>>
>> Let us assume that the driver fails if it encounters an unknown bit
>> (i.e. bit 13 set in hash_algo). I do not think there is anything in
>> this document that prohibits the driver doing so -- if there is please
>> do tell. Now at some point we want to support a new hash algorithm.
>> If we can't be sure that existing drivers are going to play along with
>> defining new bits (which are 'not defined bits' using your words for
>> the existing drivers) we have a small problem.
>>
>> Was I clear about my concern?
>>
> Sorry, I'm confused. For the device, it just set the bit mask based on
> supported algorithms. Please see cryptodev_builtin_init() 
> in cryptodev-builtin.c, the current device only support AES_CBC algorithm,
> so we just need set:
>  backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
>  backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
> 
> Then the driver can only register AES CBC algorithm to the LKCF. Other
> algorithms are not supported no matter the driver if register them or not.
> 
> Thanks,
> -Gonglei
> 

Now I'm confused too. So let's try to clear things up with two simple
question:

1) Is a device allowed to so set not defined bits ( garbage values or
even worse an implementation specific usage) way (e.g. bit 13 for
hash_algo)?

2) Is a driver allowed to rejects unknown algorithm bits (e.g. give up on
the device because it considers it broken)?

If the answer is 'no' please point me to the appropriate conformance
statements.

Question 1) is about why should we reserve the remaining
bits for future use.

Question 2) is about the interaction with feature bits -- if the answer
is 'yes' then we have to guard new algorithms with feature bits.

Halil
