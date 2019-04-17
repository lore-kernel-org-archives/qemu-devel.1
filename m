Received: from eggs.gnu.org ([209.51.188.92]:44437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqga-0003Y4-ET
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqgZ-0001fl-KG
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:57:36 -0400
Message-ID: <4a81259e6f47263942baa514de02d114e119c69f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Wed, 17 Apr 2019 22:57:29 +0300
In-Reply-To: <c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Few fixes for userspace
 NVME driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 2019-04-16 at 15:50 +0200, Paolo Bonzini wrote:
> On 15/04/19 15:57, Maxim Levitsky wrote:
> > 
> > 
> > Hi!
> > These are few assorted fixes and features for the userspace
> > nvme driver.
> > 
> > Tested that on my laptop with my Samsung X5 thunderbolt drive, which
> > happens to have 4K sectors, support for discard and write zeros.
> > 
> > Also bunch of fixes sitting in my queue from the period when I developed
> > the nvme-mdev driver.
> > 
> > Best regards,
> > 	Maxim Levitsky
> 
> I only pointed out just two cosmetic changes.  Thanks very much!
> 
> Paolo
> 
Hi Paolo!
Thank you very much!

I have just resent V2 of the series with the fixes.

Best regards,
	Maxim Levitsky
