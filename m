Received: from eggs.gnu.org ([2001:4830:134:3::10]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpDRg-00082l-6g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpDRb-0006XD-MC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpDRb-0006WR-Fu
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:59:07 -0400
Date: Tue, 5 Sep 2017 13:58:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170905125853.GC2112@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
	<20170830155528-mutt-send-email-mst@kernel.org>
	<2139507594.6080508.1504098836285.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2139507594.6080508.1504098836285.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, maxime coquelin <maxime.coquelin@redhat.com>, a perevalov <a.perevalov@samsung.com>, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> ----- Original Message -----
> > > Subject: Re: [RFC v2 01/32] vhu: vu_queue_started
> >=20
> > I mean, how did we end up with "vhu"? I never meant that to happen :(
> > It's merely in the commit title but maybe we can come up with a
> > better-sounding way to abbreviate vhost user.
>=20
> vhu, no idea :)
>=20
> I would suggest to use libvhost-user: prefix in commit messages for con=
trib/libvhost-user changes.
>=20
> vhost-user: for qemu vhost-user changes.

Changed to vhost-user.

Dave

> vhost-user-bridge: (or vub:), vhost-user-scsi: (or vus:)  for those bac=
kends.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
