Received: from eggs.gnu.org ([2001:4830:134:3::10]:47149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6fy-00082H-Ur
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6fu-0003yB-2l
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6ft-0003xQ-Sc
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:40:05 -0400
Date: Thu, 18 May 2017 00:40:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170518003940-mutt-send-email-mst@kernel.org>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
	<20170515125840.GC1201@stefanha-x1.localdomain>
	<20170515160256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515160256-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 0/9] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Mon, May 15, 2017 at 04:04:33PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 15, 2017 at 01:58:40PM +0100, Stefan Hajnoczi wrote:
> > On Wed, May 10, 2017 at 10:07:58PM +0300, Michael S. Tsirkin wrote:
> > > The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887bb:
> > > 
> > >   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into staging (2017-05-09 15:49:14 -0400)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > > 
> > > for you to fetch changes up to 8b12e48950a3d59188489b2ff6c5ad9cc09e9866:
> > > 
> > >   acpi-defs: clean up open brace usage (2017-05-10 22:04:23 +0300)
> > > 
> > > ----------------------------------------------------------------
> > > pci, virtio, vhost: fixes
> > > 
> > > A bunch of fixes that missed the release.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Please resend with the checkpatch.pl issue fixed.
> 
> 
> There's no issue - new patch followed surrounding code which
> was not refactored to match checkpatch.
> Last patch of the series refactors all of that file to match.
> 
> We do not need to worry abut bisect for checkpatch issues IMHO.

Ping - is this going to get merged? I'm preparing the next pull request
meanwhile ...

> -- 
> MST
