Received: from eggs.gnu.org ([209.51.188.92]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhUV-00076E-E1
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhUS-0003Ri-PO
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:07:51 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:41351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBhUS-0003LY-H7
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:07:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id 64so15669177otb.8
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 08:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190403100505.7550-1-cohuck@redhat.com>
In-Reply-To: <20190403100505.7550-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 22:07:35 +0700
Message-ID: <CAFEAcA-N=28tgOYa6euwybLP0DdJoU2jSnqzVUBqL5PMfasF8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-4.0 0/4] s390x gcc 9 warning fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 3 Apr 2019 at 17:05, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763fb:
>
>   Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190403
>
> for you to fetch changes up to 7357b2215978debf2fd17b525ba745d3c69272a3:
>
>   hw/s390x/3270-ccw: avoid taking address of fields in packed struct (2019-04-03 11:19:57 +0200)
>
> ----------------------------------------------------------------
> Fix taking address of fields in packed structs warnings
> by gcc 9
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
