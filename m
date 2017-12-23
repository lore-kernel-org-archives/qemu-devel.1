Received: from eggs.gnu.org ([2001:4830:134:3::10]:59745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSmGD-0004pz-Lc
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSmG9-00049B-Bc
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:02:53 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:40562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eSmG9-00048n-6w
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:02:49 -0500
Received: by mail-it0-x22a.google.com with SMTP id f190so17561104ita.5
	for <qemu-devel@nongnu.org>; Sat, 23 Dec 2017 08:02:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.14303.1514042036.27991.qemu-devel@nongnu.org>
Date: Sat, 23 Dec 2017 11:02:46 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2037710-4C0C-4641-BECF-A405520843F0@gmail.com>
References: <mailman.14303.1514042036.27991.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PULL v4 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On Dec 23, 2017, at 10:13 AM, qemu-devel-request@nongnu.org wrote:
>=20
> The following changes since commit =
43ab9a5376c95c61ae898a222c4d04bdf60e239b:
>=20
>  hw/i386/vmport: fix missing definitions with non-log trace backends =
(2017-12-21 22:52:28 +0000)
>=20
> are available in the Git repository at:
>=20
>  git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>=20
> for you to fetch changes up to =
895f9fdf3ac5481ca5ad5763bf667cbf82aa52c4:
>=20
>  i386: hvf: cleanup x86_gen.h (2017-12-22 15:02:07 +0100)
>=20
> ----------------------------------------------------------------
> Initial support for the HVF accelerator

I was able to build and use this patch set. The one issue I noticed was =
the high CPU usage on the guest. Watching the same youtube video using =
VirtualBox sees significantly less CPU usage. This issue could probably =
be fixed in a future patch. Other than that I think these patches are =
ready.
