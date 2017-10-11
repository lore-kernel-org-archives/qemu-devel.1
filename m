Received: from eggs.gnu.org ([2001:4830:134:3::10]:34850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2FmS-0000ji-D1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2FmR-0002bz-HL
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:06:32 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:52307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2FmR-0002bq-At
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:06:31 -0400
Received: by mail-wm0-x229.google.com with SMTP id k4so4159385wmc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 05:06:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 13:06:09 +0100
Message-ID: <CAFEAcA9j-9ksG-RPsQJo9d94p1iN5rwu55vFxsjLx5ZLAWH5YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/20] Queued TCG patches
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

On 10 October 2017 at 20:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
> One trivial cleanup from Jiang.  Cherry-picking half of Emilio's
> patch set that has been reviewed.
>
> Changes since v1:
>   * Dropped 2 mprotect changes that Werrored on w32.
>   * Dropped tcg optimize patch that broke arm32 host.
>
>
> r~
>
>
> The following changes since commit 567d0a19c7998fa366598b83d5a6e5f0759d3ea9:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-10-10 13:25:46 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171010
>
> for you to fetch changes up to 8df8d529ed958de4e23dcbf38bd34eff1a4716f2:
>
>   tcg/mips: delete commented out extern keyword. (2017-10-10 09:45:01 -0700)
>
> ----------------------------------------------------------------
> Queued TCG patches
>

Applied, thanks.

-- PMM
