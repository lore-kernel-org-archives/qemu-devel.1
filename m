Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7XP-0002Sa-Ij
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7XL-0002jB-EA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl7XL-0002ie-7Y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:52:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-2-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 07:52:02 +0200
In-Reply-To: <20170824103350.16400-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:37 +0200")
Message-ID: <87fucg42kd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/14] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> A step towards completeness.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
