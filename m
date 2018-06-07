Received: from eggs.gnu.org ([2001:4830:134:3::10]:38401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQppX-0002jm-2s
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQppW-0002r1-4G
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:59:35 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:42407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQppV-0002pL-N8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:59:34 -0400
Received: by mail-oi0-x22e.google.com with SMTP id k190-v6so7757580oib.9
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 00:59:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 08:59:12 +0100
Message-ID: <CAFEAcA-k7qy9Tg=r=rHup=QNzWWihg0S1EvK93+r2tzTtizhLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Some docker updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 5 June 2018 at 17:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 1d889f2a8baaa265939b339d2f52ec57f5b8a0=
9c:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-06-05 15:22:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-docker-updates-050618-1
>
> for you to fetch changes up to 36dc5fedab0339afdeb3c40ff820c7e5ce334751:
>
>   docker: add debian/tricore image (2018-06-05 16:25:43 +0100)
>
> ----------------------------------------------------------------
> Docker related updates
>
>   - configure/probe for docker
>   - TARGET_DIRS -> TARGET_LIST cleanup
>   - new fedora-i386-cross and debian/tricore images
>   - test-mingw use SDL2/GTK3
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
