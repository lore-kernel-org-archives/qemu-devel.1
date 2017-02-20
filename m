Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cft4v-0000aZ-DB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cft4u-00034v-A9
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:53 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cft4u-00034D-4J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:52 -0500
Received: by mail-wr0-x22b.google.com with SMTP id 89so64940126wrr.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 10:52:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487597638-28323-1-git-send-email-armbru@redhat.com>
References: <1487597638-28323-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:52:30 +0000
Message-ID: <CAFEAcA8T1cHdxR3dTMiCVbD0rQktLkKawUkG6n5o=7OwQz1=9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] QAPI patches for 2017-02-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2017 at 13:33, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit d514cfd763b271b4e97a9fc6adaabc8fd50084=
ab:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-02-20 09:53:59 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-20
>
> for you to fetch changes up to fea346f569d4132296f7c26367374fcace80e096:
>
>   Makefile: Put VERSION info into version.texi rather than using -D (2017=
-02-20 14:11:07 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-02-20
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       qapi2texi: replace quotation by bold section name
>
> Peter Maydell (1):
>       Makefile: Put VERSION info into version.texi rather than using -D
>
>  .gitignore             |  1 +
>  Makefile               | 17 ++++++++++-------
>  docs/qemu-ga-ref.texi  |  2 ++
>  docs/qemu-qmp-ref.texi |  2 ++
>  scripts/qapi2texi.py   | 10 ++++------
>  5 files changed, 19 insertions(+), 13 deletions(-)
>
> Marc-Andr=C3=A9 Lureau (1):
>   qapi2texi: replace quotation by bold section name
>
> Peter Maydell (1):
>   Makefile: Put VERSION info into version.texi rather than using -D
>

Applied, thanks.

-- PMM
