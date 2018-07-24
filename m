Received: from eggs.gnu.org ([2001:4830:134:3::10]:46015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhy85-0004ye-7J
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhy84-0004LX-1h
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:17:32 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:43002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhy83-0004LL-JY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:17:31 -0400
Received: by mail-oi0-x22e.google.com with SMTP id n84-v6so7741182oib.9
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:17:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 15:17:10 +0100
Message-ID: <CAFEAcA9sVXEpzGwq1ciq0S5RU6gQRN_H3Z27jyfQjjsgyDaTPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for 3.0 00/17] docker fixes and tcg test
 tweak
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

On 24 July 2018 at 11:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea4=
77:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2018-07-24 10:37:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-docker-fixes-for-3.0-2407=
18-1
>
> for you to fetch changes up to 1a3bdc6111482fbb41eacacf850002e4589a81ef:
>
>   tests/tcg: remove runcom test (2018-07-24 11:45:25 +0100)
>
> ----------------------------------------------------------------
> docker fixes & tcg test tweak
>
>   - graceful handling of testing under cross-compile
>   - fixes for debootstrap handling
>   - more helpful errors (binfmt_misc/EXECUTABLE missing)
>   - drop runcom TCG test
>

Applied, thanks.

-- PMM
