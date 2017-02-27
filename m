Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ciJcW-0004Sf-9z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ciJcS-0005Ys-9Z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:37:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1ciJcS-0005Xl-3p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:37:32 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B4A07AEAA
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:37:31 +0000 (UTC)
Received: from ovpn-204-136.brq.redhat.com (ovpn-204-136.brq.redhat.com
	[10.40.204.136])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RBbTGe019451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:37:30 -0500
Message-ID: <1488195448.4244.24.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 27 Feb 2017 12:37:28 +0100
In-Reply-To: <1487326479-8664-1-git-send-email-abologna@redhat.com>
References: <1487326479-8664-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/2] docs: Improve sample configuration
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Fri, 2017-02-17 at 11:14 +0100, Andrea Bolognani wrote:
[...]
> Andrea Bolognani (2):
>=C2=A0=C2=A0=C2=A0q35: Improve sample configuration files
>=C2=A0=C2=A0=C2=A0mach-virt: Provide sample configuration files
>=C2=A0
>=C2=A0=C2=A0docs/mach-virt-graphical.cfg=C2=A0=C2=A0| 281 ++++++++++++++=
+++++++++++++++++++++++++++
>=C2=A0=C2=A0docs/mach-virt-serial.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 243=
 +++++++++++++++++++++++++++++++++++
>=C2=A0=C2=A0docs/q35-chipset.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| 152 ----------------------
>=C2=A0=C2=A0docs/q35-emulated.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 288 ++++++++++++++++++++++++++++++++++++++++++
>=C2=A0=C2=A0docs/q35-virtio-graphical.cfg | 248 ++++++++++++++++++++++++=
++++++++++++
>=C2=A0=C2=A0docs/q35-virtio-serial.cfg=C2=A0=C2=A0=C2=A0=C2=A0| 193 ++++=
++++++++++++++++++++++++
>=C2=A0=C2=A06 files changed, 1253 insertions(+), 152 deletions(-)
>=C2=A0=C2=A0create mode 100644 docs/mach-virt-graphical.cfg
>=C2=A0=C2=A0create mode 100644 docs/mach-virt-serial.cfg
>=C2=A0=C2=A0delete mode 100644 docs/q35-chipset.cfg
>=C2=A0=C2=A0create mode 100644 docs/q35-emulated.cfg
>=C2=A0=C2=A0create mode 100644 docs/q35-virtio-graphical.cfg
>=C2=A0=C2=A0create mode 100644 docs/q35-virtio-serial.cfg

Ping?

The series is fully ACKed as of two weeks ago, and it would
be great if someone could pick it up.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
