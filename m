Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJv8-0000j2-TR
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJv7-0006Mi-Tl
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:07:38 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:35141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZJv7-0006MQ-PF
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:07:37 -0500
Received: by mail-ua0-x235.google.com with SMTP id y9so14625513uae.2
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:07:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201132456.11406-1-stefanha@redhat.com>
References: <20170201132456.11406-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 16:07:16 +0000
Message-ID: <CAFEAcA8DispSgt8ABVCTOtQbt153qVXk0wO+afunQNsZahFyZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
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

On 1 February 2017 at 13:24, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git block-pull-request
>
> for you to fetch changes up to 81a9f2cb9336a7e9f50b0729b4c81d287e0015e9:
>
>   iothread: enable AioContext polling by default (2017-01-31 17:09:34 +0000)

git claims not to be able to find "block-pull-request",
and https://github.com/stefanha/qemu/tags says it was
pushed 7 days ago with a different commit hash to the
one quoted here. Forgot to tag? Forgot to push?

thanks
-- PMM
