Received: from eggs.gnu.org ([2001:4830:134:3::10]:40060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9WX-0008HR-Rq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9WX-00048A-03
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:43:41 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD9WW-000471-Q5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:43:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id p23so29974040otf.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:43:19 +0100
Message-ID: <CAFEAcA95jZ0zMLfY5nzc5x-u3O_vUvXUoGKtziLRs6XkH=y5AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] qtest and misc patches
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

On 17 October 2018 at 11:04, Thomas Huth <thuth@redhat.com> wrote:
>  Hi Peter,
>
> the following changes since commit dddb37495b844270088e68e3bf30b764d48d863f:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20181015.0' into staging (2018-10-15 18:44:04 +0100)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2018-10-17
>
> for you to fetch changes up to 7fc527cdc9cfd139dee1d90e3220a884229a7698:
>
>   configure: remove glib_subprocess check (2018-10-17 09:01:41 +0200)
>
> ----------------------------------------------------------------
> - Updates for qtest entries in test/Makefile.include
> - Simple updates for some shell scripts
> - Misc simple patches for files without regular subsystem pull requests
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
