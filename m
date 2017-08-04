Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddaXi-0003oi-9Y
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddaWZ-0006B7-VW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:13:17 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddaCn-0004Zx-41
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:51:45 -0400
Received: by mail-wm0-x232.google.com with SMTP id t201so16697306wmt.0
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 03:51:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802222810.605-1-samuel.thibault@ens-lyon.org>
References: <20170802222810.605-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 11:51:23 +0100
Message-ID: <CAFEAcA-u=uHPZCzBNgU3ZbjzUNG1xppLNUwznFOcMqf8jR281Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] slirp updates
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

On 2 August 2017 at 23:28, Samuel Thibault <samuel.thibault@ens-lyon.org> w=
rote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519=
c8:
>
>   Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 413d463f43fbc4dd3a601e80a5724aa384a265a0:
>
>   slirp: check len against dhcp options array end (2017-08-03 00:26:44 +0=
200)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Herv=C3=A9 Poussineau (1):
>       slirp: fill error when failing to initialize user network
>
> Prasad J Pandit (1):
>       slirp: check len against dhcp options array end
>
>  net/slirp.c   | 134 ++++++++++++++++++++++++++++++++++++++++------------=
------
>  slirp/bootp.c |   3 ++
>  2 files changed, 97 insertions(+), 40 deletions(-)

Applied, thanks.

-- PMM
