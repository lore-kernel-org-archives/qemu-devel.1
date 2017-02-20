Received: from eggs.gnu.org ([2001:4830:134:3::10]:58727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfqsQ-0005ZC-5i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfqsP-0004vh-1w
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:31:50 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfqsO-0004vO-R5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:31:48 -0500
Received: by mail-wr0-x236.google.com with SMTP id s27so20456264wrb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 08:31:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487591031-28991-1-git-send-email-kraxel@redhat.com>
References: <1487591031-28991-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 16:31:27 +0000
Message-ID: <CAFEAcA_gWV8ggLMk5ATBLKSi10aE+hZdZTaJkKkGugR7uQn+5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] input patch queue
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

On 20 February 2017 at 11:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the input patch queue, fixing a ps/2 bug and finally merging the
> wctablet (2016 gsoc project).
>
> please pull,
>   Gerd
>
> The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-input-20170220-1
>
> for you to fetch changes up to 378af96155d62d90c876ee5e7648803247f1d864:
>
>   Add wctablet device (2017-02-20 11:26:28 +0100)
>
> ----------------------------------------------------------------
> input: add wctablet, ps2 fix
>
> ----------------------------------------------------------------
> Anatoli Huseu1 (1):
>       Add wctablet device
>
> Fabian Lesniak (1):
>       ps2: fix mouse mappings for right/middle button

Applied, thanks.

-- PMM
