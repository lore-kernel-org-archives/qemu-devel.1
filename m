Received: from eggs.gnu.org ([2001:4830:134:3::10]:43857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb2s4-0007zT-Ee
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb2ry-00036d-Qy
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:24:08 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb2ry-00036G-L0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:24:02 -0500
Received: by mail-ot0-x22c.google.com with SMTP id a24so10347223otd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 03:24:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 11:23:41 +0000
Message-ID: <CAFEAcA8cL2NJ38xAS8WiH6etJd61MtaFextU4dqrVr9EC05c4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 January 2018 at 17:20, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40=
ac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vnc-20180112-pull-req=
uest' into staging (2018-01-12 16:01:30 +0000)
>
> are available in the Git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 318116a6ff36bee13c725a247a9395e80bcfbd6b:
>
>   slirp: add in6_dhcp_multicast() (2018-01-14 18:16:13 +0100)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (5):
>       slirp: avoid IN6_IS_ADDR_UNSPECIFIED(), rather use in6_zero()
>       slirp: remove unused header
>       slirp: remove unnecessary struct declaration
>       slirp: removed unused code
>       slirp: add in6_dhcp_multicast()


Applied, thanks.

-- PMM
