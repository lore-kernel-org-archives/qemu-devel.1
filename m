Received: from eggs.gnu.org ([2001:4830:134:3::10]:55492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejU1n-0004W0-D1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejU1m-0000T3-He
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:01:03 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejU1m-0000Sq-CW
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:01:02 -0500
Received: by mail-oi0-x22f.google.com with SMTP id c189so1314791oib.12
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:01:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206195044.8347-1-armbru@redhat.com>
References: <20180206195044.8347-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 18:00:40 +0000
Message-ID: <CAFEAcA_E8qrHds6ewZo-A2R0uqCjSw8jyMPAukh4cMggfU9iFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Error reporting patches for 2018-02-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 19:50, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c68962:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into staging (2018-02-06 14:21:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-02-06
>
> for you to fetch changes up to 493d89bf74d17fa304b7a02f531b024df2003fea:
>
>   tcg: Replace fprintf(stderr, "*\n" with error_report() (2018-02-06 18:29:46 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2018-02-06
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
