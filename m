Received: from eggs.gnu.org ([2001:4830:134:3::10]:46664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjsat-0006c4-9e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjsap-0003JS-Tp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:10:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjsap-0003Ib-N1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:10:19 -0500
Date: Fri, 3 Mar 2017 21:10:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170303210947-mutt-send-email-mst@kernel.org>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<CAFEAcA9CBuoswsNT5DX=rhJTRj-NKJpO5yyvEDpiuMwSRymyYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9CBuoswsNT5DX=rhJTRj-NKJpO5yyvEDpiuMwSRymyYA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/15] virtio, pc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 03, 2017 at 12:44:59PM +0000, Peter Maydell wrote:
> On 2 March 2017 at 06:20, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  dtc                                  |   2 +-
> 
> I just noticed this erroneous submodule update in here, unfortunately
> after I pushed it to master :-(
> 
> I'll fix up the tree...
> 
> thanks
> -- PMM

Ouch. submodules are a pain :(
Let me know if you need me to rebase. Sorry.

-- 
MST
