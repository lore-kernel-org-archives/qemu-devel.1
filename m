Received: from eggs.gnu.org ([2001:4830:134:3::10]:56972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPqka-0000PA-7V
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPqkZ-0000SE-HX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:46:24 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPqkZ-0000Rv-Bn
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:46:23 -0400
Received: by mail-ot0-x241.google.com with SMTP id i19-v6so7383584otk.10
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:46:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604071050.12492-1-famz@redhat.com>
References: <20180604071050.12492-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 15:46:02 +0100
Message-ID: <CAFEAcA_AS76S9fKNvAVzRJEZbLQX_acwyW0irNGMDDgEaMFQRA@mail.gmail.com>
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

On 4 June 2018 at 08:10, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce014=
7a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
010618-1' into staging (2018-06-01 17:32:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-pull-request
>
> for you to fetch changes up to 63dba573fa65bf830ec3f78a8f3a6b0697ce1637:
>
>   docker: Update fedora image to 28 (2018-06-04 14:39:18 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter,
>
> One improvement from Alex and one patch to track the Fedora latest
> release.
>
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (1):
>   tests/docker/Makefile.include: handle empty TARGET_LIST
>
> Fam Zheng (1):
>   docker: Update fedora image to 28
>
>  rules.mak                              | 3 +++
>  tests/docker/Makefile.include          | 2 +-
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>

Applied, thanks.

-- PMM
