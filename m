Received: from eggs.gnu.org ([2001:4830:134:3::10]:41533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTsFj-0003xU-Nc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTsFj-0000Ew-18
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:43:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTsFf-0000AG-0p
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:43:24 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so12382308otr.10
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 09:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20181203165810.14509-1-kwolf@redhat.com>
In-Reply-To: <20181203165810.14509-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 17:43:08 +0000
Message-ID: <CAFEAcA9Lh=udRRLhXhMuU2hBNK6s-f0AbU3g8eN_QdVb+bbgzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches
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

On Mon, 3 Dec 2018 at 16:58, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 83ea23cd207a03c5736be0231acbf7f8b05dbf52:
>
>   i386: hvf: Fix overrun of _decode_tbl1 (2018-12-03 15:09:55 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to db5e8210adbafe9c6383d8364345a8c545d38e62:
>
>   iotests: simple mirror test with kvm on 1G image (2018-12-03 16:51:53 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - mirror: Fix deadlock
>

Applied, thanks.

-- PMM
