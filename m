Received: from eggs.gnu.org ([209.51.188.92]:37869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpW41-0001XG-PT
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpW40-0004AB-Ts
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:28:49 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpW40-000453-L0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:28:48 -0500
Received: by mail-oi1-x236.google.com with SMTP id y1so5339610oie.12
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 02:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20190131005945.20149-1-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 10:28:24 +0000
Message-ID: <CAFEAcA_XZpJMYxUoM4TvCVu+GqdARgdnr=xEGs+Lgcz8ZwyODg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Thu, 31 Jan 2019 at 00:59, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f40e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190129' into staging (2019-01-29 12:00:19 +0000)
>
> are available in the Git repository at:
>
>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-01-31
>
> for you to fetch changes up to 908b30164bbffad7430d551b2a03a8fbcaa631ef:
>
>   iotests: Allow 147 to be run concurrently (2019-01-31 00:44:55 +0100)
>
> ----------------------------------------------------------------
> Block patches:
> - New debugging QMP command to explore block graphs
> - Converted DPRINTF()s to trace events
> - Fixed qemu-io's use of getopt() for systems with optreset
> - Minor NVMe emulation fixes
> - An iotest fix
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
