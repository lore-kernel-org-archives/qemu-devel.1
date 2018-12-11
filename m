Received: from eggs.gnu.org ([2001:4830:134:3::10]:56668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWh1k-0002xi-8D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWh1f-0007kx-6s
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:20:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWh1f-0007kL-05
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:20:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-21-marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 13:20:29 +0100
In-Reply-To: <20181208111606.8505-21-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:59 +0400")
Message-ID: <87zhtcqmpe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 20/27] tests/qapi: add command
 with condition on alternate argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> For completeness.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Let's say "Forgotten in commit 967c885108f."

We could squash PATCH 18 and this one together.  In case we don't:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
