Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db9Up-00052P-Cl
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db9Uo-00087O-ES
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:19 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db9Uo-00086e-78
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:18 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y43so157761883wrd.3
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:56:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170728170255.13270-1-eblake@redhat.com>
References: <20170728170255.13270-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 18:55:56 +0100
Message-ID: <CAFEAcA-Y_rWtKPCAqMAtgJ2=YQQNJWsF3j0NiacEVte4ZJgCRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.10 0/1] NBD changes for 2.10-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 July 2017 at 18:02, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 3aabfec2c83da500ae52fc87ff3a0a60718022=
db:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170728' into =
staging (2017-07-28 15:32:44 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-28
>
> for you to fetch changes up to 158b9aa568eabe614d37882dddc2eea534edc7ae:
>
>   nbd: fix memory leak in nbd_opt_go() (2017-07-28 11:58:20 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-07-28
>
> - Philippe Mathieu-Daud=C3=A9 - nbd: fix memory leak in nbd_opt_go()
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       nbd: fix memory leak in nbd_opt_go()
>
>  nbd/client.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
