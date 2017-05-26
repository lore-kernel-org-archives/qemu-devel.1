Received: from eggs.gnu.org ([2001:4830:134:3::10]:48657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6pj-0000fz-Nk
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6pe-0002J3-QC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6pe-0002Ip-J7
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:26:34 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<20170519153329.GA30573@stefanha-x1.localdomain>
	<ec3c391c-6f0a-b316-e7d9-8f5e431b5e45@redhat.com>
	<286AC319A985734F985F78AFA26841F7392351DD@shsmsx102.ccr.corp.intel.com>
	<7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
	<5923CCF2.2000001@intel.com>
	<3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
	<5924136A.4090004@intel.com>
	<7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
	<592544D9.5010100@intel.com>
	<23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
	<5926C7AC.4080603@intel.com>
	<6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
	<aa5366b4-d67f-ffb3-b1f1-7d7799d51dea@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c747cdf-6bd9-bf2a-117d-2620c2625abc@redhat.com>
Date: Fri, 26 May 2017 12:26:25 +0800
MIME-Version: 1.0
In-Reply-To: <aa5366b4-d67f-ffb3-b1f1-7d7799d51dea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 22:35, Eric Blake wrote:
> [meta-comment]
>
> On 05/25/2017 07:22 AM, Jason Wang wrote:
> [snip]
>
>>>>>>>>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang =
wrote:
>>>>>>>>>>>>>>>>>>> Hi:
> 17 levels of '>' when I add my reply.  Wow.
>
>>> I think that's another direction or future extension.
>>> We already have the vhost-pci to virtio-net model on the way, so I
>>> think it would be better to start from here.
>>>
>> If vhost-pci to vhost-pci is obvious superior, why not try this consid=
er
>> we're at rather early stage for vhost-pci?
>>
> I have to scroll a couple of screens past heavily-quoted material befor=
e
> getting to the start of the additions to the thread.  It's not only
> okay, but recommended, to trim your replies down to relevant context so
> that it is easier to get to your additions (3 or 4 levels of quoted
> material can still be relevant, but 17 levels is usually a sign that yo=
u
> are including too much).  Readers coming in mid-thread can still refer
> to the public archives if they want more context.
>

Ok, will do.

Thanks
