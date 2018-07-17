Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffMhQ-0007Op-6q
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffMhP-0006Wz-Cf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:55:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffMhO-0006Wd-RH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:55:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so882994oib.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 02:55:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
References: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 10:54:53 +0100
Message-ID: <CAFEAcA98eGMn9s1Xw3kB2oWfxR-5uSUNZOr8dzz1JwBPb8L_Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-3.0 0/2] qemu-ga patch queue for
 hard-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 July 2018 at 22:44, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit 102ad0a80f5110483efd06877c29c4236be267=
f9:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-07-16'=
 into staging (2018-07-16 15:34:38 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-16-tag
>
> for you to fetch changes up to d9c745c1768727aadd77e352c85114bc61e67bd4:
>
>   qga: fix file descriptor leak (2018-07-16 15:05:58 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * fix file descriptor leak in suspend command
> * fix leak in guest-get-fsinfo
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       qga: fix 'driver' leak in guest-get-fsinfo
>
> Paolo Bonzini (1):
>       qga: fix file descriptor leak
>
>  qga/commands-posix.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- PMM
