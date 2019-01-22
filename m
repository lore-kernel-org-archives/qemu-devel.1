Received: from eggs.gnu.org ([209.51.188.92]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gltyp-0000iW-AK
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gltyn-0005dU-FO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:12:31 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gltym-0005Gz-Ue
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:12:29 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 81so23307261otj.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 03:12:19 -0800 (PST)
MIME-Version: 1.0
References: <1548140916-6923-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1548140916-6923-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 11:12:06 +0000
Message-ID: <CAFEAcA-mWeai8r7cGm7XuMXerEa_38W1giphA9+nhZioeDkwNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/26] qtests, typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, 22 Jan 2019 at 07:08, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 166609e6070fab3424510ac7292ecb585f8b80fb:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-january-17-2019-v2' into staging (2019-01-21 17:53:28 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-22
>
> for you to fetch changes up to f48a79da78eb605bb0977f930ca137e9b8bdede8:
>
>   tests: remove rule for nonexisting qdev-monitor-test (2019-01-22 06:26:33 +0100)
>
> ----------------------------------------------------------------
> - Use more CONFIG Makefile switches for qtests
> - Get rid of global_qtests in some more qtests
> - typedef cleanups
> - Fixes for compiling with Clang
> - Force C standard to gnu99
> - Don't use -nographic in qtests
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
