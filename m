Received: from eggs.gnu.org ([2001:4830:134:3::10]:50720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2uz-0000P6-6H
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2uv-0000wx-9o
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb2uv-0000vH-4Y
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-13-marcandre.lureau@redhat.com>
Date: Thu, 05 Jul 2018 13:59:15 +0200
In-Reply-To: <20180326150916.9602-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 26 Mar 2018 17:08:50 +0200")
Message-ID: <8736wx99m4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/38] tests: add a qmp success-response
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Verify the usage of this schema feature and the API behaviour.  This
> should be the only case where qmp_dispatch() returns NULL without
> error.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Needs a rebase.  Looks good otherwise.
