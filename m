Received: from eggs.gnu.org ([2001:4830:134:3::10]:41597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGnR-0000Qw-N6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGnO-0003X5-GQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dJGnO-0003Ww-Ak
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:05:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D6AF4E884
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 10:05:33 +0000 (UTC)
Date: Fri, 9 Jun 2017 06:05:33 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1496525659.32019561.1497002733173.JavaMail.zimbra@redhat.com>
In-Reply-To: <87o9ty1je6.fsf@dusky.pond.sub.org>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-43-marcandre.lureau@redhat.com>
	<87o9ty1je6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 42/43] RFC: qdict: add uint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Similar to int support, add uint support.
> >
> > Note this is RFC because this is currently unused in qemu, I haven't
> > found a good user for it yet (kaslr qemu-ga code did use it though).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> We need to make up our mind whether to store this in the tree or on the
> mailing list.
>=20

Let's keep it on the ML for now.
