Received: from eggs.gnu.org ([2001:4830:134:3::10]:53855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJj5T-0000ER-Oj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJj5Q-00046s-1e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJj5P-00045d-LO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:51 -0500
Date: Mon, 5 Nov 2018 12:54:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105125442-mutt-send-email-mst@kernel.org>
References: <20181025005110.249256-1-mst@redhat.com>
	<CAFEAcA9dj37Fw1E8HAy+wFX78J2bw7rQyM7+9ACUVpkJmyWXDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9dj37Fw1E8HAy+wFX78J2bw7rQyM7+9ACUVpkJmyWXDQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/28] pci, pc, virtio: fixes, features
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

On Mon, Nov 05, 2018 at 03:05:27PM +0000, Peter Maydell wrote:
> On 25 October 2018 at 01:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 6a9fb4e1ba5594cde7739068617ad88e6117db93:
> >
> >   vhost-scsi: prevent using uninitialized vqs (2018-10-24 20:50:13 -0400)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> >
> > AMD IOMMU VAPIC support + fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> Hi Michael -- just a reminder that you need to submit a respin
> of this by 1200 UTC tomorrow (with my symlink-of-data-files
> patchset) if you want it to get into rc0.
> 
> thanks
> -- PMM

Working on it.
