Received: from eggs.gnu.org ([2001:4830:134:3::10]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb5dp-0000sb-VZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb5dp-0005WM-48
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:53:54 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb5do-0005TT-Ul
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:53:53 -0400
Received: by mail-oi0-x236.google.com with SMTP id r16-v6so17419134oie.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 07:53:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704090642.3469-1-alex.bennee@linaro.org>
References: <20180704090642.3469-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 15:53:31 +0100
Message-ID: <CAFEAcA-PoR6FBpnyodwTqSh5Y24euirBDGa_d=doUYgyUHn1yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/20] Travis,
 Code Coverage and Cross Build updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On 4 July 2018 at 10:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 2a018f6e98782a4931b936a3087404ed81685b=
ac:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-r=
equest' into staging (2018-07-03 23:06:18 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-t=
weaks-040718-2
>
> for you to fetch changes up to a785003b11220afebae929b5c52f3b69bbfc4a40:
>
>   docker: add linux-user powered cross builder for QEMU (2018-07-04 09:30=
:33 +0100)
>
> ----------------------------------------------------------------
> Code coverage and other build tweaks
>
>   - revert 208ecb3e (and drop filter for mingw)
>   - some travis speed-ups
>   - modernise code coverage support
>   - docker image cleanups
>   - clean-up binfmt_misc docker infrastructure
>   - add debian-powerpc-user-cross image for ppc32 build
>

Alex said on IRC there's some sort of problem with this; dropping
and waiting for a v3.

thanks
-- PMM
