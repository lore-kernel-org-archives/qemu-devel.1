Received: from eggs.gnu.org ([209.51.188.92]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzfYK-0005C6-88
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzfYJ-0004PA-E7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:38:04 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzfYI-0004Oe-NT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:38:03 -0500
Received: by mail-oi1-x22a.google.com with SMTP id w66so19095789oia.4
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:38:02 -0800 (PST)
MIME-Version: 1.0
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 10:37:50 +0000
Message-ID: <CAFEAcA-MANLjgcKts4zxfTNQC9FyPM+9U2P4JpRroP3jgFnA7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] MAINTAINERS, test and m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Feb 2019 at 12:28, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit adf2e451f357e993f173ba9b4176dbf3e65fee7e:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-26 19:04:47 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-02-28
>
> for you to fetch changes up to 9f04e1d9547224a935778c1935c605d607299070:
>
>   hw/m68k/mcf5208: Support loading of bios images (2019-02-28 12:18:18 +0100)
>
> ----------------------------------------------------------------
> - Updates to MAINTAINERS file
> - Re-enable the guest-agent test
> - Add the possibility to load a bios image on the mcf5208evb machine
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
