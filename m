Received: from eggs.gnu.org ([2001:4830:134:3::10]:33829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evQ61-0007kU-6K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evQ60-0002sw-B1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:14:45 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evQ60-0002sh-5o
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:14:44 -0400
Received: by mail-ot0-x22c.google.com with SMTP id 108so15840132otv.3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 16:14:23 +0000
Message-ID: <CAFEAcA9cBtOopCaR9XsiUTu_Kmv3VDx0P3e4FzyRLTQgO9qnpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Ui 20180312 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12 March 2018 at 09:13, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180312-pull-request
>
> for you to fetch changes up to f771c5440e04626f1cf9a6a7d1b1c6cd8168cacd:
>
>   qapi: Add device ID and head parameters to screendump (2018-03-12 09:03:15 +0100)
>
> ----------------------------------------------------------------
> gtk,spice: add dmabuf support.
> sdl,vnc,gtk: bugfixes.
> ui/qapi: add device ID and head parameters to screendump.
> build: try improve handling of clang warnings.
>

Applied, thanks.

-- PMM
