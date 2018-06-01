Received: from eggs.gnu.org ([2001:4830:134:3::10]:60135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOkSB-00006N-JI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOkSA-0007j2-Oe
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:50:51 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOkSA-0007ig-IC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:50:50 -0400
Received: by mail-ot0-x243.google.com with SMTP id n1-v6so29330001otf.7
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 06:50:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 14:50:29 +0100
Message-ID: <CAFEAcA8w6W546wFg099RWXKPERWeeh96zPiAoQUqSodawXmgDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 31 May 2018 at 20:22, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a97:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180531-1' into staging (2018-05-31 17:00:55 +0100)
>
> are available in the Git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 528e913612bf22661b169018780d8a6fc678c655:
>
>   slirp/ncsi: add checksum support (2018-05-31 20:45:02 +0200)
>
> ----------------------------------------------------------------
> slirp updates
>
> Alexey Kardashevskiy
>   slirp: Improve debugging messages
>
> Andreas Gustafsson, Samuel Thibault, James Clarke
>   slirp: Improve bandwidth in GDB remote debugging and FreeBSD guests
>
> Benjamin Drung:
>   slirp/dhcp: Add domainname option

Hi; it looks like you forgot to add your signed-off-by to this
patch from Benjamin. Could you add it and respin, please?
(You can just send the pullreq cover letter, no need to re-email
the individual patches.)

thanks
-- PMM
