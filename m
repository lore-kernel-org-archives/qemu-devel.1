Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLC8Y-0005u2-On
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLC8T-0003bK-O3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLC8T-0003ah-Hv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:35:49 -0400
Date: Tue, 22 May 2018 11:35:48 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA-Fm3v-kJdRuj1zijXi1G4Qydw3H0BkOZg95agdCdCqOw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1805221134320.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
	<CAFEAcA-Fm3v-kJdRuj1zijXi1G4Qydw3H0BkOZg95agdCdCqOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PULL 00/15] xen-20180521-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 22 May 2018, Peter Maydell wrote:
> On 21 May 2018 at 20:34, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > The following changes since commit d32e41a1188e929cc0fb16829ce3736046951e39:
> >
> >   Merge remote-tracking branch 'remotes/famz/tags/docker-and-block-pull-request' into staging (2018-05-18 14:11:52 +0100)
> >
> > are available in the git repository at:
> >
> >
> >   http://xenbits.xenproject.org/git-http/people/sstabellini/qemu-dm.git tags/xen-20180521-tag
> >
> > for you to fetch changes up to f03df99f09ee0ca27ea2298a1b77438e7999044d:
> >
> >   xen_disk: be consistent with use of xendev and blkdev->xendev (2018-05-18 11:13:01 -0700)
> >
> > ----------------------------------------------------------------
> > Xen 2018/05/21
> >
> 
> Hi Stefano -- my scripts can't find this tag. Did you forget to push
> it, perhaps?

Yes, I did. I'll take the opportunity to resend the whole series given
that there is a small mistake on patch #6.
