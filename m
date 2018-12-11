Received: from eggs.gnu.org ([2001:4830:134:3::10]:42431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkCz-0007hj-AK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkCv-0005rg-7f
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:44:29 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:43:52 +0000
Message-ID: <7a3465bbcbd441638ebe1eec7623599c@AMSPEX02CL03.citrite.net>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-8-git-send-email-paul.durrant@citrix.com>
	<20181211152455.GT18875@perard.uk.xensource.com>
In-Reply-To: <20181211152455.GT18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 07/18] xen: add event channel interface
 for XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 11 December 2018 15:25
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org
> Subject: Re: [PATCH v3 07/18] xen: add event channel interface for
> XenDevice-s
>=20
> On Tue, Dec 11, 2018 at 10:47:07AM +0000, Paul Durrant wrote:
> > The legacy PV backend infrastructure provides functions to bind, unbind
> > and send notifications to event channnels. Similar functionality will b=
e
> > required by XenDevice implementations so this patch adds the necessary
> > support.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> When and where did this review happend? I can only find my review-by tag
> on v2, which is missing here.
>=20

Oh, that must have been my mistake... I cut'n'pasted the wrong line. Apolog=
ies to Stefano and yourself... I'll fix it in v4.

  Paul

> --
> Anthony PERARD
