Received: from eggs.gnu.org ([2001:4830:134:3::10]:57046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evjCy-0003Lo-Ae
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evjCx-0000ff-Dm
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:39:12 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evjCx-0000fR-8Y
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:39:11 -0400
Received: by mail-ot0-x244.google.com with SMTP id 95so18760871ote.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:39:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312172640.15647-1-famz@redhat.com>
References: <20180312172640.15647-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 12:38:50 +0000
Message-ID: <CAFEAcA9CfsSSSX-8VOUkSRW6Jff80DV-D-J=LFWcvfEkYUPxVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Docker patches
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

On 12 March 2018 at 17:26, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit b16a54da0696efc5d91b6c3597a37a317abb5d=
e7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180312-pull-requ=
est' into staging (2018-03-12 14:06:23 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to 02f769b7ee72aa962ee22de64c14414298237da5:
>
>   tests: make docker-test-debug@fedora run sanitizers (2018-03-13 01:19:5=
6 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   tests: make docker-test-debug@fedora run sanitizers
>
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  tests/docker/test-debug                | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
