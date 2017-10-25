Received: from eggs.gnu.org ([2001:4830:134:3::10]:54071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Qxx-0003NK-HH
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Qxw-0002J4-Qu
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:03:49 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:50232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7Qxw-0002Ia-J4
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:03:48 -0400
Received: by mail-wr0-x22c.google.com with SMTP id p96so988863wrb.7
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 12:03:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 20:03:26 +0100
Message-ID: <CAFEAcA85d8qB71wczyfXuqjq9h2SfW2NF=cR+digk13Wo9FwUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/51] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 October 2017 at 10:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Primarily Emilio's work toward removing tb_lock, with fixes.
> But there are some other tcg-related patches that are queued.
>
>
> r~
>
>
> The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171025
>
> for you to fetch changes up to cc689485ee3e9dca05765326ee8fd619a6ec48f0:
>
>   translate-all: exit from tb_phys_invalidate if qht_remove fails (2017-10-24 13:53:42 -0700)
>
> ----------------------------------------------------------------
> TCG patch queue
>

Applied, thanks.

-- PMM
