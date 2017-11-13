Received: from eggs.gnu.org ([2001:4830:134:3::10]:41005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBbX-0005Fo-Mk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBbX-0006id-0g
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:04:35 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEBbW-0006hm-OR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:04:34 -0500
Received: by mail-wm0-x231.google.com with SMTP id z3so3775860wme.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 02:04:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108192043.10682-1-stefanha@redhat.com>
References: <20171108192043.10682-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 10:04:13 +0000
Message-ID: <CAFEAcA8TgNKbBkSizoarUkv5dtA0qsmV7s6bnaUFeYCy2kCF1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11-rc1 v2 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 November 2017 at 19:20, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ef6dada8b44e1e7c4bec5c1115903af9af415b50:
>
>   util/async: use atomic_mb_set in qemu_bh_cancel (2017-11-08 19:09:15 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * v1 emails 2/3 and 3/3 weren't sent due to an email failure
>  * Included Sergio's updated wording in the commit description
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
