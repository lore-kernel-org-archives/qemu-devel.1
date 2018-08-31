Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fvXN6-0005JX-Qt
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fvXA3-0008D7-Sv
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:19:44 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:38085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fvXA3-0008CN-ND
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:19:39 -0400
Received: by mail-oi0-x22d.google.com with SMTP id x197-v6so18766037oix.5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 17:19:39 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87wos80wbs.fsf@dusky.pond.sub.org>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<87wos80wbs.fsf@dusky.pond.sub.org>
Message-ID: <153567477173.13636.8142918704968848246@sif>
Date: Thu, 30 Aug 2018 19:19:31 -0500
Subject: Re: [Qemu-devel] [PATCH v4 00/10] monitor: various code
 simplification and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Quoting Markus Armbruster (2018-08-30 09:21:11)
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> =

> > Hi,
> >
> > This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
> > asynchronous command type".
> =

> PATCH 01-04 are core monitor work Peter will need to make progress.
> Queued.
> http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/monitor-next
> =

> PATCH 05 I'd like you to keep in your qmp-async series.
> =

> PATCH 06-07 could use a bit of work.
> =

> PATCH 08-10 are related to QGA.  Michael, would you like me to handle
> them?

That's fine by me, can take them through my tree too if you'd prefer,
just let me know.
