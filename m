Received: from eggs.gnu.org ([2001:4830:134:3::10]:59009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTF2t-0007wy-Nz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 18:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTF2t-0001Jx-0m
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 18:14:47 -0400
Date: Thu, 6 Jul 2017 18:14:39 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <187988967.14536310.1499379279360.JavaMail.zimbra@redhat.com>
In-Reply-To: <1d65316e-ffcf-3eb8-41d4-dc486f4493f3@redhat.com>
References: <20170607063555.7374-1-marcandre.lureau@redhat.com>
	<5c87e2bf-898e-221d-2b96-31147dd85c8a@redhat.com>
	<06dedbe8-6c14-757f-a26e-42be4092e54b@redhat.com>
	<1d65316e-ffcf-3eb8-41d4-dc486f4493f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>


> Drats, backwards compatibility gets me again.
>=20
> I guess it should become a comment in the code that explains why we
> cannot use the lib function for it?

Or take Marc-Andr=C3=A9's patch and copy the (fixed) function into QEMU.

> Tch, just trying to keep backlogged qemu-block patches from falling off
> the radar :)

I totally missed this one, so thank you.

Paolo
