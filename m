Received: from eggs.gnu.org ([2001:4830:134:3::10]:57707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7ao-0005f7-8K
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7aj-0000gO-Az
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:37:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS7aj-0000fS-5F
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:37:21 -0500
Date: Thu, 21 Dec 2017 22:37:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221223704-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
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

On Thu, Dec 21, 2017 at 08:26:47PM +0000, Peter Maydell wrote:
> On 21 December 2017 at 14:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 2babfe0c9241c239272a03fec785165a50e8288c:
> >
> >   Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 664ed92706ff6e66fa278c3163b5387f11d6daca:
> >
> >   smbus: do not immediately complete commands (2017-12-21 16:24:44 +0200)
> >
> > ----------------------------------------------------------------
> > pc, pci, virtio: features, fixes, cleanups
> >
> > A bunch of fixes, cleanus and new features all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> Conflicts in hw/block/nvme.c -- can you fix and resend, please?
> 
> thanks
> -- PMM

Done and pushed - I dropped the conflicting patch.
