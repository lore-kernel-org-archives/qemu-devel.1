Received: from eggs.gnu.org ([2001:4830:134:3::10]:39442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e40on-0000tG-Tb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e40oj-0001DZ-1P
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:32:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1e40oi-0001Cf-Qy
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:32:08 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <19805e21-dbe3-e78d-4dd8-c769b47081ad@samsung.com>
Date: Mon, 16 Oct 2017 11:32:00 +0300
MIME-version: 1.0
In-reply-to: <dbf7014f-826b-5f2f-5933-acb679a16e35@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <CGME20170824192750epcas5p484df9724ca7c0a259a4dd85425a69e1d@epcas5p4.samsung.com>
	<20170824192730.8440-1-dgilbert@redhat.com>
	<ad360122-de03-39a8-21a8-d8968e885875@samsung.com>
	<dbf7014f-826b-5f2f-5933-acb679a16e35@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 00/32] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "Dr. David Alan Gilbert
	(git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

Hello Maxime

On 09/01/2017 04:42 PM, Maxime Coquelin wrote:
> Hello Alexey,
>
> On 09/01/2017 03:34 PM, Alexey Perevalov wrote:
>> Hello David,
>>
>> You wrote in previous version:
>>
>>> We've had a postcopy migrate work now, with a few hacks we're still
>>> cleaning up, both on vhost-user-bridge and dpdk; so I'll get this
>>> updated and reposted.
>>
>> I want to know more about DPDK work, do you know, is somebody 
>> assigned to that task?
>
> I did the DPDK (rough) prototype, you may find it here:
> https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/postcopy_proto_v1

I found it is for previous version of the patchset. Do you have any updates?
>
> Cheers,
> Maxime
>
>
>

-- 
Best regards,
Alexey Perevalov
