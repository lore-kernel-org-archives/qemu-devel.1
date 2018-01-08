Received: from eggs.gnu.org ([2001:4830:134:3::10]:56265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYeYb-0000iJ-Oc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYeYV-0003xq-Vd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:02:09 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:40902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYeYV-0003wq-QH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:02:03 -0500
Received: by mail-oi0-x22a.google.com with SMTP id u83so122793oie.7
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:02:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171229205605.21108-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
	<20171229205605.21108-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 21:01:42 +0000
Message-ID: <CAFEAcA9CVrcRKKXkgNVyB+vH+E7Q8YktORC9NrSmk0j9nJyLEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] tcg queued patches
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

On 29 December 2017 at 20:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Ho hum.  While rebasing I accidentally used a constrained build
> tree that didn't build sh4-linux-user, and an extra reference to
> the removed TCGV_IS_UNUSED had crept in in the meantime.
>
> I have pushed a revised tag with the same name.
>
>
> r~
>
>
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171229
>
> for you to fetch changes up to 4fad446bc955fcaa08a21388cf82268824bea10e:
>
>   tcg: add cs_base and flags to -d exec output (2017-12-29 12:43:40 -0800)
>

Applied, thanks.

-- PMM
