Received: from eggs.gnu.org ([2001:4830:134:3::10]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpDU6-0000nb-KY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpDTx-0008AQ-DC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpDTx-00089d-5m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:01:33 -0400
Date: Tue, 5 Sep 2017 14:01:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170905130112.GD2112@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
	<20170830155528-mutt-send-email-mst@kernel.org>
	<2139507594.6080508.1504098836285.JavaMail.zimbra@redhat.com>
	<20170905125853.GC2112@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170905125853.GC2112@work-vm>
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

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Hi
> >=20
> > ----- Original Message -----
> > > > Subject: Re: [RFC v2 01/32] vhu: vu_queue_started
> > >=20
> > > I mean, how did we end up with "vhu"? I never meant that to happen =
:(
> > > It's merely in the commit title but maybe we can come up with a
> > > better-sounding way to abbreviate vhost user.
> >=20
> > vhu, no idea :)
> >=20
> > I would suggest to use libvhost-user: prefix in commit messages for c=
ontrib/libvhost-user changes.
> >=20
> > vhost-user: for qemu vhost-user changes.
>=20
> Changed to vhost-user.

oops, I mean changed to libvhost-user for this one.

Dave

> Dave
>=20
> > vhost-user-bridge: (or vub:), vhost-user-scsi: (or vus:)  for those b=
ackends.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
