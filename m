Received: from eggs.gnu.org ([2001:4830:134:3::10]:35765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1decBS-000224-0i
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1decBO-0004cm-Rg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1decBO-0004Zq-Kr
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:10:34 -0400
References: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
	<20170807070622.yenthqql6rgdhm77@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5871a85b-4d73-78f2-1aad-45e978ef6051@redhat.com>
Date: Mon, 7 Aug 2017 09:10:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170807070622.yenthqql6rgdhm77@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Do we need a "virt-2.10" machine type before the
 2.10 release?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Drew,
On 07/08/2017 09:06, Andrew Jones wrote:
> On Fri, Aug 04, 2017 at 06:42:54PM +0100, Peter Maydell wrote:
>> Hi; I noticed today that the virt board doesn't have a virt-2.10
>> machine type defined. Do we need to add it before release?
>>
>> (I don't know if there have in fact been any changes between
>> 2.9 and 2.10 that would be compatibility issues.)
>>
>> thanks
>> -- PMM
>>
> 
> Yes, we should have separately posted that to make sure it
> got in. Eric posted it, but as part of an RFC series:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00045.html
> 
> Eric, would you like to post a separate patch for the 2.10
> machine type that doesn't include no_iommu?

Yes I can send it. However is it really mandated as I don't think we
have changes between 2.9 and 2.10?

Thanks

Eric
> 
> Thanks,
> drew
> 
