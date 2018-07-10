Received: from eggs.gnu.org ([2001:4830:134:3::10]:43050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwIw-0002Qv-8J
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwIv-0005U3-Ch
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:19:58 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:37358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcwIv-0005TD-7M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:19:57 -0400
Received: by mail-oi0-x230.google.com with SMTP id k81-v6so44086283oib.4
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 10:19:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 18:19:36 +0100
Message-ID: <CAFEAcA_fnUJ-gpOb8RgD+dicxG+-MgokMz9RTv0O9pKwKVf7ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 July 2018 at 16:42, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit b34181056c04e05db6c632063012beaee7006a37:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-sh4-20180709' into staging (2018-07-09 22:44:22 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to cd47d792d7a27a57f4b621e2ff1ed8f4e83de1e9:
>
>   block: Use common write req handling in truncate (2018-07-10 16:46:22 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Copy offloading fixes for when the copy increases the image size
> - Temporary revert of the removal of deprecated -drive options
> - Fix request serialisation in the image fleecing scenario
> - Fix copy-on-read crash with unaligned image size
> - Fix another drain crash
>
> ----------------------------------------------------------------



Applied, thanks.

-- PMM
