Received: from eggs.gnu.org ([2001:4830:134:3::10]:41094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv0bB-0003v6-Sn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv0bA-0003Jj-SC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:56:41 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv0bA-0003IE-Lg
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:56:40 -0400
Received: by mail-wr0-x231.google.com with SMTP id k6so160920386wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:56:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403102803.31820-1-kraxel@redhat.com>
References: <20170403102803.31820-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 12:56:18 +0100
Message-ID: <CAFEAcA-3t-vA2n+mSY==SxZs6btKbHzGqzT=X7QN923Su-WNzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] bugfixes: xhci,
 input-linux and vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 April 2017 at 11:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Bugfix collection for the next 2.9-rc.
>
> please pull,
>   Gerd
>
> The following changes since commit 95b31d709ba343ad237c3630047ee7438bac40=
65:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201703=
31.0' into staging (2017-03-31 18:06:13 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-fixes-20170403-1
>
> for you to fetch changes up to fa03cb7fd212bc07f0253db9ea436383ddc6c08f:
>
>   vnc: allow to connect with add_client when -vnc none (2017-04-03 11:48:=
55 +0200)
>
> ----------------------------------------------------------------
> bugfixes: xhci, input-linux and vnc
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       xhci: flush dequeue pointer to endpoint context
>
> Javier Celaya (1):
>       Fix input-linux reading from device
>
> Marc-Andr=C3=A9 Lureau (1):
>       vnc: allow to connect with add_client when -vnc none

Applied, thanks.

-- PMM
