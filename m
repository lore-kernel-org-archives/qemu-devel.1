Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVYjG-0008Le-LS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVYjD-0008BK-FO
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:07:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170122145407.27476-1-sw@weilnetz.de>
Date: Mon, 23 Jan 2017 08:07:43 +0100
In-Reply-To: <20170122145407.27476-1-sw@weilnetz.de> (Stefan Weil's message of
	"Sun, 22 Jan 2017 15:54:07 +0100")
Message-ID: <8760l6z22o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi: Remove unwanted commas after
 #optional keyword
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Stefan Weil <sw@weilnetz.de> writes:

> We don't want that commas to be part of the generated documentation,
> so remove them.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> This is an alternative solution for the issue which is also addressed
> by my previous patch http://patchwork.ozlabs.org/patch/718177/.
>
> It's also possible to apply both patches.

I'll take this one.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Applied to qapi-next, thanks!
