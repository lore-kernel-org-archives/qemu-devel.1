Received: from eggs.gnu.org ([2001:4830:134:3::10]:46742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOlIA-0002Gf-Hm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOlI9-0006Fi-Du
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:44:34 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOlI9-0006Ee-8P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:44:33 -0400
Received: by mail-ot0-x244.google.com with SMTP id l12-v6so29555692oth.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 07:44:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601135610.16149-1-samuel.thibault@ens-lyon.org>
References: <20180601135610.16149-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 15:44:11 +0100
Message-ID: <CAFEAcA-iAR8k8+163aoipZfNwezT1MrvbOS=+RXq+JK_ZhSsLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9 v2] slirp updates
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

On 1 June 2018 at 14:56, Samuel Thibault <samuel.thibault@ens-lyon.org> wro=
te:
> The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a=
97:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80531-1' into staging (2018-05-31 17:00:55 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 47335eeea8f1d14b7c6a1dd585a25a9166721168:
>
>   slirp/ncsi: add checksum support (2018-05-31 21:19:24 +0200)
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
>
> C=C3=A9dric Le Goater (3):
>   slirp/ncsi: fix "Get Version ID" payload length
>   slirp/ncsi: add a "Get Parameters" response
>   slirp/ncsi: add checksum support
>
> Nia Alarie:
>   net/slirp: Convert atoi to qemu_strtoi to allow error checking

Applied, thanks.

-- PMM
