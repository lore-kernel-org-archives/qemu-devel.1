Received: from eggs.gnu.org ([2001:4830:134:3::10]:56144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHKnH-0004hk-SB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHKnD-0002JZ-M0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:34:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gHKnD-0002Gy-F4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4CCD58E33
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 03:34:04 +0000 (UTC)
Date: Tue, 30 Oct 2018 11:33:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181030033342.GB22523@xz-x1>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029125733.14597-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] monitor: inline ambiguous helper
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 29, 2018 at 04:57:28PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> The function were not named with "mon_iothread", or following the AIO
> vs GMainContext distinction. Inline them instead.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu
