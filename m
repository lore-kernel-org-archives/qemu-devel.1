Received: from eggs.gnu.org ([209.51.188.92]:35567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FII-0002Gk-83
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FIC-0007t9-Hv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:12:08 -0500
Date: Fri, 8 Mar 2019 14:11:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308131151.GA31583@localhost.localdomain>
References: <20190305154634.4609-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190305154634.4609-1-ndevos@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] block: Gluster 6
 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

Am 05.03.2019 um 16:46 hat Niels de Vos geschrieben:
> Gluster 6 is currently available as release candidate. There have been =
a
> few changes to libgfapi.so that need to be adapted by consuming project=
s
> like QEMU. Fedora Rawhide already contains glusterfs-6.0-RC0, and this
> prevents rebuilds of QEMU there (https://bugzilla.redhat.com/1684298).
>=20
> The following two changes should be sufficient to consume Gluster 6 onc=
e
> it is released. These have been tested on CentOS-7 with Gluster 5 and
> Gluster 6 (minimal manual qemu-img tests only).
>=20
> This v2 post contains changes suggested by Daniel P. Berrang=E9 and Kev=
in
> Wolf. Thanks!

Thanks, applied to the block branch.

Kevin
