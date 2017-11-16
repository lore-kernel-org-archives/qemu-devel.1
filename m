Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFKKK-0006bZ-Dh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFKKG-0006k3-LJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:35:32 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFKKG-0006iR-FB
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:35:28 -0500
Received: by mail-wm0-x22e.google.com with SMTP id z3so10051044wme.5
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 05:35:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171115123520.7464-1-richard.henderson@linaro.org>
References: <20171115123520.7464-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 13:35:06 +0000
Message-ID: <CAFEAcA_kBnLVnjM8vGtGOipJQF6Yj0LRBJkO5RehNMnkTYVvkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/3] tcg: user-mode memory helper
 fixes
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

On 15 November 2017 at 12:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Fixes the issue that Peter found wrt javac on aarch64-linux-user.
>
>
> r~
>
>
> The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:
>
>   Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171115
>
> for you to fetch changes up to 3c5f9c3f35dd3b6d1d1cd68c9d4d86fc3c59c397:
>
>   target/arm: Fix GETPC usage in do_paired_cmpxchg64_l/be (2017-11-15 10:34:33 +0100)
>
> ----------------------------------------------------------------
> User-mode memory helper fixes
>

Applied, thanks.

-- PMM
