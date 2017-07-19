Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXpBg-0006Dc-9U
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXpBf-0004YP-Bk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:38:48 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXpBf-0004Y5-49
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:38:47 -0400
Received: by mail-wr0-x233.google.com with SMTP id 33so2178488wrz.4
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:38:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718161230.21917-1-jsnow@redhat.com>
References: <20170718161230.21917-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 14:38:25 +0100
Message-ID: <CAFEAcA96GGXLHVfJOW+gb4NrT4y9dzHrhPo3gkBnv0Hn63TLYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 17:12, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 368e708b4c95501574ab11632c7a0b8bb3ddc7e8:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-07-18 15:24:11 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to ff0ca962345ecdb87c331888a806cde49936fd9f:
>
>   tests/ahci-test: Be mean with RAM (2017-07-18 11:47:57 -0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (1):
>   tests/ahci-test: Be mean with RAM
>
> John Snow (3):
>   ahci: add ahci_get_num_ports
>   ahci: Isolate public AHCI interface
>   ahci: split public and private interface

Applied, thanks.

-- PMM
