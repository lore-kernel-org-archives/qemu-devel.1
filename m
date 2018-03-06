Received: from eggs.gnu.org ([2001:4830:134:3::10]:45824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etAGC-0007Zy-5e
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etAGB-0000D9-1n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:55:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etAGA-0000Cw-Te
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:55:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B90984222
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 10:55:54 +0000 (UTC)
Date: Tue, 6 Mar 2018 18:55:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306105549.GC17720@xz-mi>
References: <20180305064324.9238-1-peterx@redhat.com>
	<20180306102947.GE6163@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306102947.GE6163@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] qio: general non-default
 GMainContext support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Mar 06, 2018 at 10:29:47AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 05, 2018 at 02:43:18PM +0800, Peter Xu wrote:
> > V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.=
html
> > V2: http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00016.htm=
l
> >=20
> > From this version, I'll split the old series into two: one QIO series
> > and one CHARDEV series.  This is the QIO part.
> >=20
> > Hopefully I have addressed every comments in v2.  Please shoot if I
> > missed any of them.  Thanks,
>=20
> Thanks, I'm queuing this series and will send a pull req for it
> assuming it passes the usual tests.

That'll be great.  Thanks, Dan.

--=20
Peter Xu
