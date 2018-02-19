Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eni2T-0002uA-3F
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eni2S-0006W0-9n
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:47:13 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:41639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eni2S-0006Vh-49
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:47:12 -0500
Received: by mail-oi0-x22d.google.com with SMTP id e10so3300453oiy.8
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:47:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216174640.21765-1-dgilbert@redhat.com>
References: <20180216174640.21765-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 09:46:50 +0000
Message-ID: <CAFEAcA96Edf=LmVrg1PBcM=xSEZcHVvb=0AZ_AMfWfs4gGY_TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, t.pagef.lt@gmail.com

On 16 February 2018 at 17:46, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 5e8d6a12d643a38b82a0a713a77d1192117dbdca:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180216-pull-request' into staging (2018-02-16 15:55:45 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20180216
>
> for you to fetch changes up to bf67f1c0b16c0de43b8a10cb53808dd62b0cdc04:
>
>   monitor.c: Fix infinite loop in monitor's auto-complete (2018-02-16 17:36:16 +0000)
>
> ----------------------------------------------------------------
> HMP pull 2018-02-16
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       monitor.c: Fix infinite loop in monitor's auto-complete
>
> Thomas Huth (1):
>       monitor: Remove legacy "-mon default=on" parameter

Applied, thanks.

-- PMM
