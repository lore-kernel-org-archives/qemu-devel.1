Received: from eggs.gnu.org ([2001:4830:134:3::10]:53831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEWkU-0004qC-85
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEWkT-0001Ij-At
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:39:14 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEWkT-0001I1-3s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:39:13 -0500
Received: by mail-wm0-x244.google.com with SMTP id g141so20099560wmg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 00:39:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171110134254.25031-1-famz@redhat.com>
References: <20171110134254.25031-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 08:38:51 +0000
Message-ID: <CAFEAcA8jUpROBYL637gh-ir8ja0kUKbUGOxoKtz+ARW7Dfj2cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Docker patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 November 2017 at 13:42, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-pull-request
>
> for you to fetch changes up to 6423795efc5b665c595d9a0bf93cfbbca00362e9:
>
>   docker: correctly escape $BACKEND in the help output (2017-11-08 10:59:=
42 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter,
>
> Here are two fixes on docker testing (the one saying "improved" is to
> make it actually "correct"). Thanks.
>
> Fam
>
> ----------------------------------------------------------------
>
> Fam Zheng (1):
>   docker: Improved image checksum
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   docker: correctly escape $BACKEND in the help output
>
>  tests/docker/Makefile.include |  2 +-
>  tests/docker/docker.py        | 24 +++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
>

Applied, thanks.

-- PMM
