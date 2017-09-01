Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dnmEE-000285-Gq
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dnmE9-0000tv-R0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dnmE9-0000rv-Ki
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:43:17 -0400
References: <CGME20170824192750epcas5p484df9724ca7c0a259a4dd85425a69e1d@epcas5p4.samsung.com>
	<20170824192730.8440-1-dgilbert@redhat.com>
	<ad360122-de03-39a8-21a8-d8968e885875@samsung.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <dbf7014f-826b-5f2f-5933-acb679a16e35@redhat.com>
Date: Fri, 1 Sep 2017 15:42:56 +0200
MIME-Version: 1.0
In-Reply-To: <ad360122-de03-39a8-21a8-d8968e885875@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 00/32] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

Hello Alexey,

On 09/01/2017 03:34 PM, Alexey Perevalov wrote:
> Hello David,
> 
> You wrote in previous version:
> 
>> We've had a postcopy migrate work now, with a few hacks we're still
>> cleaning up, both on vhost-user-bridge and dpdk; so I'll get this
>> updated and reposted.
> 
> I want to know more about DPDK work, do you know, is somebody assigned 
> to that task?

I did the DPDK (rough) prototype, you may find it here:
https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/postcopy_proto_v1

Cheers,
Maxime
