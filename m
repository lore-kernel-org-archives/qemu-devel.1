Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enqMh-0003N4-DO
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enqMg-0007Xv-Kd
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:40:39 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:38865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1enqMg-0007XX-EX
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:40:38 -0500
Received: by mail-oi0-x234.google.com with SMTP id j15so7750757oii.5
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 10:40:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219161955.29572-1-stefanha@redhat.com>
References: <20180219161955.29572-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 18:40:17 +0000
Message-ID: <CAFEAcA93R_uLN5tXSUMxhMUvuXGdaW1oiib8UkS_VWZ9pqoL9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Tracing patches
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

On 19 February 2018 at 16:19, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 7f1d87ab0fd94cef5086e2879716958303281054:
>
>   trace: avoid SystemTap "char const" warnings (2018-02-19 13:09:44 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Jon Emil Jahren (2):
>   tracetool: Update argument format regex to non-greedy star
>   tracetool: For ust trace bool type as ctf_integer
>
> Stefan Hajnoczi (1):
>   trace: avoid SystemTap "char const" warnings

Applied, thanks.

-- PMM
