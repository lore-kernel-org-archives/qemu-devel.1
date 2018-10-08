Received: from eggs.gnu.org ([2001:4830:134:3::10]:40424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pawelx.wodkowski@intel.com>) id 1g9PjA-0004km-GT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pawelx.wodkowski@intel.com>) id 1g9Pj6-0002on-DF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:13:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:3407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pawelx.wodkowski@intel.com>)
	id 1g9Pj5-0002lp-7P
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:13:12 -0400
From: "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
Date: Mon, 8 Oct 2018 07:13:00 +0000
Message-ID: <F6F2A6264E145F47A18AB6DF8E87425D7035EF1E@IRSMSX102.ger.corp.intel.com>
References: <DB7PR07MB3867468812F702134BC2BCAC98E40@DB7PR07MB3867.eurprd07.prod.outlook.com>
In-Reply-To: <DB7PR07MB3867468812F702134BC2BCAC98E40@DB7PR07MB3867.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] vhost: add virtio-vhost-user transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Storage Performance Development Kit <spdk@lists.01.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Great to hear that.

To get these patches merged you need to prepare a patch(es)
and send them for review first. See https://spdk.io/development/ for=20
information how to do that.

Pawel

> -----Original Message-----
> From: SPDK [mailto:spdk-bounces@lists.01.org] On Behalf Of Nikos Dragazis
> Sent: Saturday, October 6, 2018 10:03 PM
> To: spdk@lists.01.org
> Cc: qemu-devel@nongnu.org; Stefan Hajnoczi <stefanha@redhat.com>
> Subject: [SPDK] vhost: add virtio-vhost-user transport
>=20
> Hi everyone,
>=20
> In response to a previous email of mine here:
>=20
> https://lists.01.org/pipermail/spdk/2018-September/002488.html
>=20
> I would like to share that I have added support for a new
> virtio-vhost-user transport to SPDK. and have a working demo of the SPDK
> vhost-scsi target over this transport. I have tested it successfully
> with Malloc bdev, NVMe bdev and virtio-scsi bdev.
>=20
> My code currently lives here:
>=20
> https://github.com/ndragazis/spdk
>=20
> I'd love to get your feedback and have it merged eventually. I see there
> is a relevant conversation on this topic here:
>=20
> https://lists.01.org/pipermail/spdk/2018-March/001557.html
>=20
> Is there anyone in this community currently working on this? What would
> my next step in contributing this be?
>=20
> Looking forward to your feedback,
> Nikos
>=20
> --
> Nikos Dragazis
> Undergraduate Student
> School of Electrical and Computer Engineering
> National Technical University of Athens
>=20
> _______________________________________________
> SPDK mailing list
> SPDK@lists.01.org
> https://lists.01.org/mailman/listinfo/spdk
