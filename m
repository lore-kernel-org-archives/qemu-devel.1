Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4P89-0006k6-Vb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4P88-0005yj-W3
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:29:50 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:49417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4P88-0005yR-PX
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:29:48 -0400
Received: by mail-wm0-x236.google.com with SMTP id b189so2850110wmd.4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 03:29:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016151337.4121-1-groug@kaod.org>
References: <20171016151337.4121-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 11:29:27 +0100
Message-ID: <CAFEAcA-zJufMH4WJFAoR0pTD75mR6n69wCH8SMQ39E65y5ubVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9pfs patches for 2.11 20171016
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2017 at 16:13, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 40a1e8ac2e10155b5df13a2508ac080b00cd7e23:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/vu-pull-request' into staging (2017-10-16 10:22:39 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7bd92756303f2158a68d5166264dc30139b813b6:
>
>   9pfs: use g_malloc0 to allocate space for xattr (2017-10-16 14:21:59 +0200)
>
> ----------------------------------------------------------------
> This fixes a potential data leak to the guest.
>
> ----------------------------------------------------------------
> Prasad J Pandit (1):
>       9pfs: use g_malloc0 to allocate space for xattr

Applied, thanks.

-- PMM
