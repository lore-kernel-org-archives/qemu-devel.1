Received: from eggs.gnu.org ([2001:4830:134:3::10]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cyDF6-0007TI-Qi
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cyDF2-00064n-Tp
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:03:08 -0400
Message-ID: <1491984175.4099.9.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 12 Apr 2017 10:02:55 +0200
In-Reply-To: <ab9d8d7b-da49-1bc6-dfd8-545cae19cf90@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-22-git-send-email-clg@kaod.org>
	<1491909013.4099.4.camel@redhat.com>
	<ab9d8d7b-da49-1bc6-dfd8-545cae19cf90@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 21/21] ppc/pnv: Create a default
 PCI layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Tue, 2017-04-11 at 18:50 +0200, C=C3=A9dric Le Goater wrote:
> > These bridges and devices are not added when -nodefaults
> > is in use, right?
>=C2=A0
> I haven't checked that yet but I will.

Thanks. This is very important for libvirt, where we need
to have full control of the guest's hardware.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
