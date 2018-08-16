Received: from eggs.gnu.org ([2001:4830:134:3::10]:59946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqCa4-0002TS-AG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqCa2-0006lQ-Aa
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqCa1-0006ie-2g
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:20:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47A2031524FB
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:20:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-12-peterx@redhat.com>
	<CAMxuvayJAG9GOfhQMYEerOBcq5tGG=GNtyS+LBNCzGJzkGjT0Q@mail.gmail.com>
	<20180816013836.GD2708@xz-mi>
Date: Thu, 16 Aug 2018 09:20:15 +0200
In-Reply-To: <20180816013836.GD2708@xz-mi> (Peter Xu's message of "Thu, 16 Aug
	2018 09:51:00 +0800")
Message-ID: <87lg96eq1c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, Aug 15, 2018 at 08:11:22PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> On Wed, Aug 15, 2018 at 3:37 PM, Peter Xu <peterx@redhat.com> wrote:
>> > The "0.15" prefix seems useless.  Remove them.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>=20
>> I sent a similar patch long ago, and it is finally queued by Markus!
>> :) "tests: change /0.15/* tests to /qmp/*"
>
> Oh! I guess I rebased to a not-the-latest master tree due to some
> unknown reason...

I think you simply sent your patch before my pull request went through.

> Thanks for mentioning.  I'll drop this patch in my next post (and I'll
> also modify the next patch to match the names).

Thanks!
