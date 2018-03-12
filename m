Received: from eggs.gnu.org ([2001:4830:134:3::10]:44674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evSIX-0008EQ-P2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evSIW-0005Rb-Vs
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:49 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:40423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evSIW-0005RK-Pc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:48 -0400
Received: by mail-oi0-x236.google.com with SMTP id c12so13154436oic.7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 18:35:27 +0000
Message-ID: <CAFEAcA-dZ+E_fQJ7MUXuAC5aCHFCeE+gurWMiNBkmmTLYC6-xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Audio 20180312 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 10:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20180312-pull-request
>
> for you to fetch changes up to 051c7d5c1e2f4a392a4b89027b27aa4c50c16fe0:
>
>   audio/sdl: build as module (2018-03-12 11:18:27 +0100)
>
> ----------------------------------------------------------------
> modules: use gmodule-export.
> audio: add driver registry, enable module builds.
>
> ----------------------------------------------------------------
>
Applied, thanks.

-- PMM
