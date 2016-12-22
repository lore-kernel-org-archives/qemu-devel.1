Received: from eggs.gnu.org ([2001:4830:134:3::10]:55405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK7Xs-0003eX-GO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK7Xr-00019R-Pd
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:52:48 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cK7Xr-00018m-CY
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:52:47 -0500
Received: by mail-vk0-x22f.google.com with SMTP id x186so167767726vkd.1
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 09:52:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
References: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Dec 2016 17:52:26 +0000
Message-ID: <CAFEAcA8cw=P8muyE5W40-ZDGDOTGupUfqcvJsXNstE6grHFJEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] slirp updates: MIN/MAX,
 tftp dynamic blocks
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

On 20 December 2016 at 23:07, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit 82ecffa8c050bf5bbc13329e9b65eac1caa5b5=
5c:
>
>   Open 2.9 development tree (2016-12-20 16:20:16 +0000)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 9443598d7e2f2c0a6493d97b3f11dd04837b08e8:
>
>   slirp: support dynamic block size for TFTP transfers (2016-12-21 00:02:=
15 +0100)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Herv=C3=A9 Poussineau (1):
>       slirp: support dynamic block size for TFTP transfers
>
> Yuval Shaia (1):
>       slirp, disas: Replace min/max with MIN/MAX macros
>

Applied, thanks.

-- PMM
