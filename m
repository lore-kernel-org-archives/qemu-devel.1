Received: from eggs.gnu.org ([2001:4830:134:3::10]:45765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVhBJ-000395-Ce
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVhBG-0004VV-8A
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:41:37 -0400
Date: Thu, 13 Jul 2017 13:41:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170713164128.GY6020@localhost.localdomain>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-27-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170713163219.9024-27-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/29] i386: introduce ELF_NOTE_SIZE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jul 13, 2017 at 06:32:16PM +0200, Marc-Andr=E9 Lureau wrote:
> Factour out a common pattern to compute the ELF note size.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
