Received: from eggs.gnu.org ([209.51.188.92]:49910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtEgX-000391-Gb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtEgW-0003KB-8e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:43:57 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtEgW-0002y4-2P
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:43:56 -0500
Received: by mail-ot1-x334.google.com with SMTP id 98so5913313oty.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20190211130507.8710-1-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 16:08:18 +0000
Message-ID: <CAFEAcA9bjbXzGShTcMAgMMah=YWR2zaeRQQP1z86xJTs6wR4_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] testing updates:
 travis/cirrus/vm-test/binfmt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Feb 2019 at 13:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit e47f81b617684c4546af286d307b69014a8353=
8a:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2019-02-07 18:53:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-110219-1
>
> for you to fetch changes up to 920fff9093db26f3e74858e3d4182b74a6da7496:
>
>   tests/vm: Be verbose while extracting compressed images (2019-02-11 12:=
47:08 +0000)
>
> ----------------------------------------------------------------
> Testing updates:
>
>   - .travis.yml tweaks and optimisations
>   - .cirrus.yml enabled for FreeBSD CI
>   - docker.py clean-ups for binfmt_misc
>   - more control of vm-test builds
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
