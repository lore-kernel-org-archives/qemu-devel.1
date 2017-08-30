Received: from eggs.gnu.org ([2001:4830:134:3::10]:40849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnANY-00075s-0q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnANX-0003XS-6e
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnANW-0003XG-Vy
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:18:27 -0400
Date: Wed, 30 Aug 2017 18:18:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170830211818.GB17184@localhost.localdomain>
References: <20170818142613.32394-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170818142613.32394-1-ldoktor@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

On Fri, Aug 18, 2017 at 04:26:03PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Hello guys,
>=20
> I'm reading the available python modules to exercise qemu and while rea=
ding them
> I fixed some issues that caught my attention. It usually starts with a =
simple
> pylint/docstring fixes and slowly graduates to more controversial ones =
so I'm
> open to suggestion to remove some of them.
>=20
> Kind regards,
> Luk=C3=A1=C5=A1

I'm queueing this series on a python-next branch at:

  https://github.com/ehabkost/qemu.git python-next

--=20
Eduardo
