Received: from eggs.gnu.org ([2001:4830:134:3::10]:36065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1decCw-0002eT-RU
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1decCt-0005fT-N7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1decCt-0005eg-GP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 03:12:07 -0400
Date: Mon, 7 Aug 2017 09:06:22 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170807070622.yenthqql6rgdhm77@kamzik.brq.redhat.com>
References: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eric.auger@redhat.com

On Fri, Aug 04, 2017 at 06:42:54PM +0100, Peter Maydell wrote:
> Hi; I noticed today that the virt board doesn't have a virt-2.10
> machine type defined. Do we need to add it before release?
> 
> (I don't know if there have in fact been any changes between
> 2.9 and 2.10 that would be compatibility issues.)
> 
> thanks
> -- PMM
>

Yes, we should have separately posted that to make sure it
got in. Eric posted it, but as part of an RFC series:

 https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00045.html

Eric, would you like to post a separate patch for the 2.10
machine type that doesn't include no_iommu?

Thanks,
drew
