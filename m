Received: from eggs.gnu.org ([2001:4830:134:3::10]:36358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fq7RU-0001YN-T6
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fq7RP-0005U0-UX
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:51:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fq7RO-0005TZ-LG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:51:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B46B40241FB
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 01:51:09 +0000 (UTC)
Date: Thu, 16 Aug 2018 09:51:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180816013836.GD2708@xz-mi>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-12-peterx@redhat.com>
	<CAMxuvayJAG9GOfhQMYEerOBcq5tGG=GNtyS+LBNCzGJzkGjT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayJAG9GOfhQMYEerOBcq5tGG=GNtyS+LBNCzGJzkGjT0Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/13] tests: remove "0.15" prefix for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 15, 2018 at 08:11:22PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Aug 15, 2018 at 3:37 PM, Peter Xu <peterx@redhat.com> wrote:
> > The "0.15" prefix seems useless.  Remove them.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> I sent a similar patch long ago, and it is finally queued by Markus!
> :) "tests: change /0.15/* tests to /qmp/*"

Oh! I guess I rebased to a not-the-latest master tree due to some
unknown reason...

Thanks for mentioning.  I'll drop this patch in my next post (and I'll
also modify the next patch to match the names).

Regards,

--=20
Peter Xu
