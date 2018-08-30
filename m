Received: from eggs.gnu.org ([2001:4830:134:3::10]:56829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNp4-0004GF-Ly
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNoz-0000gi-LT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:21:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvNoz-0000gb-GY
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:21:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 16:21:11 +0200
In-Reply-To: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 29 Aug 2018 15:40:33 +0200")
Message-ID: <87wos80wbs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
> asynchronous command type".

PATCH 01-04 are core monitor work Peter will need to make progress.
Queued.
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/monitor-next

PATCH 05 I'd like you to keep in your qmp-async series.

PATCH 06-07 could use a bit of work.

PATCH 08-10 are related to QGA.  Michael, would you like me to handle
them?
