Received: from eggs.gnu.org ([209.51.188.92]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvbN9-0005Gv-W4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 00:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvbN9-0001EM-AF
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 00:21:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:34676)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gvbN9-000186-2X
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 00:21:43 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>	<002301d4c207$27d88d50$7789a7f0$@ru>	<87y36lpjfa.fsf@dusky.pond.sub.org>	<a44a588734f7101b8a9e1f76c1044e41@ispras.ru>
	<87mun1nz3x.fsf@dusky.pond.sub.org>
In-Reply-To: <87mun1nz3x.fsf@dusky.pond.sub.org>
Date: Mon, 18 Feb 2019 08:21:30 +0300
Message-ID: <000c01d4c749$ce3bc2b0$6ab34810$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v12 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> dovgaluk <dovgaluk@ispras.ru> writes:
>=20
> > Markus Armbruster =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-02-12 10:14:
> >> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:
> >>
> >>> Ping?
> >>
> >> Are you pinging for more review, or for someone to merge this?
> >
> > From my point of view this patch set is ready.
>=20
> MAINTAINERS
>=20
>     Record/replay
>     M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>     R: Paolo Bonzini <pbonzini@redhat.com>
>=20
> makes me think either Paolo should pick it up, or he should tell you =
to
> post a pull request yourself.

True, but we are still waiting for formal (I hope)
reviewed-by for the block-related patches.

Pavel Dovgalyuk
